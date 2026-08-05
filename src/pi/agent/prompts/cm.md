---
description: Customize models — add, modify, list, clean up, or clear
argument-hint: "<instructions> | list | clean up [provider-and/or-model] | clear [provider-and/or-model]"
---

Customize models in `~/.pi/agent/models.json`: add or override model metadata, inspect the config, remove metadata Pi now provides, or clear it. `/model` reloads the file when opened.

<instructions>
$@
</instructions>

Follow exactly one matching section: `list`, `clean up`, or `clear`; otherwise use **Add or modify**. If the provider, model, or intended change is ambiguous, ask me — don't guess.

## Add or modify

First read `~/.pi/agent/models.json` (if it exists) to see what's already configured, then follow these steps.

### 1. Get metadata

Fetch it in this order, stopping at the first that works:

1. [models.dev](https://models.dev/) — `https://models.dev/api.json` lists every provider and model. My instructions may not match the keys exactly; find the right entry yourself by id, name, or alias.
2. Other sources — the provider's official docs, API reference, or release notes (search the web as needed).

For a modification, fetch only what the requested change needs and trust existing fields I'm not touching. For an addition, if nothing yields the essentials (context window, max output, reasoning, input modalities, pricing), report what's missing and ask me.

### 2. Write it

Understand the `models.json` format from Pi's docs, then choose the right mechanism:

- **Modifying a built-in (or extension-registered) model?** Prefer `modelOverrides` on its provider — it patches only the given fields while Pi keeps its built-in metadata for the rest. Redeclare the model in `models` only when the change can't be expressed as an override.
- **Adding a model?** If the provider is built-in, merge only the model into its `models` array. Otherwise add a full provider config (`baseUrl`, `api`, `apiKey`, etc.), inferring the API type from the provider's SDK/API style.
- Merge non-destructively: preserve existing providers, models, and overrides; upsert by model `id`; keep valid JSON. For a modification, change only the requested fields.

### 3. Report

Confirm the provider, model, mechanism used (`modelOverrides` vs. `models`), what was added or changed, key metadata and its source, and any API key env var to set. Note that `/model` reloads the file on open; if the model is unavailable it usually just needs provider auth.

## List

If the instruction is `list`:

- Read `~/.pi/agent/models.json` and show the configured providers with their models, `modelOverrides`, and basic info (id, context window, max output, reasoning, modalities).
- If the file is missing or empty, say so, and stop.

## Clean up

If the instruction starts with `clean up`:

- Read `~/.pi/agent/models.json`; if missing or empty, say so and stop. Run `pi update --models`; if it fails, stop without editing.
- For the requested provider/model, or everything by default, compare with Pi's effective metadata while ignoring `models.json`: bundled data plus applicable `models-store.json` overlays, using Pi's precedence.
- Remove matching fields from `modelOverrides`; remove a `models` entry only when its normalized metadata fully matches. Preserve differences, unknown models, partial entries, and provider-level settings.
- Prune empty structures, delete the file if empty, report the result, and stop.

## Clear

If the instruction starts with `clear`:

- With nothing after it, run `rm -f ~/.pi/agent/models.json`, confirm, and stop.
- With a provider and/or model after it, remove just what's specified from `~/.pi/agent/models.json` — a single model, or a whole provider (drop a provider left with no models, overrides, or other settings), keeping valid JSON. If nothing is left, delete the file. Confirm and stop.
