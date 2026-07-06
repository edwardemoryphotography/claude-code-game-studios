# Claude Code Game Studios — Game Studio Agent Architecture

Indie game development managed through **49 coordinated Claude Code subagents**.
Each agent owns a specific domain, enforcing separation of concerns and quality gates.

> **Stats**: 49 agents · 101 skills · 12 hooks · 8+ path-scoped rules · 39 document templates

---

## Technology Stack

- **Engine**: [CHOOSE: Godot 4 / Unity / Unreal Engine 5]
- **Language**: [CHOOSE: GDScript / C# / C++ / Blueprint]
- **Version Control**: Git with trunk-based development
- **Build System**: [SPECIFY after choosing engine]
- **Asset Pipeline**: [SPECIFY after choosing engine]

> **Note**: Engine-specialist agents exist for Godot 4, Unity, and Unreal Engine 5 with dedicated sub-specialists. Use the agent set matching your chosen engine.

---

## First Session?

If no engine is configured and no game concept exists, run `/start` to begin guided onboarding. Otherwise jump directly to a skill:

- `/brainstorm` — explore game ideas from scratch
- `/setup-engine godot 4.6` — configure engine if you know it
- `/project-stage-detect` — analyze an existing project
- `/adopt` — retrofit this framework onto an existing codebase

---

## Project Structure

@.claude/docs/directory-structure.md

```
CLAUDE.md                           # Master configuration (this file)
.claude/
  settings.json                     # Hooks, permissions, safety rules
  agents/                           # 49 agent definitions (.md + YAML frontmatter)
  skills/                           # 101 slash commands (one subdirectory per skill)
  hooks/                            # 12 bash hook scripts
  rules/                            # 11 path-scoped coding standards
  statusline.sh                     # Status line (context%, model, stage, epic breadcrumb)
  docs/
    workflow-catalog.yaml           # 7-phase pipeline (read by /help)
    templates/                      # 39 document templates
    *.md                            # Reference docs (agent-roster, skills-reference, hooks-reference, etc.)
src/                                # Game source code (empty until /start)
assets/                             # Art, audio, VFX, shaders, data
design/                             # GDDs, narrative docs, level designs
docs/                               # Technical docs, ADRs, engine reference
tests/                              # Unit, integration, performance, playtest suites
tools/                              # Build and pipeline tools
prototypes/                         # Throwaway prototypes (isolated from src/)
production/                         # Sprint plans, milestones, release tracking
```

---

## Agent Hierarchy

Three tiers mirror a real studio structure:

```
Tier 1 — Directors (Opus)          Vision, architecture, scheduling
  creative-director                 Creative vision, tone, player experience
  technical-director                Architecture, tech stack, performance
  producer                          Scheduling, risk, cross-department coordination

Tier 2 — Department Leads (Sonnet) Own their domain end-to-end
  game-designer     lead-programmer     art-director
  audio-director    narrative-director  qa-lead
  release-manager   localization-lead

Tier 3 — Specialists (Sonnet/Haiku) Hands-on implementation
  gameplay-programmer   engine-programmer    ai-programmer
  network-programmer    tools-programmer     ui-programmer
  systems-designer      level-designer       economy-designer
  technical-artist      sound-designer       writer
  world-builder         ux-designer          prototyper
  performance-analyst   devops-engineer      analytics-engineer
  security-engineer     qa-tester            accessibility-specialist
  live-ops-designer     community-manager
```

### Engine Specialists (pick one set)

| Engine | Lead | Sub-Specialists |
|--------|------|-----------------|
| **Godot 4** | `godot-specialist` | gdscript, shader, gdextension, csharp |
| **Unity** | `unity-specialist` | dots, shader/vfx, addressables, ui-toolkit |
| **Unreal Engine 5** | `unreal-specialist` | gas, blueprints, replication, umg/commonui |

Full agent directory and usage guidance: @.claude/docs/agent-roster.md

---

## Slash Commands (101 Skills)

**Onboarding & Navigation**
`/start` `/help` `/project-stage-detect` `/setup-engine` `/adopt` `/init`

**Game Design**
`/brainstorm` `/map-systems` `/design-system` `/quick-design` `/review-all-gdds` `/propagate-design-change`

**Art & Assets**
`/art-bible` `/asset-spec` `/asset-audit`

**UX & Interface Design**
`/ux-design` `/ux-review`

**Architecture**
`/create-architecture` `/architecture-decision` `/architecture-review` `/create-control-manifest`

**Stories & Sprints**
`/create-epics` `/create-stories` `/dev-story` `/sprint-plan` `/sprint-status` `/story-readiness` `/story-done` `/estimate`

**Reviews & Analysis**
`/design-review` `/code-review` `/balance-check` `/content-audit` `/scope-check` `/perf-profile` `/tech-debt` `/gate-check` `/consistency-check`

**QA & Testing**
`/qa-plan` `/smoke-check` `/soak-test` `/regression-suite` `/test-setup` `/test-helpers` `/test-evidence-review` `/test-flakiness` `/skill-test` `/skill-improve`

**Production**
`/milestone-review` `/retrospective` `/bug-report` `/bug-triage` `/reverse-document` `/playtest-report`

**Release**
`/release-checklist` `/launch-checklist` `/changelog` `/patch-notes` `/hotfix` `/day-one-patch`

**Creative & Content**
`/prototype` `/onboard` `/localize`

**Team Orchestration** (coordinate multiple agents on one feature)
`/team-combat` `/team-narrative` `/team-ui` `/team-release` `/team-polish` `/team-audio` `/team-level` `/team-live-ops` `/team-qa`

**General-Purpose Agent Utilities** (uncataloged — not part of the phase-gated pipeline; ported from [davidondrej/skills](https://github.com/davidondrej/skills))
`/agent-self-scheduling` `/cmux` `/codex-goal-loop` `/delegating-to-agents` `/handoff` `/markdown-rendering` `/run-deep-swe` `/anti-sleep` `/cyber-audit` `/pi-custom-model` `/setup-help` `/vps-server-management` `/browser-harness` `/deep-research` `/deepapi` `/pi-web-search` `/research-prompt` `/youtube-transcript` `/distribute-skill-to-all-agents` `/effective-agent-skills` `/folder-specific-claude-and-agents-md` `/push-skill-to-github` `/brain-to-docs` `/copywriting` `/grill-me` `/interview-style-doc-building` `/read-all-adrs` `/short` `/teach`

Full skill catalog: @.claude/docs/skills-reference.md

---

## Automated Hooks (12)

| Hook | Trigger | What It Does |
|------|---------|-------------|
| `session-start.sh` | Session open | Shows branch, recent commits |
| `detect-gaps.sh` | Session open | Suggests `/start` on fresh projects; warns on missing design docs |
| `validate-commit.sh` | PreToolUse (Bash) | Checks hardcoded values, TODO format, JSON validity — exits early if not a `git commit` |
| `validate-push.sh` | PreToolUse (Bash) | Warns on pushes to protected branches — exits early if not a `git push` |
| `validate-assets.sh` | PostToolUse (Write/Edit) | Validates naming conventions and JSON in `assets/` — exits early if file not in `assets/` |
| `validate-skill-change.sh` | PostToolUse (Write/Edit) | Advises `/skill-test` after changes to `.claude/skills/` |
| `pre-compact.sh` | Before compaction | Preserves session progress notes |
| `post-compact.sh` | After compaction | Reminds Claude to restore state from `active.md` |
| `notify.sh` | Notification event | Windows toast via PowerShell |
| `session-stop.sh` | Session close | Archives `active.md` to session log, records git activity |
| `log-agent.sh` | Agent spawned | Audit trail — logs subagent invocation |
| `log-agent-stop.sh` | Agent stops | Audit trail — completes subagent record |

Full hook reference: @.claude/docs/hooks-reference.md

---

## Path-Scoped Coding Rules

| Path | Enforces |
|------|----------|
| `src/gameplay/**` | Data-driven values, delta-time usage, no UI references |
| `src/core/**` | Zero allocations in hot paths, thread safety, stable API |
| `src/ai/**` | Performance budgets, debuggability, data-driven parameters |
| `src/networking/**` | Server-authoritative, versioned messages, security |
| `src/ui/**` | No game state ownership, localization-ready, accessible |
| `design/gdd/**` | Required 8 sections, formula format, edge cases documented |
| `tests/**` | Test naming conventions, coverage requirements, fixture patterns |
| `prototypes/**` | Relaxed standards; README required; hypothesis documented |

Full rules reference: @.claude/docs/rules-reference.md

---

## Collaboration Protocol

**User-driven, not autonomous.** Every task follows:
**Question → Options → Decision → Draft → Approval**

- Agents **must ask** "May I write this to `[filepath]`?" before using Write/Edit tools.
- Agents **must show** drafts or summaries before requesting approval.
- Multi-file changes require **explicit approval for the full changeset**.
- **No commits** without user instruction.

Full protocol: `docs/COLLABORATIVE-DESIGN-PRINCIPLE.md`

---

## Permissions (from settings.json)

**Auto-allowed** (no prompt):
`git status`, `git diff`, `git log`, `git branch`, `git rev-parse`, `ls`, `dir`, `python -m json.tool`, `pytest`

**Blocked**:
`rm -rf`, `git push --force`, `git reset --hard`, `git clean -f`, `sudo`, `chmod 777`, writing to `.env` files, reading `.env` files

---

## Engine Version Reference

@docs/engine-reference/godot/VERSION.md

---

## Technical Preferences

@.claude/docs/technical-preferences.md

---

## Coordination Rules

@.claude/docs/coordination-rules.md

---

## Coding Standards

@.claude/docs/coding-standards.md

---

## Context Management

@.claude/docs/context-management.md

---

## Review Mode

Set during `/start` or edit `production/review-mode.txt`:

| Mode | Gate behaviour |
|------|----------------|
| `full` | All director gates active |
| `lean` | Phase gates only |
| `solo` | No gates |

Override per run: append `--review solo` to any skill invocation.

---

## Setup Requirements

- [Git](https://git-scm.com/)
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) (`npm install -g @anthropic-ai/claude-code`)
- **Optional**: `jq` (hook JSON validation) and Python 3 (JSON validation)

All hooks fail gracefully when optional tools are absent.

Full requirements: @.claude/docs/setup-requirements.md
