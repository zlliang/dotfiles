import { CustomEditor } from "@earendil-works/pi-coding-agent";
import { truncateToWidth, visibleWidth } from "@earendil-works/pi-tui";

import type { Model } from "@earendil-works/pi-ai";
import type { ExtensionContext, ExtensionAPI, KeybindingsManager } from "@earendil-works/pi-coding-agent";
import type { TUI, EditorTheme } from "@earendil-works/pi-tui";

const SPINNER_FRAMES = ["⠋", "⠙", "⠚", "⠞", "⠖", "⠦", "⠴", "⠲", "⠳", "⠓"];
const SPINNER_INTERVAL = 100;

function formatModel(model: Model<any> | undefined, thinkingLevel: string): string {
	return model ? `${model.provider} • ${model.id} • ${thinkingLevel}` : "no-model";
}

class EditorState {
	private tui: TUI | undefined;
	private working: boolean = false;
	private spinnerFrame: number = 0;
	private spinnerTimer: ReturnType<typeof setInterval> | undefined;

	setTUI(tui: TUI): void {
		this.tui = tui;
	}

	isWorking(): boolean {
		return this.working;
	}

	getSpinnerText(): string {
		return SPINNER_FRAMES[this.spinnerFrame];
	}

	dispose(): void {
		this.stopSpinner();
		this.tui = undefined;
	}

	startSpinner(): void {
		this.stopSpinner();

		this.working = true;
		this.spinnerTimer = setInterval(() => {
			this.spinnerFrame = (this.spinnerFrame + 1) % SPINNER_FRAMES.length;
			this.requestRender();
		}, SPINNER_INTERVAL);

		this.requestRender();
	}

	stopSpinner(): void {
		this.working = false;
		this.spinnerFrame = 0;
		if (this.spinnerTimer) {
			clearInterval(this.spinnerTimer);
			this.spinnerTimer = undefined;
		}

		this.requestRender();
	}

	requestRender(): void {
		this.tui?.requestRender();
	}
}

class Editor extends CustomEditor {
	private editorState: EditorState;
	private pi: ExtensionAPI;
	private ctx: ExtensionContext;

	constructor(tui: TUI, theme: EditorTheme, keybindings: KeybindingsManager, editorState: EditorState, pi: ExtensionAPI, ctx: ExtensionContext) {
		super(tui, theme, keybindings);

		this.editorState = editorState;
		this.editorState.setTUI(tui);

		this.pi = pi;
		this.ctx = ctx;
	}

	render(width: number): string[] {
		const lines = super.render(width);
		if (lines.length === 0) return lines;

		lines[0] = this.renderTopBorder(width);

		return lines;
	}

	private renderTopBorder(width: number): string {
		if (width <= 2) return this.borderColor("─".repeat(width));

		const theme = this.ctx.ui.theme;

		const left = this.editorState.isWorking() ? ` ${theme.fg("accent", this.editorState.getSpinnerText())} ` : "";
		const right = theme.fg("dim", ` ${formatModel(this.ctx.model, this.pi.getThinkingLevel())} `);

		const contentWidth = width - 2;
		const gapWidth = 1;

		const leftWidth = visibleWidth(left);
		const rightWidth = visibleWidth(right);
		const ellipsis = theme.fg("dim", "... ");

		if (leftWidth >= contentWidth) return this.wrapTopBorder(truncateToWidth(left, contentWidth, ellipsis));

		const availableRightWidth = contentWidth - gapWidth - leftWidth;
		if (availableRightWidth <= 5) return this.wrapTopBorder(`${left}${this.borderColor("─".repeat(contentWidth - leftWidth))}`);

		const renderedRight = rightWidth > availableRightWidth ? truncateToWidth(right, availableRightWidth, ellipsis) : right;
		const renderedRightWidth = visibleWidth(renderedRight);
		const spacer = this.borderColor("─".repeat(contentWidth - leftWidth - renderedRightWidth));

		return this.wrapTopBorder(`${left}${spacer}${renderedRight}`);
	}

	private wrapTopBorder(text: string): string {
		return `${this.borderColor("─")}${text}${this.borderColor("─")}`
	}
}

export default function (pi: ExtensionAPI) {
	const editorState = new EditorState();

	pi.on("session_start", (_event, ctx) => {
		if (!ctx.hasUI) return;

		ctx.ui.setWorkingVisible(false);
		ctx.ui.setEditorComponent((tui, theme, keybindings) => new Editor(tui, theme, keybindings, editorState, pi, ctx));
	});

	pi.on("agent_start", () => {
		editorState.startSpinner();
	});

	pi.on("agent_end", () => {
		editorState.stopSpinner();
	});

	pi.on("session_shutdown", () => {
		editorState.dispose();
	});
}
