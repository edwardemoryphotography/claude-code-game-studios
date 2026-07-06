# Available Skills (Slash Commands)

68 slash commands organized by phase, plus 29 uncataloged general-purpose utility skills (see bottom section). Type `/` in Claude Code to access any of them.

## Onboarding & Navigation

| Command | Purpose |
|---------|---------|
| `/start` | First-time onboarding — asks where you are, then guides you to the right workflow |
| `/help` | Context-aware "what do I do next?" — reads current stage and surfaces the required next step |
| `/project-stage-detect` | Full project audit — detect phase, identify existence gaps, recommend next steps |
| `/setup-engine` | Configure engine + version, detect knowledge gaps, populate version-aware reference docs |
| `/adopt` | Brownfield format audit — checks internal structure of existing GDDs/ADRs/stories, produces migration plan |

## Game Design

| Command | Purpose |
|---------|---------|
| `/brainstorm` | Guided ideation using professional studio methods (MDA, SDT, Bartle, verb-first) |
| `/map-systems` | Decompose game concept into systems, map dependencies, prioritize design order |
| `/design-system` | Guided, section-by-section GDD authoring for a single game system |
| `/quick-design` | Lightweight design spec for small changes — tuning, tweaks, minor additions |
| `/review-all-gdds` | Cross-GDD consistency and game design holism review across all design docs |
| `/propagate-design-change` | When a GDD is revised, find affected ADRs and produce an impact report |

## UX & Interface Design

| Command | Purpose |
|---------|---------|
| `/ux-design` | Guided section-by-section UX spec authoring (screen/flow, HUD, or pattern library) |
| `/ux-review` | Validate UX specs for GDD alignment, accessibility, and pattern compliance |

## Architecture

| Command | Purpose |
|---------|---------|
| `/create-architecture` | Guided authoring of the master architecture document |
| `/architecture-decision` | Create an Architecture Decision Record (ADR) |
| `/architecture-review` | Validate all ADRs for completeness, dependency ordering, and GDD coverage |
| `/create-control-manifest` | Generate flat programmer rules sheet from accepted ADRs |

## Stories & Sprints

| Command | Purpose |
|---------|---------|
| `/create-epics` | Translate GDDs + ADRs into epics — one per architectural module |
| `/create-stories` | Break a single epic into implementable story files |
| `/dev-story` | Read a story and implement it — routes to the correct programmer agent |
| `/sprint-plan` | Generate or update a sprint plan; initializes sprint-status.yaml |
| `/sprint-status` | Fast 30-line sprint snapshot (reads sprint-status.yaml) |
| `/story-readiness` | Validate a story is implementation-ready before pickup (READY/NEEDS WORK/BLOCKED) |
| `/story-done` | 8-phase completion review after implementation; updates story file, surfaces next story |
| `/estimate` | Structured effort estimate with complexity, dependencies, and risk breakdown |

## Reviews & Analysis

| Command | Purpose |
|---------|---------|
| `/design-review` | Review a game design document for completeness and consistency |
| `/code-review` | Architectural code review for a file or changeset |
| `/balance-check` | Analyze game balance data, formulas, and config — flag outliers |
| `/asset-audit` | Audit assets for naming conventions, file size budgets, and pipeline compliance |
| `/content-audit` | Audit GDD-specified content counts against implemented content |
| `/scope-check` | Analyze feature or sprint scope against original plan, flag scope creep |
| `/perf-profile` | Structured performance profiling with bottleneck identification |
| `/tech-debt` | Scan, track, prioritize, and report on technical debt |
| `/gate-check` | Validate readiness to advance between development phases (PASS/CONCERNS/FAIL) |
| `/consistency-check` | Scan all GDDs against the entity registry to detect cross-document inconsistencies (stats, names, rules that contradict each other) |

## QA & Testing

| Command | Purpose |
|---------|---------|
| `/qa-plan` | Generate a QA test plan for a sprint or feature |
| `/smoke-check` | Run critical path smoke test gate before QA hand-off |
| `/soak-test` | Generate a soak test protocol for extended play sessions |
| `/regression-suite` | Map test coverage to GDD critical paths, identify fixed bugs without regression tests |
| `/test-setup` | Scaffold the test framework and CI/CD pipeline for the project's engine |
| `/test-helpers` | Generate engine-specific test helper libraries for the test suite |
| `/test-evidence-review` | Quality review of test files and manual evidence documents |
| `/test-flakiness` | Detect non-deterministic (flaky) tests from CI run logs |
| `/skill-test` | Validate skill files for structural compliance and behavioral correctness |

## Production

| Command | Purpose |
|---------|---------|
| `/milestone-review` | Review milestone progress and generate status report |
| `/retrospective` | Run a structured sprint or milestone retrospective |
| `/bug-report` | Create a structured bug report |
| `/bug-triage` | Read all open bugs, re-evaluate priority vs. severity, assign owner and label |
| `/reverse-document` | Generate design or architecture docs from existing implementation |
| `/playtest-report` | Generate a structured playtest report or analyze existing playtest notes |

## Release

| Command | Purpose |
|---------|---------|
| `/release-checklist` | Generate and validate a pre-release checklist for the current build |
| `/launch-checklist` | Complete launch readiness validation across all departments |
| `/changelog` | Auto-generate changelog from git commits and sprint data |
| `/patch-notes` | Generate player-facing patch notes from git history and internal data |
| `/hotfix` | Emergency fix workflow with audit trail, bypassing normal sprint process |

## Creative & Content

| Command | Purpose |
|---------|---------|
| `/prototype` | Rapid throwaway prototype to validate a mechanic (relaxed standards, isolated worktree) |
| `/onboard` | Generate contextual onboarding document for a new contributor or agent |
| `/localize` | Localization workflow: string extraction, validation, translation readiness |

## Team Orchestration

Coordinate multiple agents on a single feature area:

| Command | Coordinates |
|---------|-------------|
| `/team-combat` | game-designer + gameplay-programmer + ai-programmer + technical-artist + sound-designer + qa-tester |
| `/team-narrative` | narrative-director + writer + world-builder + level-designer |
| `/team-ui` | ux-designer + ui-programmer + art-director + accessibility-specialist |
| `/team-release` | release-manager + qa-lead + devops-engineer + producer |
| `/team-polish` | performance-analyst + technical-artist + sound-designer + qa-tester |
| `/team-audio` | audio-director + sound-designer + technical-artist + gameplay-programmer |
| `/team-level` | level-designer + narrative-director + world-builder + art-director + systems-designer + qa-tester |
| `/team-live-ops` | live-ops-designer + economy-designer + community-manager + analytics-engineer |
| `/team-qa` | qa-lead + qa-tester + gameplay-programmer + producer |

## General-Purpose Agent Utilities (Ported, Uncataloged)

These 29 skills were ported from [davidondrej/skills](https://github.com/davidondrej/skills), a
personal power-user skill collection. They are **not part of the phase-gated game dev pipeline**
(`/help` and `/gate-check` ignore them) — they're general Claude Code agent utilities available
alongside the studio-specific skills above.

**Not ported**: `fable-safe-prompt` was excluded — it's designed to rewrite prompts to evade
Claude's safety classifiers on cyber/bio content, which this project will not carry.

**Heads up**: several of these reference tools, accounts, or infrastructure specific to the
original author (his DeepAPI key, his VPS servers, the Pi Agent, cmux, macOS) and will need
adaptation before they're actually usable in this project's environment.

| Command | Purpose |
|---------|---------|
| `/agent-self-scheduling` | Run an agent on a cron/loop/interval — scheduling patterns per agent type |
| `/cmux` | Control macOS cmux terminal workspaces/panes (macOS-only app) |
| `/codex-goal-loop` | Write prompts for OpenAI Codex's `/goal` autonomous agent loop |
| `/delegating-to-agents` | How to route work between Codex/Pi/Claude Code/Hermes agents |
| `/handoff` | Compact a session into a copy-pasteable handoff for a fresh agent |
| `/markdown-rendering` | Workaround for a cmux-specific blank-render bug |
| `/run-deep-swe` | Score a model on the DeepSWE coding benchmark via OpenRouter |
| `/anti-sleep` | Keep a Mac awake via `caffeinate` |
| `/cyber-audit` | Read-only CVE/breach exposure audit of the local machine |
| `/pi-custom-model` | Register a custom model slug in the Pi Agent |
| `/setup-help` | Walk a user through any setup, one step at a time |
| `/vps-server-management` | Manage the author's specific Hostinger VPS servers |
| `/browser-harness` | Direct Chrome control via CDP for scraping/automation |
| `/deep-research` | Run a deep research query via DeepAPI (requires an API key) |
| `/deepapi` | Scrape web pages / send email via DeepAPI (requires an API key) |
| `/pi-web-search` | Web search specifically for Pi Agents |
| `/research-prompt` | Write a one-paragraph research brief for a human/AI researcher |
| `/youtube-transcript` | Fetch a YouTube video transcript (DeepAPI + yt-dlp fallback) |
| `/distribute-skill-to-all-agents` | Sync a skill across multiple personal agent skill folders |
| `/effective-agent-skills` | General guide on how to write good Agent Skills/SKILL.md files |
| `/folder-specific-claude-and-agents-md` | Generate a folder-scoped CLAUDE.md + AGENTS.md |
| `/push-skill-to-github` | Push skill changes to a private skills GitHub repo |
| `/brain-to-docs` | Extract a user's project vision into docs via Q&A |
| `/copywriting` | Copywriting guidance/frameworks (references the original author by name) |
| `/grill-me` | Interrogate the user Socratically to pressure-test a plan or design |
| `/interview-style-doc-building` | Build a doc via back-and-forth interview |
| `/read-all-adrs` | Read all ADRs in a project and summarize them |
| `/short` | Compress the current answer — strip filler, cut length |
| `/teach` | Teach the user a new skill or concept within the workspace |
