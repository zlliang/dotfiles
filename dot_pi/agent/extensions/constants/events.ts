import type { Usage } from "@earendil-works/pi-ai";

export const USAGE_APPEND = "zlliang:usage:append" as const;
export const USAGE_REQUEST = "zlliang:usage:request" as const;
export const USAGE_SNAPSHOT = "zlliang:usage:snapshot" as const;

export type UsageAppendEvent = {
	source: string;
	provider?: string;
	model?: string;
	usage: Usage;
	timestamp?: number;
};

export type UsageSnapshotEvent = {
	total: Usage;
	bySource: Record<string, Usage>;
};
