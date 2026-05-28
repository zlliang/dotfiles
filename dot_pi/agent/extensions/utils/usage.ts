import { USAGE_APPEND, USAGE_REQUEST, USAGE_SNAPSHOT } from "../constants/events";
import { USAGE_ENTRY } from "../constants/entries";

import type { AgentMessage } from "@earendil-works/pi-agent-core";
import type { AssistantMessage, Usage } from "@earendil-works/pi-ai";
import type { ExtensionAPI, ExtensionContext, SessionEntry } from "@earendil-works/pi-coding-agent";
import type { UsageAppendEvent, UsageSnapshotEvent } from "../constants/events";

export class UsageStore {
	private pi: ExtensionAPI;
	private snapshot: UsageSnapshotEvent = createSnapshot();
	private unsubscribeAppend: (() => void) | undefined;
	private unsubscribeRequest: (() => void) | undefined;

	constructor(pi: ExtensionAPI) {
		this.pi = pi;
	}

	start(ctx: ExtensionContext): void {
		this.rebuild(ctx);
		this.subscribe();
		this.publish();
	}

	dispose(): void {
		this.unsubscribe();
		this.snapshot = createSnapshot();
	}

	refresh(ctx: ExtensionContext): void {
		this.rebuild(ctx);
		this.publish();
	}

	appendPiUsage(message: AgentMessage): void {
		if (!isAssistantMessageWithUsage(message)) return;

		this.addUsage({
			source: "pi",
			provider: message.provider,
			model: message.model,
			usage: message.usage,
			timestamp: Date.now(),
		});

		this.publish();
	}

	private rebuild(ctx: ExtensionContext): void {
		const snapshot = createSnapshot();
		for (const entry of ctx.sessionManager.getBranch()) {
			this.addEntryUsage(snapshot, entry);
		}

		this.snapshot = snapshot;
	}

	private subscribe(): void {
		this.unsubscribe();

		this.unsubscribeAppend = this.pi.events.on(USAGE_APPEND, (data) => {
			const event = normalizeUsageAppendEvent(data);
			if (!event) return;

			this.pi.appendEntry(USAGE_ENTRY, event);
			this.addUsage(event);
			this.publish();
		});

		this.unsubscribeRequest = this.pi.events.on(USAGE_REQUEST, () => {
			this.publish();
		});
	}

	private unsubscribe(): void {
		this.unsubscribeAppend?.();
		this.unsubscribeRequest?.();
		this.unsubscribeAppend = undefined;
		this.unsubscribeRequest = undefined;
	}

	private addEntryUsage(snapshot: UsageSnapshotEvent, entry: SessionEntry): void {
		if (entry.type === "message") {
			const message = entry.message;
			if (!isAssistantMessageWithUsage(message)) return;

			addToSnapshot(snapshot, {
				source: "pi",
				provider: message.provider,
				model: message.model,
				usage: message.usage,
			});

			return;
		}

		if (entry.type === "custom" && entry.customType === USAGE_ENTRY) {
			const event = normalizeUsageAppendEvent(entry.data);
			if (!event) return;

			addToSnapshot(snapshot, event);
		}
	}

	private addUsage(event: UsageAppendEvent): void {
		addToSnapshot(this.snapshot, event);
	}

	private publish(): void {
		this.pi.events.emit(USAGE_SNAPSHOT, this.snapshot);
	}
}

export class UsageProducer {
	private pi: ExtensionAPI;
	private source: string;

	constructor(pi: ExtensionAPI, source: string) {
		this.pi = pi;
		this.source = source;
	}

	produce(usage: Usage, options: Omit<UsageAppendEvent, "source" | "usage"> = {}): void {
		this.pi.events.emit(USAGE_APPEND, {
			...options,
			source: this.source,
			usage,
		});
	}
}

export class UsageConsumer {
	private pi: ExtensionAPI;
	private usageSnapshot: UsageSnapshotEvent | undefined;
	private unsubscribeSnapshot: (() => void) | undefined;

	constructor(pi: ExtensionAPI) {
		this.pi = pi;
	}

	get snapshot(): UsageSnapshotEvent | undefined {
		return this.usageSnapshot;
	}

	subscribe(): void {
		this.unsubscribe();
		this.usageSnapshot = undefined;
		this.unsubscribeSnapshot = this.pi.events.on(USAGE_SNAPSHOT, (data) => {
			if (isUsageSnapshotEvent(data)) this.usageSnapshot = data;
		});
		this.pi.events.emit(USAGE_REQUEST, undefined);
	}

	unsubscribe(): void {
		this.unsubscribeSnapshot?.();
		this.unsubscribeSnapshot = undefined;
		this.usageSnapshot = undefined;
	}
}

export function emptyUsage(): Usage {
	return {
		input: 0,
		output: 0,
		cacheRead: 0,
		cacheWrite: 0,
		totalTokens: 0,
		cost: {
			input: 0,
			output: 0,
			cacheRead: 0,
			cacheWrite: 0,
			total: 0,
		},
	};
}

export function addUsage(a: Usage, b: Usage): Usage {
	return {
		input: a.input + b.input,
		output: a.output + b.output,
		cacheRead: a.cacheRead + b.cacheRead,
		cacheWrite: a.cacheWrite + b.cacheWrite,
		totalTokens: a.totalTokens + b.totalTokens,
		cost: {
			input: a.cost.input + b.cost.input,
			output: a.cost.output + b.cost.output,
			cacheRead: a.cost.cacheRead + b.cost.cacheRead,
			cacheWrite: a.cost.cacheWrite + b.cost.cacheWrite,
			total: a.cost.total + b.cost.total,
		},
	};
}

export function normalizeUsageAppendEvent(value: unknown): UsageAppendEvent | undefined {
	if (!isUsageAppendEvent(value)) return undefined;

	return {
		source: value.source.trim(),
		...(value.provider !== undefined && { provider: value.provider }),
		...(value.model !== undefined && { model: value.model }),
		usage: value.usage,
		timestamp: value.timestamp ?? Date.now(),
	};
}

function createSnapshot(): UsageSnapshotEvent {
	return {
		total: emptyUsage(),
		bySource: {},
	};
}

function addToSnapshot(snapshot: UsageSnapshotEvent, event: UsageAppendEvent): void {
	snapshot.total = addUsage(snapshot.total, event.usage);
	snapshot.bySource[event.source] = addUsage(snapshot.bySource[event.source] ?? emptyUsage(), event.usage);
}

function isAssistantMessageWithUsage(message: AgentMessage): message is AssistantMessage {
	return !!message && typeof message === "object" && message.role === "assistant" && "usage" in message;
}

function isUsageAppendEvent(value: unknown): value is UsageAppendEvent {
	if (!value || typeof value !== "object") return false;

	const event = value as Partial<UsageAppendEvent>;
	if (typeof event.source !== "string" || event.source.trim() === "") return false;
	if (event.provider !== undefined && typeof event.provider !== "string") return false;
	if (event.model !== undefined && typeof event.model !== "string") return false;
	if (event.timestamp !== undefined && !isFiniteNumber(event.timestamp)) return false;

	return isUsage(event.usage);
}

function isUsageSnapshotEvent(value: unknown): value is UsageSnapshotEvent {
	if (!value || typeof value !== "object") return false;

	const snapshot = value as Partial<UsageSnapshotEvent>;
	return isUsage(snapshot.total) && isUsageRecord(snapshot.bySource);
}

function isUsageRecord(value: unknown): value is Record<string, Usage> {
	if (!value || typeof value !== "object") return false;
	return Object.values(value).every(isUsage);
}

function isUsage(value: unknown): value is Usage {
	if (!value || typeof value !== "object") return false;

	const usage = value as Partial<Usage>;
	if (!isFiniteNumber(usage.input)) return false;
	if (!isFiniteNumber(usage.output)) return false;
	if (!isFiniteNumber(usage.cacheRead)) return false;
	if (!isFiniteNumber(usage.cacheWrite)) return false;
	if (!isFiniteNumber(usage.totalTokens)) return false;
	if (!usage.cost || typeof usage.cost !== "object") return false;

	const cost = usage.cost as Partial<Usage["cost"]>;
	if (!isFiniteNumber(cost.input)) return false;
	if (!isFiniteNumber(cost.output)) return false;
	if (!isFiniteNumber(cost.cacheRead)) return false;
	if (!isFiniteNumber(cost.cacheWrite)) return false;
	if (!isFiniteNumber(cost.total)) return false;

	return true;
}

function isFiniteNumber(value: unknown): value is number {
	return typeof value === "number" && Number.isFinite(value);
}
