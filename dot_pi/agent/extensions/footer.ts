import { isAbsolute, relative, resolve, sep } from "node:path";
import { truncateToWidth, visibleWidth } from "@earendil-works/pi-tui";

import { UsageConsumer } from "./utils/usage";

import type { ExtensionContext, ExtensionAPI, ReadonlyFooterDataProvider, Theme } from "@earendil-works/pi-coding-agent";
import type { Component } from "@earendil-works/pi-tui";
import type { UsageSnapshotEvent } from "./constants/events";

// Some of the following logic is adapted from Pi's default footer implementation:
// https://github.com/earendil-works/pi/blob/main/packages/coding-agent/src/modes/interactive/components/footer.ts

class FooterComponent implements Component {
	private ctx: ExtensionContext;
	private theme: Theme;
	private footerData: ReadonlyFooterDataProvider;
	private getUsageSnapshot: () => UsageSnapshotEvent | undefined;

	constructor(ctx: ExtensionContext, theme: Theme, footerData: ReadonlyFooterDataProvider, getUsageSnapshot: () => UsageSnapshotEvent | undefined) {
		this.ctx = ctx;
		this.theme = theme;
		this.footerData = footerData;
		this.getUsageSnapshot = getUsageSnapshot;
	}

	invalidate(): void {
		// No-op
	}

	render(width: number): string[] {
		return [this.renderMainLine(width), this.renderStatusLine(width)].filter(Boolean);
	}

	private renderMainLine(width: number): string {
		const left = this.getLeft();
		const right = this.getRight();

		const gapWidth = 1;

		const leftWidth = visibleWidth(left);
		const rightWidth = visibleWidth(right);
		const ellipsis = this.theme.fg("dim", "...");

		if (rightWidth >= width) return truncateToWidth(right, width, ellipsis);

		const availableLeftWidth = width - gapWidth - rightWidth;
		if (availableLeftWidth <= 5) return `${" ".repeat(width - rightWidth)}${right}`;

		const renderedLeft = leftWidth > availableLeftWidth ? truncateToWidth(left, availableLeftWidth, ellipsis) : left;
		const renderedLeftWidth = visibleWidth(renderedLeft);
		const spacer = " ".repeat(width - renderedLeftWidth - rightWidth);

		return `${renderedLeft}${spacer}${right}`;
	}

	private getLeft(): string {
		let text = formatCwd(this.ctx.sessionManager.getCwd(), process.env.HOME || process.env.USERPROFILE);

		const branch = this.footerData.getGitBranch();
		if (branch) text = `${text} [${branch}]`;

		const sessionName = this.ctx.sessionManager.getSessionName();
		if (sessionName) text = `${text} • ${sessionName}`;

		return this.theme.fg("dim", text);
	}

	private getRight(): string {
		return `${this.getCost()}${this.theme.fg("dim", " • ")}${this.getContextUsage()}`;
	}

	private getCost(): string {
		const usingSubscription = this.ctx.model ? this.ctx.modelRegistry.isUsingOAuth(this.ctx.model) : false;
		const totalCost = this.getUsageSnapshot()?.total.cost.total ?? 0;

		return this.theme.fg("dim", `$${totalCost.toFixed(2)}${usingSubscription ? " (sub)" : ""}`);
	}

	private getContextUsage(): string {
		const contextUsage = this.ctx.getContextUsage();
		const contextTokens = contextUsage?.tokens ?? null;
		const contextWindow = contextUsage?.contextWindow ?? this.ctx.model?.contextWindow ?? null;
		const contextPercentValue = contextUsage?.percent ?? 0;
		const contextPercent = contextUsage?.percent != null ? `${contextPercentValue.toFixed(1)}%` : "?";
		const text = `${contextTokens === null ? "?" : formatTokens(contextTokens)}/${contextWindow === null ? "?" : formatTokens(contextWindow)} (${contextPercent})`;

		return this.styleContextUsage(text, contextPercentValue);
	}

	private styleContextUsage(unstyled: string, contextPercentValue: number): string {
		if (contextPercentValue > 90) return this.theme.fg("error", unstyled);
		if (contextPercentValue > 70) return this.theme.fg("warning", unstyled);
		return this.theme.fg("dim", unstyled);
	}

	/** Add extension statues on a single line, sorted by key alphabetically. */
	private renderStatusLine(width: number): string {
		const extensionStatuses = this.footerData.getExtensionStatuses();
		if (extensionStatuses.size === 0) return "";

		const statusLine = Array.from(extensionStatuses.entries())
			.sort(([a], [b]) => a.localeCompare(b))
			.map(([, text]) => sanitizeStatusText(text))
			.join(this.theme.fg("dim", " • "));

		return truncateToWidth(statusLine, width, this.theme.fg("dim", "..."));
	}
}

/** Replace newlines, tabs, carriage returns with space, then collapse multiple spaces */
function sanitizeStatusText(text: string): string {
	return text
		.replace(/[\r\n\t]/g, " ")
		.replace(/ +/g, " ")
		.trim();
}

function formatTokens(count: number): string {
	if (count < 1_000) return count.toString();
	if (count < 10_000) return `${(count / 1_000).toFixed(1)}K`;
	if (count < 1_000_000) return `${Math.round(count / 1_000)}K`;
	if (count < 10_000_000) return `${(count / 1_000_000).toFixed(1)}M`;
	return `${Math.round(count / 1_000_000)}M`;
}

function formatCwd(cwd: string, home?: string): string {
	if (!home) return cwd;

	const resolvedCwd = resolve(cwd);
	const resolvedHome = resolve(home);
	const relativeToHome = relative(resolvedHome, resolvedCwd);
	const isInsideHome = relativeToHome === "" || (relativeToHome !== ".." && !relativeToHome.startsWith(`..${sep}`) && !isAbsolute(relativeToHome));
	if (!isInsideHome) return cwd;

	return relativeToHome === "" ? "~" : `~${sep}${relativeToHome}`;
}

export default function (pi: ExtensionAPI) {
	const usageConsumer = new UsageConsumer(pi);

	pi.on("session_start", (_event, ctx) => {
		usageConsumer.subscribe();

		if (!ctx.hasUI) return;

		ctx.ui.setFooter((_tui, theme, footerData) => new FooterComponent(ctx, theme, footerData, () => usageConsumer.snapshot));
	});

	pi.on("session_shutdown", () => {
		usageConsumer.unsubscribe();
	});
}
