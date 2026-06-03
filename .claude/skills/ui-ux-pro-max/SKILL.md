---
name: ui-ux-pro-max
description: "Full-stack UI/UX authoring, review, and orchestration in a single skill. Combines /ux-design (spec authoring), /ux-review (validation), and /team-ui (pipeline coordination) with Pro Max enhancements: design tokens, responsive breakpoints, motion specs, dark/light mode variants, component lifecycle management, A/B test planning, and cross-platform safe zone mapping."
argument-hint: "[screen/flow/hud/tokens/motion/audit/all] [--review] [--team] [--tokens] [--motion]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Task, AskUserQuestion, TodoWrite
agent: ux-designer
---

When this skill is invoked, deliver an end-to-end UI/UX workflow with integrated review and optional team orchestration.

---

## 0. Determine Invocation Mode

Parse the arguments and flags to determine what the user needs:

| Argument | Mode |
|----------|------|
| `hud` | HUD design (full pro-max spec) |
| `tokens` | Design token system only |
| `motion` | Motion & animation design spec only |
| `audit` | Audit all existing UX specs for gaps (report only, no writes) |
| `all` | Full audit + spec all missing screens |
| Any screen/flow name | Full UX spec for that screen |
| No argument | Ask the user (see below) |

| Flag | Behavior |
|------|----------|
| `--review` | Run the integrated review gate after spec is complete |
| `--team` | Spawn the full `/team-ui` pipeline after the spec is approved |
| `--tokens` | Generate or update the design token system alongside the spec |
| `--motion` | Generate or update the motion spec alongside the spec |

**If no argument is provided**, use `AskUserQuestion`:
- "What are we designing or reviewing today?"
  - "A screen or flow (I'll name it)"
  - "The game HUD"
  - "The design token system"
  - "The motion and animation spec"
  - "Audit all existing UX specs for gaps"
  - "Full pipeline — design, review, and hand off to the UI team"

---

## 1. Context Gathering (Pro Max Read Phase)

Read all context sources before any design work. The value of this skill is arriving fully informed.

### 1a. Required Reads

- `design/gdd/game-concept.md` — game pillars, tone, target audience
- `.claude/docs/technical-preferences.md` → `## Input & Platform` — input methods, platforms, gamepad/touch support
- `design/ux/interaction-patterns.md` — existing patterns (catalog index only, not full bodies)
- `design/art/art-bible.md` — visual direction, if present

### 1b. Optional Reads (load if present)

- `design/player-journey.md` — player emotional state per phase
- `design/accessibility-requirements.md` — committed accessibility tier
- `design/ux/design-tokens.md` — existing token system
- `design/ux/motion-spec.md` — existing motion principles
- All `design/gdd/*.md` UI Requirements sections relevant to the target screen
- Existing `design/ux/*.md` specs — entry/exit navigation linkages

### 1c. Context Summary

Present a brief before proceeding:

> **UI/UX Pro Max — [Mode]: [Target]**
> - Input methods: [from tech-prefs or "not configured — will ask once"]
> - Platform targets: [list]
> - Accessibility tier: [from requirements doc or "not yet defined"]
> - Existing patterns: [count or "no library yet"]
> - Design tokens: [present / absent]
> - Motion spec: [present / absent]
> - GDD requirements feeding this spec: [count and names]
> - Related screens already specced: [list or "none"]
>
> "Ready to proceed, or is there more context I should read first?"

---

## 2. Design Token System (Pro Max Feature)

> Run this phase if `--tokens` flag is set, if `tokens` argument is used, or if no `design/ux/design-tokens.md` exists and you are authoring a new spec.

Design tokens are the single source of truth for all visual values. They must exist before any spec defines specific visual attributes.

### Token Categories

Work through each category with the user:

#### Color Tokens
```
color.brand.primary
color.brand.secondary
color.brand.accent
color.semantic.success
color.semantic.warning
color.semantic.error
color.semantic.info
color.surface.background
color.surface.overlay
color.surface.card
color.surface.elevated
color.text.primary
color.text.secondary
color.text.disabled
color.text.inverse
color.text.link
color.border.default
color.border.focus
color.border.error
```

For each color, define:
- Light mode value (hex)
- Dark mode value (hex, if dark mode supported)
- Usage context (never use raw hex in specs — always token names)

#### Typography Tokens
```
font.family.heading
font.family.body
font.family.mono
font.size.[xs|sm|md|lg|xl|2xl|3xl]
font.weight.[light|regular|medium|semibold|bold]
font.lineheight.[tight|normal|relaxed]
font.letterspacing.[tight|normal|wide]
```

#### Spacing Tokens (8-point grid or project-defined base)
```
space.[1|2|3|4|6|8|12|16|20|24|32|40|48|64|80|96]
```
All in project units (px, dp, or engine units — clarify once based on platform target).

#### Elevation / Shadow Tokens
```
elevation.[0|1|2|3|4|5]
```

#### Border Radius Tokens
```
radius.[none|xs|sm|md|lg|xl|full]
```

#### Motion Tokens (link to motion spec if present)
```
motion.duration.[instant|fast|normal|slow|dramatic]
motion.easing.[linear|ease-in|ease-out|ease-in-out|spring]
```

**Ask the user to review each category in groups.** Do not dump all tokens at once. For each group: "Are these the right tokens for your game, or do you need to add/remove/rename any?"

After each category is approved, write it to `design/ux/design-tokens.md`.

**Output file**: `design/ux/design-tokens.md`

---

## 3. Motion & Animation Spec (Pro Max Feature)

> Run this phase if `--motion` flag is set, if `motion` argument is used, or alongside a new spec when no `design/ux/motion-spec.md` exists.

### Motion Principles

Establish the game's motion philosophy first:

- "What should motion communicate in this game? (polish/responsiveness, narrative weight, game-feel reinforcement)"
- "What is the maximum tolerable delay for any player-triggered transition? (e.g., 250ms, 400ms)"
- "Does the game support a reduced-motion accessibility mode?"

Offer framing options:
- **Snappy**: All transitions ≤150ms; UI is invisible — player focuses on game
- **Responsive**: Core interactions ≤150ms; contextual animations 150–350ms
- **Cinematic**: UI transitions are part of the game experience; 300–600ms theatrical entrances
- **Adaptive**: Motion density responds to gameplay context (fast in combat, slower in menus)

### Motion Specification Table

For each motion category, define:

| Motion Type | Duration Token | Easing Token | Notes |
|-------------|---------------|--------------|-------|
| Screen enter | | | |
| Screen exit | | | |
| Modal/panel appear | | | |
| Modal/panel dismiss | | | |
| List item enter (stagger) | | | |
| Button press feedback | | | |
| Success state transition | | | |
| Error state shake | | | |
| Loading indicator | | | |
| HUD element flash (alert) | | | |
| Notification toast | | | |
| Scroll momentum | | | |
| Focus indicator transition | | | |
| Reduced-motion override | instant | linear | All animated elements |

### Reduced-Motion Protocol

Every animation in the game must have a reduced-motion fallback. Define the rule once here:

- By default, reduced-motion replaces all motion token durations with `motion.duration.instant`
- Exceptions (if any) must be documented with rationale

**Output file**: `design/ux/motion-spec.md`

---

## 4. UX Spec Authoring (Pro Max Mode)

This section extends the base `/ux-design` spec with Pro Max additions. For each screen or flow, author the full spec section by section following the collaborative protocol.

### Section Order

1. Purpose & Player Need
2. Player Context on Arrival
3. Navigation Position
4. Entry & Exit Points
5. Layout Specification (Information Hierarchy → Zones → Components → ASCII Wireframe)
6. States & Variants *(Pro Max: adds dark/light mode variants, locale-sensitive variants)*
7. Responsive Breakpoints *(Pro Max — see below)*
8. Interaction Map
9. Events Fired
10. Transitions & Animations *(Pro Max: links to motion spec tokens)*
11. Data Requirements
12. Accessibility
13. Localization Considerations
14. Design Token References *(Pro Max — see below)*
15. Component Lifecycle *(Pro Max — see below)*
16. A/B Test Plan *(Pro Max — see below)*
17. Acceptance Criteria

### Pro Max Section: Responsive Breakpoints

> Applies to all target platforms with variable screen sizes (mobile, web, PC with resizable window, console with multiple TV sizes).

For each layout zone defined in Section 5, specify how it adapts across breakpoints:

| Breakpoint | Min Width | Zone Behavior | Component Changes |
|------------|-----------|---------------|-------------------|
| `xs` | 320px / 360dp | | |
| `sm` | 480px | | |
| `md` | 768px | | |
| `lg` | 1024px | | |
| `xl` | 1280px | | |
| `2xl` | 1920px | | |

For console targets, add:
- **Safe zone margins**: UI elements must be inset by at minimum 5% from screen edge (or project-specific safe zone value)
- **Overscan note**: Legacy TVs overscan; critical information must be 10% inset

**Questions to ask**:
- "Which breakpoints actually matter for this game's platform targets?"
- "Does the layout change significantly at any breakpoint, or is it a single fixed layout?"
- "Is portrait mode supported on mobile targets?"

---

### Pro Max Section: Design Token References

After the Layout Specification and States are approved, map every visual property in the spec to a design token name.

Present a cross-reference table:

| Element | Property | Token Name |
|---------|----------|------------|
| Primary button | Background | `color.brand.primary` |
| Primary button | Border radius | `radius.md` |
| Primary button | Label size | `font.size.md` |
| Panel | Elevation | `elevation.2` |
| Heading | Typography | `font.family.heading` / `font.size.xl` / `font.weight.bold` |
| [etc.] | | |

If any visual property cannot be mapped to an existing token:
> "The [element] needs a [property] value that isn't in the token system. Options:
> - Add a new token `[suggested-name]` with value `[suggested-value]`
> - Use the closest existing token `[name]` (note the approximation)
> - Define it as a one-off local override (not recommended — document the reason)"

---

### Pro Max Section: Component Lifecycle

For every interactive component in the spec, define its full state machine:

| Component | State | Visual Appearance | Interaction Allowed | Exit Condition |
|-----------|-------|-------------------|---------------------|----------------|
| [Component name] | Default | [token refs] | [actions] | [trigger] |
| | Hover | | | |
| | Focus | | | |
| | Active/Pressed | | | |
| | Disabled | | | |
| | Loading | | | |
| | Error | | | |
| | Success | | | |

Cross-reference any matching pattern in `design/ux/interaction-patterns.md`. If a pattern exists, inherit its state definitions and only document deviations.

---

### Pro Max Section: A/B Test Plan

> Flag any screen where player behavior is hard to predict without data.

For screens with significant conversion or engagement implications (onboarding, store, settings), define an A/B test plan:

**Questions to ask**:
- "Is there any design decision in this screen that we're unsure about and would benefit from player data?"
- "What player behavior would tell us this design is working? (session time, conversion rate, error rate, skip rate)"

For each proposed test:

```markdown
### A/B Test: [Test Name]

**Hypothesis**: "We believe [design choice A] will result in [metric improvement]
compared to [design choice B] because [rationale]."

**Variants**:
- Control (A): [describe]
- Variant (B): [describe]

**Primary metric**: [specific, measurable]
**Secondary metrics**: [list]
**Minimum sample size**: [N sessions or users]
**Success threshold**: [% improvement]

**Implementation note**: Variant switching must happen before first render.
Gate logic lives in [system] — not in the UI component itself.
```

---

## 5. Dark/Light Mode Variants

> Applies when the game supports a dark/light mode setting OR when targeting platforms that enforce system-level dark mode (iOS, Android, macOS).

After the standard spec is approved, add a variants section documenting how each state changes between modes.

**Questions to ask**:
- "Does this game support a dark/light mode toggle, or does it inherit from the OS?"
- "Are there any screens where the mode choice fundamentally changes the layout (not just colors)?"

For each screen, add a compact variant table:

| Mode | Surface | Text | Brand accent | Key changes from default |
|------|---------|------|--------------|--------------------------|
| Light | `color.surface.background` (light) | `color.text.primary` (light) | `color.brand.primary` | — |
| Dark | `color.surface.background` (dark) | `color.text.primary` (dark) | `color.brand.primary` | [any structural changes] |

If the only change is the token values (not structure), document: "Dark mode is handled entirely by the design token layer — no structural changes needed in this spec."

---

## 6. Cross-Platform Safe Zone Map

> Applies when targeting console (TV safe zones), mobile (notch/island/gesture areas), or web (scrollbar width, taskbar).

For each target platform, document the no-go zones where UI elements must not be placed:

| Platform | Top inset | Bottom inset | Left inset | Right inset | Notes |
|----------|-----------|--------------|------------|-------------|-------|
| PS5 / Xbox | 5% (90% zone) | 5% | 5% | 5% | User-adjustable safe area |
| Nintendo Switch | 0 (docked) / gesture area (handheld) | 0 / 20dp | 0 | 0 | |
| iOS (notched) | 44pt + notch | 34pt (home indicator) | 0 | 0 | |
| iOS (Dynamic Island) | 59pt | 34pt | 0 | 0 | |
| Android | Status bar height | Nav bar height (varies) | 0 | 0 | Can be edge-to-edge |
| PC windowed | 0 | 0 | 0 | 0 | No constraints |

Mark any UI zone in the Layout Specification that encroaches on these areas as **NEEDS SAFE ZONE ADJUSTMENT**.

---

## 7. Integrated UX Review (Pro Max Gate)

> Run automatically if `--review` flag is set. Otherwise, offer it at spec completion.

After the spec is complete, run the full `/ux-review` validation checklist inline — without spawning a separate skill invocation. The review is built in.

### Completeness Check

Run all checks from `/ux-review` Phase 3A (UX Spec) or Phase 3B (HUD):

- [ ] All 17 Pro Max sections present and non-placeholder
- [ ] Dark/light mode variant documented (if applicable)
- [ ] Design token references table complete
- [ ] Component lifecycle table complete for all interactive components
- [ ] Responsive breakpoints defined for all relevant platforms
- [ ] Safe zone map consulted; no violations flagged
- [ ] A/B test plan present (or explicitly marked "N/A — no testable uncertainty")
- [ ] Motion spec tokens referenced (or explicit "uses motion-spec.md defaults")
- [ ] All GDD UI Requirements covered
- [ ] All existing interaction patterns referenced; new patterns flagged for library
- [ ] 5+ specific, testable acceptance criteria

### Verdict

```
## Integrated Review: [Screen Name]

Completeness: [X/Y checks passed]
Blocking issues: [N]
Advisory issues: [N]

Verdict: APPROVED / NEEDS REVISION / MAJOR REVISION NEEDED

[List all blocking issues with section reference and fix instruction]
```

If NEEDS REVISION, stay in spec authoring mode — address the gaps inline without restarting.

---

## 8. Pattern Library Update

After the spec is complete and reviewed, check for new patterns:

- List all interaction patterns used in this spec
- Cross-reference `design/ux/interaction-patterns.md`
- For any pattern not in the library: "This spec introduces [pattern name]. Shall I add it to the pattern library now?"
- Write new patterns to `design/ux/interaction-patterns.md` using the standard pattern template

Pattern template:
```markdown
### [Pattern Name]

**Category**: Navigation / Input / Feedback / Data Display / Modal / Overlay / [other]
**Used In**: [screen list]
**Description**: [one paragraph — what it is and when to use it]
**Specification**:
- [behavior detail]
**When to Use**: [conditions]
**When NOT to Use**: [conditions]
**Design Tokens**: [list token references for this pattern]
**Motion**: [enter/exit/feedback motion token references]
**Accessibility**: [requirements for this pattern]
```

---

## 9. Team Orchestration (Pro Max — `--team` flag)

> When `--team` is set, this skill hands off to the `/team-ui` pipeline after spec approval and integrated review.

Before handoff, confirm:
- Spec is APPROVED (integrated review passed)
- Design tokens are up to date
- Motion spec is referenced
- Pattern library is updated
- Asset manifest is defined (list every art asset needed with exact dimensions and format)

Present the handoff package:

> **Ready for `/team-ui` handoff:**
> - UX Spec: `design/ux/[filename].md` — APPROVED
> - Design Tokens: `design/ux/design-tokens.md` — [version/date]
> - Motion Spec: `design/ux/motion-spec.md` — [version/date]
> - Pattern Library: `design/ux/interaction-patterns.md` — [N patterns]
> - Asset Manifest: [N assets defined]
> - Open questions: [N — list any remaining items for art-director to resolve]

Then spawn the `/team-ui` pipeline with the approved spec.

---

## 10. Audit Mode (`audit` or `all`)

> Scan all existing UX specs and produce a gap report. No modifications to existing specs in audit mode.

For each file in `design/ux/*.md` (excluding design-tokens.md, motion-spec.md, interaction-patterns.md):

1. Check for Pro Max sections missing from pre-existing specs
2. Check for design token references
3. Check for component lifecycle completeness
4. Flag any spec that predates the current design token system (token references may be raw values)
5. Produce a migration priority list

Output:

```markdown
## UI/UX Pro Max Audit Report
**Date**: [today]

### Spec Inventory

| File | Sections | Tokens | Lifecycle | Motion | Review Verdict | Priority |
|------|----------|--------|-----------|--------|----------------|----------|
| [spec] | [X/17] | ✅/⚠️ | ✅/⚠️ | ✅/⚠️ | [verdict or "not reviewed"] | [High/Med/Low] |

### Migration Backlog

[Prioritized list of specs needing Pro Max upgrade, with specific missing sections]

### Token Coverage

[How many specs use raw values vs token names]

### Pattern Library Gaps

[Patterns used in specs but not in the library]
```

If `all` argument: after the report, offer to upgrade each spec to Pro Max format, one at a time, in priority order.

---

## 11. Session State & Recovery

After every major milestone (section approved and written, token category confirmed, review passed), update `production/session-state/active.md`:

```markdown
<!-- STATUS -->
Epic: UI/UX
Feature: [screen/mode name]
Task: [current section]
<!-- /STATUS -->
```

Recovery: if session is interrupted, read `production/session-state/active.md` and the target spec file. Sections with `[To be designed]` are incomplete; sections with real content are done. Resume from the next incomplete section.

---

## 12. Collaborative Protocol

This skill follows the studio's collaborative design principle at every step:

1. **Never auto-generate** the full spec and present it as final
2. **Question → Options → Decision → Draft → Approval → Write** for every section
3. **"May I write to [filepath]?"** before creating or modifying any file
4. **Incremental writing**: each section written immediately after approval
5. **Conflicts surface immediately**: if a GDD requirement and screen real estate conflict, say so; never silently drop a requirement
6. **Aesthetic deference**: when layout or visual choices come down to taste, present options and ask

---

## 13. File Outputs

| Output | Path | When |
|--------|------|------|
| UX Spec | `design/ux/[screen-name].md` | Every screen/flow invocation |
| HUD Design | `design/ux/hud.md` | `hud` argument |
| Design Tokens | `design/ux/design-tokens.md` | `--tokens` flag or first-time token setup |
| Motion Spec | `design/ux/motion-spec.md` | `--motion` flag or first-time motion setup |
| Pattern Library | `design/ux/interaction-patterns.md` | When new patterns are introduced |
| Audit Report | `design/ux/audit-[date].md` | `audit` or `all` arguments |

---

## 14. Specialist Agent Routing

| Topic | Route to |
|-------|----------|
| Visual aesthetics, color, art direction | `art-director` |
| Engine-specific UI constraints | UI specialist from `technical-preferences.md` Engine Specialists |
| Implementation feasibility | `ui-programmer` |
| Gameplay data ownership | `game-designer` |
| Narrative / lore in UI | `narrative-director` |
| Accessibility tier decisions | `accessibility-specialist` |
| Full implementation pipeline | `/team-ui` (via `--team` flag) |

---

## Next Steps (after completion)

- Run `/ux-review [filename]` if integrated review was skipped
- Run `/team-ui [feature]` to begin implementation coordination
- Run `/gate-check pre-production` once all key screens have APPROVED specs
- Update `design/ux/interaction-patterns.md` with any new patterns introduced

Verdict: **COMPLETE** — Pro Max UX spec authored, reviewed, and handed off.
Verdict: **BLOCKED** — surface the blocker and its phase before stopping.
