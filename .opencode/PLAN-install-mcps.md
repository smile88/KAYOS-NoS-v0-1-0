# Plan: Install & Activate MCP Servers for Agentic Game Dev

## Current State

**MCP Servers already configured in opencode:**
- `godot` (Coding-Solo) — project level ✓
- `pencil` — global level ✓

**Skills already installed:** 34 total (31 from `~/.agentskills/` + 3 Godot-specific)

**On your system but NOT wired into opencode:**
- `sequential-thinking` binary at `/opt/homebrew/bin/mcp-server-sequential-thinking`

---

## What We're Adding

### MCP Servers (6 total: 1 reuse + 5 new)

| # | Server | Install Method | Cost | Purpose |
|---|--------|---------------|------|---------|
| 1 | **sequential-thinking** | Reuse existing binary | Free | Chain-of-thought reasoning for architecture/debugging |
| 2 | **context7** | `npx -y @upstash/context7-mcp@latest` | Free | Live Godot/GDScript docs lookup, prevents hallucinated APIs |
| 3 | **memory** | `npx -y @modelcontextprotocol/server-memory` | Free | Knowledge graph memory across sessions |
| 4 | **ddg-search** | `uvx duckduckgo-mcp-server` | Free, no API key | Unlimited web search for Godot solutions |
| 5 | **fetch** | `uvx mcp-server-fetch` | Free | Pull web content as markdown (tutorials, docs) |
| 6 | **GDAI** | Godot plugin + MCP server | Needs verification | Auto-screenshots of editor/game, input simulation |

### Skills — Already Complete
No new skills needed. You have 34 installed including:
- `godot-game-dev` — General Godot 4 dev
- `godot-gdscript-patterns` — GDScript patterns & optimization
- `godot-remote-executor` — Execute GDScript on live editor via Hastur

---

## Implementation Steps

### Step 1: Backup current config
```bash
cp opencode.json opencode.json.bak
```

### Step 2: Edit `opencode.json` to add 5 MCP servers

Add to the existing `mcp` block:
```json
{
  "$schema": "https://opencode.ai/config.json",
  "mcp": {
    "godot": {
      "type": "local",
      "command": ["node", "/opt/homebrew/opt/godot-mcp/build/index.js"],
      "enabled": true,
      "env": {
        "GODOT_PATH": "/Applications/Godot_4.7.app/Contents/MacOS/Godot",
        "DEBUG": "true"
      }
    },
    "sequential-thinking": {
      "type": "local",
      "command": ["/opt/homebrew/bin/mcp-server-sequential-thinking"],
      "enabled": true
    },
    "context7": {
      "type": "local",
      "command": ["npx", "-y", "@upstash/context7-mcp@latest"],
      "enabled": true
    },
    "memory": {
      "type": "local",
      "command": ["npx", "-y", "@modelcontextprotocol/server-memory"],
      "enabled": true
    },
    "ddg-search": {
      "type": "local",
      "command": ["uvx", "duckduckgo-mcp-server"],
      "enabled": true
    },
    "fetch": {
      "type": "local",
      "command": ["uvx", "mcp-server-fetch"],
      "enabled": true
    }
  }
}
```

### Step 3: Verify GDAI MCP availability
- Check if the plugin is free or requires purchase at gdaimcp.com
- If free: clone repo, install Godot plugin, add MCP server config
- If paid: skip and document as optional upgrade

### Step 4: Test each server
Restart opencode and verify each MCP server connects:
- sequential-thinking: ask a complex architecture question
- context7: ask "what Godot class handles 2D physics collisions?"
- memory: store a project decision, verify it persists
- ddg-search: search "Godot 4.7 dialogue manager best practices"
- fetch: fetch a Godot tutorial URL
- godot: run the project (already working)

---

## Token Budget Impact

| Server | Approx Tools | Token Cost/Turn |
|--------|-------------|-----------------|
| godot (existing) | ~60 | ~6K |
| sequential-thinking | 1 | ~500 |
| context7 | 2 | ~1K |
| memory | 5 | ~2.5K |
| ddg-search | 3 | ~1.5K |
| fetch | 1 | ~500 |
| **Total new** | **12** | **~6K** |
| **Grand total** | **~72** | **~12K** |

12K tokens/turn for tool definitions is reasonable for a coding agent.

---

## Notes

- All servers are free, no API keys required (except optional Context7 key for higher rate limits)
- `npx` and `uvx` will auto-download packages on first run (one-time cost)
- The `~/.agentskills/` shared hub means Claude Code, Gemini, and opencode all share the same skills
- The existing `pencil` server is already configured globally — no changes needed
