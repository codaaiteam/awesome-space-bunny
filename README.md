# Awesome Space Bunny Alpha [![Awesome](https://awesome.re/badge.svg)](https://awesome.re)

> A curated list of everything about the **Space Bunny model** — **Space Bunny Alpha**, the stealth, 1,000,000-token-context **LLM** that appeared on OpenRouter and is being tested across coding agents like **opencode**. How to use it **free**, code examples, and integrations.

**Space Bunny Alpha** (the "Space Bunny model", a.k.a. Space Bunny Alpha model) is an anonymous ("stealth") large language model — a fast, coding-focused **LLM** — available on **OpenRouter** (`stealth/space-bunny-alpha`) since **September 23, 2026**. It has a **1M-token context window**, native multimodal input, adjustable reasoning, strong coding, and is **free during the preview**.

**Try it free in your browser (no signup): [spacebunnymodel.com](https://spacebunnymodel.com)** — an independent playground + OpenAI-compatible API for the model.

> This is a community reference. It is not affiliated with the model's anonymous provider or with OpenRouter.

## Contents

- [At a glance](#at-a-glance)
- [Try it in 30 seconds](#try-it-in-30-seconds)
- [Ways to access it](#ways-to-access-it)
- [Space Bunny Alpha in opencode](#space-bunny-alpha-in-opencode)
- [Is Space Bunny free?](#is-space-bunny-free)
- [Code examples](#code-examples)
- [Use it in your tools](#use-it-in-your-tools)
- [Give your agent a 1M-token tool](#give-your-agent-a-1m-token-tool)
- [What we know (and don't)](#what-we-know-and-dont)
- [What fits in 1M tokens](#what-fits-in-1m-tokens)
- [FAQ](#faq)

## At a glance

| | |
| --- | --- |
| **Model id (OpenRouter)** | `stealth/space-bunny-alpha` |
| **Context window** | 1,000,000 tokens |
| **Max output** | 524,288 tokens |
| **Input** | text · image · audio · video (multimodal) |
| **Reasoning** | adjustable effort (it's a reasoning model) |
| **Price** | free during the OpenRouter preview |
| **Released** | 2026-09-23 |
| **Provider** | anonymous (community reverse-engineering suggests MiniMax M3 — **unconfirmed**) |

## Try it in 30 seconds

- **Browser playground, no signup:** <https://spacebunnymodel.com> — type a prompt, watch it stream from the real API.
- **In your terminal:** grab a free `sb_live_` key at <https://spacebunnymodel.com/get-jev>, then:

```bash
curl https://spacebunnymodel.com/api/v1/chat/completions \
  -H "Authorization: Bearer $SPACE_BUNNY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"model":"space-bunny-alpha","messages":[{"role":"user","content":"Say hi in 5 words."}]}'
```

## Ways to access it

- 🐰 **Free browser playground** — <https://spacebunnymodel.com> (no signup, streamed from the real API)
- 🔑 **Hosted OpenAI-compatible API** — <https://spacebunnymodel.com/get-jev> (one `sb_live_` key, no OpenRouter account, stable model name)
- 🌐 **OpenRouter directly** — model `stealth/space-bunny-alpha` (needs an OpenRouter account; free in preview)
- 🧩 **In your coding agent** — see [Use it in your tools](#use-it-in-your-tools)

## Space Bunny Alpha in opencode

`space bunny opencode` is the most-searched way to use this model — [opencode](https://opencode.ai) is the open-source coding agent everyone's pairing with Space Bunny's free 1M context. Two setups:

**Via OpenRouter** (quickest):

```bash
opencode auth login          # choose OpenRouter, paste your key
opencode                     # then /models  → openrouter/stealth/space-bunny-alpha
```

**Via the hosted endpoint** (no OpenRouter account, stable model name) — add a custom provider in your opencode config:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "spacebunny": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "Space Bunny",
      "options": { "baseURL": "https://spacebunnymodel.com/api/v1", "apiKey": "{env:SPACE_BUNNY_API_KEY}" },
      "models": { "space-bunny-alpha": { "name": "Space Bunny Alpha" } }
    }
  },
  "model": "spacebunny/space-bunny-alpha"
}
```

Full guide: <https://spacebunnymodel.com/integrations/opencode>

## Is Space Bunny free?

Yes — **Space Bunny Alpha is free** during the OpenRouter preview. The easiest free route:

- **Free browser playground, no signup:** <https://spacebunnymodel.com>
- **Free API tier:** grab an `sb_live_` key at <https://spacebunnymodel.com/get-jev> (free credit to start, paid plans for higher limits).
- **Free on OpenRouter:** `stealth/space-bunny-alpha` is $0 during the preview.

Because it's a preview model, this can change — expect a price when it graduates.

## Code examples

Runnable examples live in [`examples/`](examples/):

- [`curl.sh`](examples/curl.sh) — chat + streaming with curl
- [`python_example.py`](examples/python_example.py) — the `openai` SDK, pointed at Space Bunny
- [`typescript_example.ts`](examples/typescript_example.ts) — the `openai` npm SDK
- [`streaming.py`](examples/streaming.py) — token streaming

The API is **OpenAI Chat Completions-compatible**, so any OpenAI SDK works by changing the base URL:

```python
from openai import OpenAI
client = OpenAI(base_url="https://spacebunnymodel.com/api/v1", api_key="sb_live_...")
r = client.chat.completions.create(model="space-bunny-alpha",
    messages=[{"role": "user", "content": "Explain a 1M context window in 3 bullets."}])
print(r.choices[0].message.content)
```

Full API reference: <https://spacebunnymodel.com/docs>

## Use it in your tools

Space Bunny is OpenAI-compatible, so it drops into tools that accept a custom base URL + model:

- **opencode** — <https://spacebunnymodel.com/integrations/opencode> (via our endpoint or OpenRouter)
- **Cursor** — <https://spacebunnymodel.com/integrations/cursor> (Override OpenAI Base URL)
- **Claude Code** — see below (Claude Code can't swap its model, so use the MCP tool)
- **TypeScript / JS SDK** — <https://spacebunnymodel.com/integrations/typescript>
- **OpenRouter** — <https://spacebunnymodel.com/integrations/openrouter>

## Give your agent a 1M-token tool

Agents like **Claude Code** are tied to their own model and can't be pointed at Space Bunny — so give them a **tool** instead. The **[`spacebunny-mcp`](https://github.com/codaaiteam/spacebunny-mcp)** server adds an `ask_space_bunny` action so your agent can offload work that doesn't fit its own context (a whole repo, a long document, hours of transcripts) to Space Bunny's 1M window.

```bash
# Claude Code
claude plugin marketplace add codaaiteam/spacebunny-skill
claude plugin install spacebunny@spacebunny

# Cursor / opencode / any MCP client
npx -y github:codaaiteam/spacebunny-mcp
```

- **[spacebunny-mcp](https://github.com/codaaiteam/spacebunny-mcp)** — zero-dependency MCP server (the `ask_space_bunny` tool)
- **[spacebunny-skill](https://github.com/codaaiteam/spacebunny-skill)** — Claude Code plugin (bundles the tool + a skill that teaches when to use it)
- Guide: <https://spacebunnymodel.com/agent-skill>

## What we know (and don't)

- **Anonymous provider.** OpenRouter routes requests to it but is not its developer. The provider chose to stay anonymous during the preview.
- **The MiniMax M3 theory.** Community reverse-engineering of its tokenizer, error traces and system responses points to **MiniMax M3**. This is **unconfirmed** — treat it as a rumor until an official reveal.
- **Capabilities are observable:** 1M context, 524K max output, multimodal input, adjustable reasoning, strong coding, fast inference, free preview.
- **We do not publish benchmark numbers** for it — the provider is anonymous and nothing official exists yet. Be skeptical of any "official Space Bunny benchmark."

More: [What is Space Bunny Alpha?](https://spacebunnymodel.com/what-is-jev) · [Ecosystem](https://spacebunnymodel.com/ecosystem)

## What fits in 1M tokens

One call can hold roughly:

- **≈ 750,000 words** of text
- an **entire repository** or monorepo slice
- **hours** of meeting/podcast transcripts
- a full set of **API docs + example code**

That's the point: stop chunking, and reason over the whole thing at once.

## FAQ

**Is Space Bunny Alpha free?** Yes, during the OpenRouter preview. The [browser playground](https://spacebunnymodel.com) is free with no signup; the hosted API has a free tier plus paid plans for higher limits.

**Who made it?** Unknown. Reverse-engineering points to MiniMax M3, unconfirmed.

**What's the model id?** `stealth/space-bunny-alpha` on OpenRouter; `space-bunny-alpha` through the [hosted API](https://spacebunnymodel.com/get-jev).

**How do I use it in opencode?** <https://spacebunnymodel.com/integrations/opencode>

**How big is the context window?** 1,000,000 input tokens, up to 524,288 output tokens.

---

Contributions welcome — open a PR to add a resource. Keep it accurate; no fabricated benchmarks, no "official" claims about the anonymous provider.
