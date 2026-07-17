# Tooling & MCP Setup — KAYOS: The Night of Silence

Environment: **iMac M4 (macOS, Apple Silicon)**. Target engine: **Godot 4.7**. Art finishing:
**Affinity (unified "by Canva" app)**. Asset generation: **Nano Banana 2 (Gemini 3 image)**.

This doc records the researched options and the recommended setup for each. Items marked
**⟵ DECISION** need your call before install (cost/credentials).

---

## 1. Godot 4.7

- **Status:** Godot **4.7 stable released 2026-06-18**. You currently have **4.6.1** installed
  (`/Applications/Godot.app`, `4.6.1.stable`).
- **Action:** download Godot 4.7 stable (standard build; GDScript, no C# needed) from
  godotengine.org/download/macos and use it for this project. Existing 4.6 projects (donors) upgrade
  one-way when opened in 4.7 — keep the donors closed and copy art out rather than converting them.
- Project settings for this game (set at Phase 0.1): Compatibility renderer, 960×540 viewport,
  stretch `canvas_items`/`keep`/`integer`, default texture filter **Nearest**.

---

## 2. Godot MCP server

Goal: let Claude Code inspect the live editor scene tree, create/modify scenes and nodes, and run the
project so you can watch results — the engine half of the "RPG Maker MV" workflow.

### Options (2026 landscape)

| Server | Type | Cost | Notes |
|---|---|---|---|
| **Funplay MCP for Godot** | In-editor plugin (addon) | Free (MIT) | One-click Claude Code config from an editor dock; reads scene tree, inspects nodes, runs project, `execute_code`, project maps. Tested on 4.6.3 — **4.7 to verify**. **← recommended free.** |
| **Godot MCP Pro** (youichi-uda) | In-editor plugin | $15 one-time | ~162 tools: scene tree, node CRUD, animation, physics, particles, audio, shaders, input sim, runtime analysis. Most comprehensive. In Godot Asset Library (#4961). |
| **GDAI MCP** | File-level | Freemium | Polished setup; parses scenes, rewrites scripts with project context. Doesn't drive the live editor. |
| **mkdevkit/godot-mcp** | In-editor plugin | Free | Open-source live-editor control for Claude Code/Cursor/Codex. |
| **Coding-Solo/godot-mcp** | Headless CLI | Free | **Already cloned & built** at `~/Projects/godot-mcp`. Launch editor / run project / capture debug output + basic scene ops. Solid fallback. |

### Recommendation ⟵ DECISION
**Default: Funplay MCP (free, in-editor).** It gives the live-editor experience at no cost and
one-click Claude Code setup. If you want maximum tool depth and don't mind $15, **Godot MCP Pro** is
the most capable. Note: because Godot `.tscn/.tres/.gd` are plain text, Claude Code can already author
scenes directly with file tools — the MCP mainly adds live introspection, running, and screenshots.

### Install (Funplay) — done in Phase 0.2, after `godot/` exists
1. Download the Funplay MCP release; copy `addons/funplay_mcp/` into the `godot/` project.
2. Godot → Project → Project Settings → Plugins → enable **Funplay MCP for Godot** (GUI click).
3. In the new "Funplay MCP" dock, click one-click config → select **Claude Code** → confirm
   (writes the token-aware stdio config to the right path). Server runs on `127.0.0.1:8765`.
4. Restart Claude Code; verify it can list the scene tree.
*Fallback if 4.7-incompatible:* register the already-built `~/Projects/godot-mcp/build/index.js` via
`claude mcp add`, and/or author scenes directly as text.

---

## 3. Affinity (art finishing)

You'll do final pixel/vector cleanup in the unified Affinity app (see Asset_Bible.xlsx → AFFINITY
PIPELINE). For AI-driving-Affinity there are options — this is **optional** (the pipeline works
100% by hand):

| Option | What it is | Trust |
|---|---|---|
| **Affinity official "AI Connector"** | First-party AI-automation connector (Affinity Help Center: AI Connector setup) | **Highest — recommend verifying/using this first.** |
| **Canva MCP** (already connected in your Claude) | Controls Canva's web platform (Affinity is now Canva-owned) — **not** the Affinity desktop app | Already live; wrong surface for desktop pixel cleanup. |
| **tacyan/AffinityMCP** | Rust MCP driving Affinity Photo/Designer/Publisher on macOS via natural language | Third-party; unified-app aware; verify before trusting. |
| **sekharmalla/affinity-mcp-server** | macOS AppleScript-driven Affinity control | Third-party. |

### Recommendation ⟵ DECISION
The Affinity cleanup work (silhouette fixes, palette conforming, nearest-neighbour downscale) is
**hand craft** the Bible budgets 20–45 min/sprite for — automation helps little and risks corrupting
pixel work. **Recommend: skip an Affinity MCP for now; use the official AI Connector only if you want
AI assistance inside Affinity later.** Revisit if batch operations (mass magenta-keying, palette
unification across dozens of files) become a bottleneck — then `tacyan/AffinityMCP`'s 16-parallel
batch could pay off.

---

## 4. Nano Banana 2 (asset/sprite generation)

The entire Asset Bible (129 assets) is written for **Nano Banana 2** = Google **Gemini 3.1 Flash
Image**. Several MCP servers expose it to Claude Code.

### The important cost reality ⟵ DECISION
- **Your consumer Gemini Pro plan does NOT cover API image generation.** MCP servers call the
  **Gemini API**, which is billed separately.
- **The Gemini API free tier does not include Nano Banana 2 at all.** NB2 via API is **paid**:
  ~**$0.045–0.151/image** (0.5K→4K); Batch API is ~50% off.
- Rough budget for the whole bible at heavy iteration (~5–10 gens/asset): **~$30–65** total. Cheap for
  the output, but it is real, metered spend and needs a billing-enabled API key.

### Options
| Path | Model | Cost | Fit |
|---|---|---|---|
| **Nano Banana 2 MCP + paid Gemini API key** | Gemini 3.1 Flash Image (+ Pro) | Paid per image | **Best** — exactly what the Bible's prompts + reference-image consistency workflow need. |
| **Google AI Studio (web)** | Nano Banana **1** (Gemini 2.5 Flash Image) | Free, 500/day | Free but manual (no MCP), older model, still very good for pixel base art. |
| **Hugging Face image tools** (already connected in your Claude) | Various (e.g. Z-Image Turbo, HF Spaces) | Free | Free MCP path; less consistent for reference-locked character sprites. |

Recommended MCP server for the paid path: **`zhongweili/nanobanana-mcp-server`** (smart model
selection, up to 4K) or **`mrafaeldie12/nano-banana-pro-mcp`**. Both need a Gemini API key.

### Install (paid path) — when you approve billing
1. Create a Gemini API key at aistudio.google.com with **billing enabled** on the Cloud project.
2. `claude mcp add nanobanana -- npx -y <chosen-nanobanana-mcp>` (or per its README), with
   `GEMINI_API_KEY` in the env. Exact command in the server's README.
3. Verify: ask Claude to generate `CH-001` with the Asset Bible's column-H prompt, save to
   `art/assets_raw/`.

### Recommended hybrid ⟵ DECISION
Use **AI Studio free (NB1)** or **HF free** to prototype/iterate the *look* cheaply, then spend paid
**NB2** only on the assets you're committing to (the ones that become style anchors and finals). This
keeps cost near-zero during exploration and pays only for keepers.

---

## 5. Summary of pending decisions

1. **Godot MCP:** Funplay (free, recommended) vs Godot MCP Pro ($15) vs already-cloned Coding-Solo.
2. **Affinity MCP:** skip for now (recommended) vs set up the official AI Connector vs a third-party.
3. **Nano Banana 2:** approve a paid Gemini API key (best), or start free (AI Studio NB1 / Hugging
   Face) and upgrade later.
4. **Godot 4.7 upgrade:** confirm you want me to proceed on 4.7 (download it) vs stay on 4.6.1.
```
