import { UsageStore } from "./utils/usage";

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
	const store = new UsageStore(pi);

	pi.on("session_start", (_event, ctx) => {
		store.start(ctx);
	});

	pi.on("message_end", (event) => {
		store.appendPiUsage(event.message);
	});

	pi.on("agent_end", (_event, ctx) => {
		store.refresh(ctx);
	});

	pi.on("session_compact", (_event, ctx) => {
		store.refresh(ctx);
	});

	pi.on("session_tree", (_event, ctx) => {
		store.refresh(ctx);
	});

	pi.on("session_shutdown", () => {
		store.dispose();
	});
}
