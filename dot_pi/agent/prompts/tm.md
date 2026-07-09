---
description: Add a not-yet-supported model, or clear the config file or a model
argument-hint: "<provider-and-model> | clear [provider-and/or-model]"
---

Add a model that Pi doesn't yet support to `~/.pi/agent/models.json` so it shows up in `/model`, or remove that file.

Arguments: `$@`.

## Add

The arguments should specify both the provider and the model. If either is missing, ask me — don't guess.

### 1. Get metadata

Fetch it in this order, stopping at the first that works:

1. [models.dev](https://models.dev/) — `https://models.dev/api.json` lists every provider and model. My arguments may not match the keys exactly; find the right entry yourself by id, name, or alias.
2. Other sources — the provider's official docs, API reference, or release notes (search the web as needed).

If nothing yields the essentials (context window, max output, reasoning, input modalities, pricing), report what's missing and ask me.

### 2. Write it

Understand the `models.json` format from Pi's docs, then:

- Map the metadata to Pi's model fields.
- If the provider is built-in, merge only the model into its `models` array (Pi reuses its baseUrl/api/auth). Otherwise add a full provider config (`baseUrl`, `api`, `apiKey`, etc.), inferring the API type from the provider's SDK/API style.
- Merge non-destructively: preserve existing providers/models, upsert by model `id`, keep valid JSON.

### 3. Report

Confirm the provider, model, API type, key metadata and its source, and any API key env var to set. Note that `/model` reloads the file on open; if the model is unavailable it usually just needs provider auth.

## Clear

If the first argument is `clear`:

- With nothing after it, run `rm -f ~/.pi/agent/models.json`, confirm, and stop.
- With a provider and/or model after it, remove just what's specified from `~/.pi/agent/models.json` — a single model, or a whole provider (drop a provider that ends up empty), keeping valid JSON. Confirm and stop.
