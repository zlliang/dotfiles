import { exec } from "node:child_process";
import { promisify } from "node:util";

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import type { OAuthCredentials, OAuthLoginCallbacks } from "@earendil-works/pi-ai";

export const execAsync = promisify(exec);

const PROVIDER_ID = "booking-genai";
const PROVIDER_NAME = "Booking GenAI";
const ISSUE_TOKEN_SCRIPT_SHORT = "bk auth:issue-token";
const ISSUE_TOKEN_SCRIPT = "bk auth:issue-token || (bk auth:login --skip-okta-auth > /dev/null 2>&1 && bk auth:issue-token)";
const TOKEN_TTL_MS = 50_000; // bk auth:issue-token returns a token with ~1 minute TTL; refresh slightly early to avoid mid-request expiry.

async function issueToken() {
	try {
		const { stdout } = await execAsync(ISSUE_TOKEN_SCRIPT);
		const token = stdout.trim();
		if (!token) throw new Error(`${ISSUE_TOKEN_SCRIPT_SHORT} returned an empty token`);

		return token;
	} catch (error) {
		if (error instanceof Error) {
			throw new Error(`Failed to issue ${PROVIDER_ID} token: ${error.message}`);
		}

		throw error;
	}
}

async function getCredentials(): Promise<OAuthCredentials> {
	const access = await issueToken();

	return {
		refresh: PROVIDER_ID,
		access,
		expires: Date.now() + TOKEN_TTL_MS,
	};
}

async function login(callbacks: OAuthLoginCallbacks): Promise<OAuthCredentials> {
	callbacks.onProgress?.(`\nRunning ${ISSUE_TOKEN_SCRIPT_SHORT}...`);
	return getCredentials();
}

async function refreshToken(): Promise<OAuthCredentials> {
	return getCredentials();
}

export default function (pi: ExtensionAPI) {
	pi.registerProvider(PROVIDER_ID, {
		baseUrl: "https://gen-ai.prod.booking.com/anthropic/claude_code/",
		api: "anthropic-messages",
		models: [
			{
				id: "ml-asset:static-model/claude-opus-4-7",
				name: "Claude Opus 4.7",
				reasoning: true,
				input: ["text", "image"],
				contextWindow: 1_000_000,
				maxTokens: 128_000,
				cost: { input: 5, output: 25, cacheRead: 0.5, cacheWrite: 6.25 },
				compat: { forceAdaptiveThinking: true },
			},
			{
				id: "ml-asset:static-model/claude-sonnet-4-6",
				name: "Claude Sonnet 4.6",
				reasoning: true,
				input: ["text", "image"],
				contextWindow: 1_000_000,
				maxTokens: 64_000,
				cost: { input: 3, output: 15, cacheRead: 0.3, cacheWrite: 3.75 },
				compat: { forceAdaptiveThinking: true },
			},
			{
				id: "ml-asset:static-model/claude-haiku-4-5",
				name: "Claude Haiku 4.5",
				reasoning: true,
				input: ["text", "image"],
				contextWindow: 200_000,
				maxTokens: 64_000,
				cost: { input: 1, output: 5, cacheRead: 0.1, cacheWrite: 1.25 },
			},
		],
		oauth: {
			name: PROVIDER_NAME,
			login,
			refreshToken,
			getApiKey: (credentials) => credentials.access,
		},
	});
}
