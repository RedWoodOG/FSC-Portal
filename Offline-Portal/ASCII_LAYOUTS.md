# FSC Portal Offline - ASCII Layout Maps

**Version:** 2.0.26  
**Last Updated:** January 31, 2026  
**Purpose:** Visual ASCII diagrams with legends and precise dimension specifications for all layouts

---

## Table of Contents

1. [Symbol Legend](#symbol-legend)
2. [Desktop Application Layout](#desktop-application-layout)
3. [Mobile Application Layout](#mobile-application-layout)
4. [Home Screen (Dashboard)](#home-screen-dashboard)
5. [EVA Panel States](#eva-panel-states)
6. [Navigation Flow](#navigation-flow)
7. [Work Orders Screen](#work-orders-screen)
8. [Operations Screen](#operations-screen)
9. [Locations Screen (Map)](#locations-screen-map)
10. [Modal Sheet Structure](#modal-sheet-structure)

---

## Symbol Legend

### Box Drawing Characters
```
┌─┐  Top corners and horizontal lines
│ │  Vertical lines
└─┘  Bottom corners
├─┤  T-junctions (connections)
┬┴┼  Cross connections
```

### Functional Symbols
```
[Button]      Interactive button element
{Data}        Dynamic/variable content
●             Status indicator / dot
🌟            Icon placeholder
→             Navigation/flow direction
↔             Bidirectional relationship
▶             Expandable section
═             Emphasized border
[X]           Close button
[+]           Add button
[⚙]           Settings icon
```

### Dimension Notation
```
(240px)       Fixed width dimension
(48px H)      Height dimension
(Expanded)    Responsive/flexible
[Optional]    Conditional element
```

---

## Desktop Application Layout

### Full Desktop Layout (≥600px width)

```
Screen Width: 1920px (example)

┌─────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                   Window Title Bar (OS Chrome)                                  │
├────────────┬────────────────────────────────────────────────────────────────┬───────────────────┤
│            │                                                                │                   │
│  SIDEBAR   │                    MAIN CONTENT AREA                           │    EVA PANEL      │
│  240px     │                      (PortalShell)                             │   400px / 56px    │
│  Fixed     │                      Expanded Width                            │     Fixed         │
│            │                                                                │                   │
│  ┌──────┐  │  ┌──────────────────────────────────────────────────────────┐  │  ┌─────────────┐  │
│  │      │  │  │                                                          │  │  │   Header    │  │
│  │ Logo │  │  │                                                          │  │  │   EVA       │  │
│  │Portal│  │  │           Current Screen Widget                          │  │  │   64px H    │  │
│  │      │  │  │           (HomeView, WorkView, etc.)                     │  │  ├─────────────┤  │
│  └──────┘  │  │                                                          │  │  │             │  │
│  ─────────  │  │  • Receives full vertical space                         │  │  │  Messages   │  │
│  ┌──────┐  │  │  • Width = Screen - Sidebar - EVA                       │  │  │   Canvas    │  │
│  │ Home │  │  │  • Scrollable if content exceeds viewport               │  │  │             │  │
│  │  ●   │  │  │  • No fixed positioning                                 │  │  │  (Scroll)   │  │
│  └──────┘  │  │  • Background: App-specific or gradient                 │  │  │             │  │
│  ┌──────┐  │  │                                                          │  │  │             │  │
│  │ Work │  │  │                                                          │  │  │             │  │
│  └──────┘  │  │                                                          │  │  ├─────────────┤  │
│  ┌──────┐  │  │                                                          │  │  │  Input Bar  │  │
│  │ Ops  │  │  │  Full Height = Window - Title Bar                       │  │  │   72px H    │  │
│  └──────┘  │  │                                                          │  │  └─────────────┘  │
│  ┌──────┐  │  │                                                          │  │                   │
│  │ Loc  │  │  │                                                          │  │  OR               │
│  └──────┘  │  │                                                          │  │                   │
│  ┌──────┐  │  │                                                          │  │  ┌─────────────┐  │
│  │People│  │  │                                                          │  │  │             │  │
│  └──────┘  │  │                                                          │  │  │  Collapsed  │  │
│  ┌──────┐  │  │                                                          │  │  │    Rail     │  │
│  │Know  │  │  │                                                          │  │  │   56px W    │  │
│  └──────┘  │  │                                                          │  │  │             │  │
│  ┌──────┐  │  │                                                          │  │  │   🌟 EVA    │  │
│  │Train │  │  │                                                          │  │  │    ●        │  │
│  └──────┘  │  │                                                          │  │  │             │  │
│  ┌──────┐  │  │                                                          │  │  │     E       │  │
│  │Equip │  │  │                                                          │  │  │     V       │  │
│  └──────┘  │  │                                                          │  │  │     A       │  │
│  ┌──────┐  │  │                                                          │  │  │             │  │
│  │Expns │  │  └──────────────────────────────────────────────────────────┘  │  │             │  │
│  └──────┘  │                                                                │  └─────────────┘  │
│  ┌──────┐  │                                                                │                   │
│  │Sttgs │  │                                                                │                   │
│  └──────┘  │                                                                │                   │
│  ─────────  │                                                                │                   │
│  ┌──────┐  │                                                                │                   │
│  │      │  │                                                                │                   │
│  │ User │  │                                                                │                   │
│  │ JD   │  │                                                                │                   │
│  │ Tech │  │                                                                │                   │
│  └──────┘  │                                                                │                   │
│            │                                                                │                   │
└────────────┴────────────────────────────────────────────────────────────────┴───────────────────┘

DIMENSIONS:
├─ 240px ──┤├─────────── 1280px (or remaining) ─────────────────┤├── 400px ──┤
             (With EVA expanded: 1920 - 240 - 400 = 1280px)
             (With EVA collapsed: 1920 - 240 - 56 = 1624px)

COMPONENTS:
• Sidebar: 240px fixed, always visible, vertical scroll if needed
• Main Content: Expanded (takes remaining width), vertical scroll
• EVA Panel: 400px (expanded) or 56px (collapsed), fixed position right
```

### Sidebar Navigation Detail

```
┌────────────────────────┐
│   SIDEBAR (240px)      │
├────────────────────────┤
│  ┌──────────────────┐  │ ← Logo Section
│  │   ┌────────┐     │  │   • 24px padding
│  │   │ 🔷     │     │  │   • Logo: 48x48px
│  │   └────────┘     │  │   • Logo + "Portal" text
│  │   Portal         │  │   • 18px font, bold
│  └──────────────────┘  │
├────────────────────────┤ ← Divider (1px, white10)
│  ╔══════════════════╗  │
│  ║  ● Home          ║  │ ← Active Item
│  ╚══════════════════╝  │   • Background: Primary blue (#0056D2)
│  ┌──────────────────┐  │   • Border radius: 8px
│  │    Work          │  │   • Padding: 16px H, 12px V
│  └──────────────────┘  │   • Icon: 24px
│  ┌──────────────────┐  │   • Icon-text gap: 12px
│  │    Operations    │  │   • Margin: 8px H, 2px V
│  └──────────────────┘  │
│  ┌──────────────────┐  │ ← Inactive Items
│  │    Locations     │  │   • Background: Transparent
│  └──────────────────┘  │   • Text: Grey (#B0B0B0)
│  ┌──────────────────┐  │   • Icon: Grey
│  │    People        │  │   • Font: 14px, Normal
│  └──────────────────┘  │
│  ┌──────────────────┐  │
│  │    Knowledge     │  │
│  └──────────────────┘  │
│  ┌──────────────────┐  │
│  │    Training      │  │
│  └──────────────────┘  │
│  ┌──────────────────┐  │
│  │    Equipment     │  │
│  └──────────────────┘  │
│  ┌──────────────────┐  │
│  │    Expenses      │  │
│  └──────────────────┘  │
│  ┌──────────────────┐  │
│  │    Settings      │  │
│  └──────────────────┘  │
│                        │
│  (Expanded to fill)    │
│                        │
├────────────────────────┤ ← Divider
│  ┌──────────────────┐  │ ← User Profile
│  │  ┌──┐            │  │   • 16px padding
│  │  │JD│  John Doe  │  │   • Avatar: 40px circle
│  │  └──┘  Tech      │  │   • Name: SemiBold
│  │        🌙         │  │   • Role: Timestamp style
│  └──────────────────┘  │   • Dark mode icon
└────────────────────────┘   • Clickable

HEIGHT BREAKDOWN:
• Logo section: ~96px (24px padding top + 48px logo + 24px padding bottom)
• Divider: 1px
• Navigation items: ~480px (10 items × 48px each)
• Spacer: Flexible
• Divider: 1px
• User profile: ~72px (16px padding + 40px content + 16px padding)
• TOTAL: Variable based on screen height
```

---

## Mobile Application Layout

### Mobile Layout (<600px width)

```
Screen Width: 375px (example - iPhone)

┌───────────────────────────────────────────────────┐
│            Status Bar (OS)                        │
├───────────────────────────────────────────────────┤
│                                                   │
│          MAIN CONTENT AREA                        │
│          (PortalShell Child)                      │
│          Full Width (375px)                       │
│                                                   │
│  ┌─────────────────────────────────────────────┐  │
│  │                                             │  │
│  │                                             │  │
│  │                                             │  │
│  │        Current Screen Widget                │  │
│  │        (Stacked vertically)                 │  │
│  │                                             │  │
│  │  • Full width (375px)                       │  │
│  │  • Vertical scroll                          │  │
│  │  • Simplified layouts                       │  │
│  │  • Single column                            │  │
│  │  • Touch-optimized                          │  │
│  │                                             │  │
│  │                                             │  │
│  │                                             │  │
│  │                                             │  │
│  │                                             │  │
│  │                                             │  │
│  │                                             │  │
│  │                                             │  │
│  │                                             │  │
│  │                                             │  │
│  │                                             │  │
│  └─────────────────────────────────────────────┘  │
│                                                   │
├───────────────────────────────────────────────────┤
│  BOTTOM NAVIGATION BAR (56px H)                   │
│  ┌────┬────┬────┬────┬────┐                      │
│  │🏠 │📋 │⚙ │📍│👥│                      │
│  │Home│Work│Ops│Loc│Ppl│                      │
│  └────┴────┴────┴────┴────┘                      │
│  (First 5 destinations only)                      │
└───────────────────────────────────────────────────┘
│                                                   │
├── EVA Panel (Collapsed, 56px) on right edge ──────┤
│  ┌──┐                                             │
│  │🌟│ ← Always present, collapsed                 │
│  │ ●│                                             │
│  │E │                                             │
│  │V │                                             │
│  │A │                                             │
│  └──┘                                             │

NOTES:
• No sidebar navigation (hidden)
• Bottom nav shows first 5 items only
• Remaining screens (Training, Equipment, Expenses, Settings) 
  accessible via other means (in-app navigation)
• EVA panel still present but collapsed by default
• Content area takes full width minus EVA rail (375 - 56 = 319px)
```

---

## Home Screen (Dashboard)

### Desktop Wide Layout (>1100px)

```
┌───────────────────────────────────────────────────────────────────────────────────────┐
│                                    HOME SCREEN                                        │
│                         Background: Deep Ocean Gradient                               │
│                              Padding: 32px all sides                                  │
├───────────────────────────────────────────────────────────────────────────────────────┤
│  ┌────────────────────────────────────────────────────────────┬───────────────────┐  │
│  │                                                            │                   │  │
│  │  ┌──────────────────────────────────────────────────────┐  │  ┌─────────────┐  │  │
│  │  │ HEADER SECTION                                       │  │  │ STATUS      │  │  │
│  │  │ [🔷] FIELD SERVICE PORTAL  ● SECURE  [Search] [👤]  │  │  │ PANEL       │  │  │
│  │  │  48px    24px font                      (Buttons)    │  │  │             │  │  │
│  │  └──────────────────────────────────────────────────────┘  │  │ MISSION     │  │  │
│  │                                                            │  │ DURATION    │  │  │
│  │  ┌────────────────────────────────────────┐                │  │             │  │  │
│  │  │ MORNING BRIEFING (GlassCard)           │                │  │ Start: 8AM  │  │  │
│  │  │ ┌──────────────────┬──────────────────┐ │                │  │ ─────────── │  │  │
│  │  │ │ ATMOSPHERIC      │ LOGISTIC         │ │                │  │ End: 5PM    │  │  │
│  │  │ │ CONDITIONS       │ FEEDBACK         │ │                │  │             │  │  │
│  │  │ │                  │                  │ │                │  │ ██████░░65% │  │  │
│  │  │ │ ☁ 72°F           │ 🧭 TRAFFIC:      │ │                │  └─────────────┘  │  │
│  │  │ │   Cloudy         │    MODERATE      │ │                │                   │  │
│  │  │ │                  │ Scanning...      │ │                │   (Right Sidebar  │  │
│  │  │ └──────────────────┴──────────────────┘ │                │    in Wide Mode)  │  │
│  │  │ 24px border radius, 32px padding       │                │                   │  │
│  │  └────────────────────────────────────────┘                │                   │  │
│  │                                                            │                   │  │
│  │  ┌──────────────┬──────────────┬──────────────┐            │                   │  │
│  │  │ KPI TILE 1   │ KPI TILE 2   │ KPI TILE 3   │            │                   │  │
│  │  │ (GlassCard)  │ (GlassCard)  │ (GlassCard)  │            │                   │  │
│  │  │              │              │              │            │                   │  │
│  │  │ ACTIVE       │ COMPLETED    │ WEEKLY       │            │                   │  │
│  │  │ DEPLOYMENTS  │ MISSIONS     │ THROUGHPUT   │            │                   │  │
│  │  │              │              │              │            │                   │  │
│  │  │   12    📋   │   45    ✓    │   67    📊   │            │                   │  │
│  │  │   ━━         │   ━━         │   ━━         │            │                   │  │
│  │  │ 32px font    │ 32px font    │ 32px font    │            │                   │  │
│  │  │ Blue accent  │ Green accent │Purple accent │            │                   │  │
│  │  └──────────────┴──────────────┴──────────────┘            │                   │  │
│  │                                                            │                   │  │
│  │  ┌────────────────────────────────────────┐                │                   │  │
│  │  │ TACTICAL SHORTCUTS (2x2 Grid)          │                │                   │  │
│  │  │ ┌──────────────┬──────────────┐         │                │                   │  │
│  │  │ │ 📷           │ 📝           │         │                │                   │  │
│  │  │ │ SCAN         │ INTEL        │         │                │                   │  │
│  │  │ │ RECEIPTS     │ ENTRY        │         │                │                   │  │
│  │  │ └──────────────┴──────────────┘         │                │                   │  │
│  │  │ ┌──────────────┬──────────────┐         │                │                   │  │
│  │  │ │ 🗺           │ ⚙            │         │                │                   │  │
│  │  │ │ THEATRE      │ AGENT        │         │                │                   │  │
│  │  │ │ MAP          │ TOOLS        │         │                │                   │  │
│  │  │ └──────────────┴──────────────┘         │                │                   │  │
│  │  │ Icon: 28px, Label: 11px uppercase      │                │                   │  │
│  │  └────────────────────────────────────────┘                │                   │  │
│  │                                                            │                   │  │
│  │  ┌────────────────────────────────────────────────────────┐                    │  │
│  │  │ INDUSTRY BRIEFING                                      │                    │  │
│  │  │ (5) • Last updated: 2 min ago          [RSS]           │                    │  │
│  │  ├────────────────────────────────────────────────────────┤                    │  │
│  │  │ ┌────────┐ ┌────┐ ┌────┐ ┌────┐ ┌────┐                │                    │  │
│  │  │ │Featured│ │Item│ │Item│ │Item│ │Item│ ──►            │                    │  │
│  │  │ │ 300px  │ │160 │ │160 │ │160 │ │160 │                │                    │  │
│  │  │ │        │ │    │ │    │ │    │ │    │                │                    │  │
│  │  │ └────────┘ └────┘ └────┘ └────┘ └────┘                │                    │  │
│  │  │ Horizontal scroll, 220px height                        │                    │  │
│  │  └────────────────────────────────────────────────────────┘                    │  │
│  │                                                            │                   │  │
│  │  ┌────────────────────────────────────────────────────────┐                    │  │
│  │  │ CORPORATE INTEL                [+]  ACCESS ARCHIVE     │                    │  │
│  │  ├────────────────────────────────────────────────────────┤                    │  │
│  │  │ ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐           │                    │  │
│  │  │ │NewsCard│ │NewsCard│ │NewsCard│ │NewsCard│ ──►       │                    │  │
│  │  │ │ 340px  │ │ 340px  │ │ 340px  │ │ 340px  │           │                    │  │
│  │  │ │        │ │        │ │        │ │        │           │                    │  │
│  │  │ └────────┘ └────────┘ └────────┘ └────────┘           │                    │  │
│  │  │ Horizontal scroll, 180px height                        │                    │  │
│  │  └────────────────────────────────────────────────────────┘                    │  │
│  │                                                            │                   │  │
│  │  (7 columns width)                                         │  (3 columns)      │  │
│  └────────────────────────────────────────────────────────────┴───────────────────┘  │
│                                                                                      │
│  Vertical scroll if content exceeds viewport                                        │
└───────────────────────────────────────────────────────────────────────────────────────┘
```

### Mobile/Narrow Layout (≤1100px)

```
┌─────────────────────────────────────────┐
│         HOME SCREEN (Narrow)            │
│    Single Column, Stacked Vertically    │
├─────────────────────────────────────────┤
│  ┌───────────────────────────────────┐  │
│  │ HEADER SECTION                    │  │
│  │ [🔷] FIELD SERVICE PORTAL         │  │
│  │ ● SECURE  [Search]  [👤]          │  │
│  └───────────────────────────────────┘  │
│                                         │
│  ┌───────────────────────────────────┐  │
│  │ MORNING BRIEFING                  │  │
│  │ ┌───────────┬───────────┐         │  │
│  │ │ Weather   │ Traffic   │         │  │
│  │ └───────────┴───────────┘         │  │
│  └───────────────────────────────────┘  │
│                                         │
│  ┌───────────────────────────────────┐  │
│  │ KPI TILES (3 horizontal)          │  │
│  │ [12] [45] [67]                    │  │
│  └───────────────────────────────────┘  │
│                                         │
│  ┌───────────────────────────────────┐  │
│  │ STATUS PANEL                      │  │
│  │ Mission Duration                  │  │
│  │ ██████░░65%                       │  │
│  └───────────────────────────────────┘  │
│                                         │
│  ┌───────────────────────────────────┐  │
│  │ TACTICAL SHORTCUTS                │  │
│  │ [Scan] [Intel]                    │  │
│  │ [Map]  [Tools]                    │  │
│  └───────────────────────────────────┘  │
│                                         │
│  ┌───────────────────────────────────┐  │
│  │ INDUSTRY BRIEFING                 │  │
│  │ [Cards scroll horizontally] ──►   │  │
│  └───────────────────────────────────┘  │
│                                         │
│  ┌───────────────────────────────────┐  │
│  │ CORPORATE INTEL                   │  │
│  │ [Cards scroll horizontally] ──►   │  │
│  └───────────────────────────────────┘  │
│                                         │
│  (All stacked vertically, full width)  │
│  (Vertical scroll)                     │
└─────────────────────────────────────────┘
```

---

## EVA Panel States

### EVA Panel Expanded (400px)

```
┌──────────────────────────────────┐
│  EVA PANEL (400px width)         │
├──────────────────────────────────┤
│  ┌────────────────────────────┐  │ ← HEADER (64px height)
│  │ 🌟 EVA          [Collapse] │  │
│  │ Embedded Intelligence      │  │
│  │ [Thinking: ⭕ if active]    │  │
│  └────────────────────────────┘  │
├──────────────────────────────────┤ ← Border (1px)
│                                  │
│  ╔════════════════════════════╗  │ ← CONVERSATION CANVAS
│  ║                            ║  │   (Expanded, scrollable)
│  ║  [Empty State]             ║  │
│  ║                            ║  │   IF NO MESSAGES:
│  ║      🌟                    ║  │   ┌──────────────┐
│  ║  EVA is ready              ║  │   │   🌟 48px    │
│  ║                            ║  │   │ EVA is ready │
│  ║                            ║  │   │  (centered)  │
│  ║                            ║  │   └──────────────┘
│  ║                            ║  │
│  ║  [With Messages]           ║  │   WITH MESSAGES:
│  ║                            ║  │
│  ║      ┌─────────────────┐   ║  │   User Messages:
│  ║      │ User message    │   ║  │   ┌──────────────┐
│  ║      │ (right-aligned) │   ║  │   │ Text content │
│  ║      │ Primary blue bg │   ║  │   │ Max: 300px   │
│  ║      │ White text      │   ║  │   │ Right-align  │
│  ║      └─────────────────┘   ║  │   │ Blue bg      │
│  ║                            ║  │   └──────────────┘
│  ║  ┌─────────────────┐       ║  │
│  ║  │ EVA response    │       ║  │   EVA Messages:
│  ║  │ (left-aligned)  │       ║  │   ┌──────────────┐
│  ║  │ Surface bg      │       ║  │   │ Text content │
│  ║  │ Border          │       ║  │   │ Max: 300px   │
│  ║  │ White text      │       ║  │   │ Left-align   │
│  ║  │ ─────────────── │       ║  │   │ Surface bg   │
│  ║  │ Sources:        │       ║  │   │ Border       │
│  ║  │ • Source 1      │       ║  │   │ + Citations  │
│  ║  │ • Source 2      │       ║  │   └──────────────┘
│  ║  └─────────────────┘       ║  │
│  ║                            ║  │   [Processing Indicator]
│  ║  [If Processing]           ║  │   ⭕ EVA is thinking...
│  ║  ⭕ EVA is thinking...     ║  │   (24px spinner + text)
│  ║                            ║  │
│  ╚════════════════════════════╝  │
│  (Background: AppColors.background) │
│  (Padding: 16px)                │
│  (Vertical scroll)              │
├──────────────────────────────────┤ ← Border (1px)
│  ┌────────────────────────────┐  │ ← INPUT BAR (72px height)
│  │ [Ask EVA anything...]      │  │
│  │                        [>] │  │
│  │ TextField + Send button    │  │
│  │ 8px border radius          │  │
│  │ Primary border on focus    │  │
│  └────────────────────────────┘  │
│  (Padding: 16px)                │
│  (Background: AppColors.surface)│
└──────────────────────────────────┘

DIMENSIONS:
• Total width: 400px
• Header height: 64px (16px padding + content + 16px)
• Input bar height: 72px (16px padding + input + 16px)
• Canvas height: Remaining (flexible)
• Message bubbles: Max 300px width
• Padding: 16px all around content sections
```

### EVA Collapsed Rail (56px)

```
┌────┐
│    │ ← Spacer (24px)
│    │
│ ┌┐ │ ← EVA INDICATOR
│ ││ │   • 48x48px container
│ 🌟 │   • Primary blue bg (0.2 opacity)
│ ││ │   • Border: 2px primary (if unread)
│ └┘ │            1px border (normal)
│    │   • Icon: auto_awesome, 24px
│  ● │   • Clickable: Expands panel
│    │
│    │ ← UNREAD DOT (conditional)
│    │   • 8x8px circle
│    │   • Primary blue color
│    │   • Only visible if hasUnread
│    │
│    │
│    │ ← Spacer (fills remaining)
│    │
│    │
│    │
│    │
│    │
│    │
│    │
│ E  │ ← ROTATED TEXT
│ V  │   • Text: "EVA"
│ A  │   • Rotated 90° clockwise
│    │   • Secondary text color
│    │   • 10px font
│    │   • Letter spacing: 2
│    │   • 24px padding bottom
└────┘

DIMENSIONS:
• Width: 56px (fixed)
• Full height (matches screen)
• Indicator: 48x48px
• Unread dot: 8x8px
• Top spacer: 24px
• Bottom spacer: 24px
```

---

## Navigation Flow

### Navigation State Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                    USER TRIGGERS NAVIGATION                     │
│  (Sidebar click, Bottom nav tap, Programmatic call)             │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
                  ┌──────────────────────┐
                  │ NavigationState      │
                  │ .navigateTo(index)   │
                  └──────────┬───────────┘
                             │
                             ▼
                  ┌──────────────────────┐
                  │ Update _selectedIndex│
                  │ notifyListeners()    │
                  └──────────┬───────────┘
                             │
                             ▼
                  ┌──────────────────────┐
                  │ MainNavigationScreen │
                  │ .build() called      │
                  └──────────┬───────────┘
                             │
                ┌────────────┴────────────┐
                │                         │
                ▼                         ▼
    ┌──────────────────┐      ┌──────────────────┐
    │ Update Sidebar   │      │ Update Bottom    │
    │ Active Styling   │      │ Nav Selection    │
    └──────────────────┘      └──────────────────┘
                │                         │
                └────────────┬────────────┘
                             │
                             ▼
                  ┌──────────────────────┐
                  │ Select Widget from   │
                  │ _screens[index]      │
                  └──────────┬───────────┘
                             │
                             ▼
                  ┌──────────────────────┐
                  │ Pass to PortalShell  │
                  │ as child             │
                  └──────────┬───────────┘
                             │
                             ▼
                  ┌──────────────────────┐
                  │ PortalShell wraps    │
                  │ child with EVA panel │
                  └──────────┬───────────┘
                             │
                             ▼
                  ┌──────────────────────┐
                  │ Screen Renders       │
                  │ (HomeView, etc.)     │
                  └──────────────────────┘

INDICES:
0 → Home (Dashboard)
1 → Work Orders
2 → Operations
3 → Locations (Map)
4 → People
5 → Knowledge
6 → Training
7 → Equipment
8 → Expenses
9 → Settings
```

---

## Work Orders Screen

```
┌───────────────────────────────────────────────────────────────────────────┐
│  Work Orders                                      [+ Create Work Order]   │
├───────────────────────────────────────────────────────────────────────────┤
│  [All]  [Open]  [On Hold]  [Completed]  ← Filter Chips                   │
│   ●                                       (Active: Primary blue bg)       │
├───────────────────────────────────────────────────────────────────────────┤
│  ┌─────────────────────────────────────────────────────────────────────┐  │
│  │ WO-001  [OPEN]  [HIGH]                                              │  │
│  │         Blue    Red                                                 │  │
│  │                                                                     │  │
│  │ Site: Main Branch                                                   │  │
│  │ Client: RBFCU (theme-colored)                                       │  │
│  │ Description: ATM maintenance required at main location              │  │
│  │                                                                     │  │
│  │ Equipment: [ATM-9400] [ATM-9401] [PRINTER-01]                       │  │
│  │           (Chips with equipment IDs)                                │  │
│  │                                                                     │  │
│  │ Assigned: John Doe                                                  │  │
│  │ Created: 2026-01-15                                                 │  │
│  └─────────────────────────────────────────────────────────────────────┘  │
│  (GlassCard, clickable for details)                                      │
│                                                                           │
│  ┌─────────────────────────────────────────────────────────────────────┐  │
│  │ WO-002  [ON_HOLD]  [MEDIUM]                                         │  │
│  │         Orange     Orange                                           │  │
│  │ ...                                                                 │  │
│  └─────────────────────────────────────────────────────────────────────┘  │
│                                                                           │
│  ┌─────────────────────────────────────────────────────────────────────┐  │
│  │ WO-003  [COMPLETED]  [LOW]                                          │  │
│  │         Green        Grey                                           │  │
│  │ ...                                                                 │  │
│  └─────────────────────────────────────────────────────────────────────┘  │
│                                                                           │
│  ... (Up to 20 items per page)                                           │
│                                                                           │
│  [Load More] ← Appears when more items available                         │
│  (Infinite scroll)                                                        │
│                                                                           │
│  (Vertical scroll)                                                        │
└───────────────────────────────────────────────────────────────────────────┘

COMPONENTS:
• AppBar: "Work Orders" title + Create button
• Filter chips: Single selection, active state highlighted
• Work order cards: GlassCard with structured info
• Status badges: Color-coded (Open=Blue, On Hold=Orange, Completed=Green)
• Priority badges: Color-coded (High=Red, Medium=Orange, Low=Grey)
• Equipment chips: Small rounded containers with IDs
• Load more button: Primary button at bottom

PAGINATION:
• Initial load: 20 items
• Scroll to bottom: Fetch next 20
• Filter change: Reset to first 20 of filtered set
```

---

## Operations Screen

```
┌───────────────────────────────────────────────────────────────────────────┐
│  Operations                                   [Filter: All Clients ▼]     │
├───────────────────────────────────────────────────────────────────────────┤
│  [Clients]  [Equipment]  ← Tab selector (Clients active)                  │
│     ●                                                                     │
├───────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│  CLIENT VIEW (when Clients tab active):                                   │
│  ┌─────────────────────────────────────────────────────────────────────┐  │
│  │ RBFCU                                               [12 Locations]  │  │
│  │ ● Blue theme color                                                  │  │
│  │                                                                     │  │
│  │ [View Sites >]                                                      │  │
│  └─────────────────────────────────────────────────────────────────────┘  │
│  (GlassCard)                                                              │
│                                                                           │
│  ┌─────────────────────────────────────────────────────────────────────┐  │
│  │ Jefferson Credit Union                               [8 Locations]  │  │
│  │ ● Yellow theme color                                                │  │
│  │ [View Sites >]                                                      │  │
│  └─────────────────────────────────────────────────────────────────────┘  │
│                                                                           │
│  ┌─────────────────────────────────────────────────────────────────────┐  │
│  │ Prosperity Bank                                      [5 Locations]  │  │
│  │ ● Red theme color                                                   │  │
│  │ [View Sites >]                                                      │  │
│  └─────────────────────────────────────────────────────────────────────┘  │
│                                                                           │
│  SITE VIEW (when "View Sites" clicked):                                   │
│  [< Back to Clients]  ← Back button in AppBar                             │
│                                                                           │
│  ┌─────────────────────────────────────────────────────────────────────┐  │
│  │ Main Branch                                                         │  │
│  │ Address: 123 Main St, San Antonio, TX 78201                        │  │
│  │ Region: South Texas                                                 │  │
│  │ Coordinates: 29.4241, -98.4936                                      │  │
│  │                                                                     │  │
│  │ Equipment (5 items):                                                │  │
│  │ • ATM - Hyosung MX8600                                              │  │
│  │ • ATM - Hyosung MX8600                                              │  │
│  │ • Printer - HP LaserJet                                             │  │
│  │ • Computer - Dell OptiPlex                                          │  │
│  │ • Router - Cisco                                                    │  │
│  └─────────────────────────────────────────────────────────────────────┘  │
│                                                                           │
│  EQUIPMENT VIEW (when Equipment tab active):                              │
│  ┌─────────────────────────────────────────────────────────────────────┐  │
│  │ ATM-9400                               [WARRANTY] [CONTRACT]        │  │
│  │                                         Green     Blue              │  │
│  │ Manufacturer: Hyosung                                               │  │
│  │ Model: MX8600                                                       │  │
│  │ Serial: SN123456789                                                 │  │
│  │ Location: RBFCU Main Branch                                         │  │
│  └─────────────────────────────────────────────────────────────────────┘  │
│                                                                           │
│  ... (More equipment items)                                               │
│                                                                           │
└───────────────────────────────────────────────────────────────────────────┘

NAVIGATION STATES:
1. Client List (default)
2. Site List (after clicking "View Sites", with back button)
3. Equipment List (Equipment tab, filtered by client dropdown)
```

---

## Locations Screen (Map)

```
┌───────────────────────────────────────────────────────────────────────────┐
│                          LOCATIONS VIEW (Map)                             │
├───────────────────────────────────────────────────────────────────────────┤
│  ╔═══════════════════════════════════════════════════════════════════╗    │
│  ║                                                                   ║    │
│  ║                    OpenStreetMap Tiles                            ║    │
│  ║                      (FlutterMap)                                 ║    │
│  ║                                                                   ║    │
│  ║    📍 Site Markers (color-coded)                                  ║    │
│  ║    🏠 Starting Point Markers (green)                              ║    │
│  ║    ━━━ Route Polyline (purple, if PM mode active)                ║    │
│  ║                                                                   ║    │
│  ║    ┌────────────────────────────┐  ← Control Panel (Overlay)     ║    │
│  ║    │ PM ROUTE PLANNING          │    (GlassCard, top-left)       ║    │
│  ║    │ ☑ Enable PM Mode           │                                ║    │
│  ║    │ Starting Point: [Select ▼] │                                ║    │
│  ║    └────────────────────────────┘                                ║    │
│  ║                                                                   ║    │
│  ║                                                                   ║    │
│  ║    ┌────────────────────────────┐  ← Legend Panel (Overlay)      ║    │
│  ║    │ LEGEND                     │    (GlassCard, bottom-left)    ║    │
│  ║    │ ● Blue    - RBFCU          │                                ║    │
│  ║    │ ● Yellow  - Jefferson      │                                ║    │
│  ║    │ ● Red     - Prosperity     │                                ║    │
│  ║    │ 🏠 Green  - Starting Pts   │                                ║    │
│  ║    └────────────────────────────┘                                ║    │
│  ║                                                                   ║    │
│  ║                                                                   ║    │
│  ║  Map Features:                                                    ║    │
│  ║  • Zoom: Pinch or scroll wheel                                   ║    │
│  ║  • Pan: Drag                                                     ║    │
│  ║  • Tap marker: Open SiteDetailSheet                              ║    │
│  ║  • PM Route: Purple line connecting optimized route              ║    │
│  ║                                                                   ║    │
│  ╚═══════════════════════════════════════════════════════════════════╝    │
│                                                                           │
│  MAP LAYERS (bottom to top):                                              │
│  1. TileLayer (OpenStreetMap)                                             │
│  2. PolylineLayer (PM route, if active)                                   │
│  3. MarkerLayer (Starting points, green home icons)                       │
│  4. MarkerLayer (Sites, colored circles)                                  │
│  5. Overlay panels (Control + Legend, GlassCards)                         │
│                                                                           │
│  PM ROUTE ALGORITHM:                                                      │
│  1. Find farthest site from selected starting point                       │
│  2. Find 5 closest sites to that farthest site                            │
│  3. Draw route: Start → Farthest → 5 Closest                              │
│  4. Display as purple polyline (5px width, 0.7 opacity)                   │
│                                                                           │
└───────────────────────────────────────────────────────────────────────────┘

MARKER COLORS:
• RBFCU: Blue (AppColors.pinRBFCU)
• Jefferson: Yellow/Amber (AppColors.pinJefferson)
• Prosperity: Red (AppColors.pinProsperity)
• Starting Points: Green (AppColors.pinStartPoint)

INTERACTIONS:
• Tap site marker → Opens SiteDetailSheet (bottom sheet)
• Enable PM Mode → Shows route calculation
• Change starting point → Recalculates route
• Zoom/Pan → Standard map controls
```

---

## Modal Sheet Structure

### DraggableScrollableSheet Pattern

```
┌─────────────────────────────────────────────────────────────┐
│                    PARENT SCREEN                            │
│                     (Dimmed)                                │
│                                                             │
│  ┌───────────────────────────────────────────────────────┐  │
│  │                         ═                             │  │ ← Handle Bar
│  ├───────────────────────────────────────────────────────┤  │   40px × 4px
│  │  [Icon] Sheet Title                            [X]    │  │   Grey, 12px margin
│  ├───────────────────────────────────────────────────────┤  │
│  │                                                       │  │ ← Header
│  │                                                       │  │   Title + Close
│  │                    SHEET CONTENT                      │  │   20px padding
│  │                    (Scrollable)                       │  │   Divider below
│  │                                                       │  │
│  │  ┌─────────────────────────────────────────────────┐  │  │
│  │  │ Form Field Label                                │  │  │ ← Content Area
│  │  │ [Input Field]                                   │  │  │   Scrollable
│  │  │                                                 │  │  │   20px padding
│  │  │ Another Label                                   │  │  │   Form fields
│  │  │ [Dropdown ▼]                                    │  │  │   Inputs, etc.
│  │  │                                                 │  │  │
│  │  │ Text Area Label                                 │  │  │
│  │  │ ┌─────────────────────────────────────────────┐ │  │  │
│  │  │ │ Multi-line text input...                    │ │  │  │
│  │  │ │                                             │ │  │  │
│  │  │ └─────────────────────────────────────────────┘ │  │  │
│  │  │                                                 │  │  │
│  │  │ ┌─────────────────────────────────────────────┐ │  │  │
│  │  │ │          PRIMARY ACTION BUTTON              │ │  │  │
│  │  │ └─────────────────────────────────────────────┘ │  │  │
│  │  │                                                 │  │  │
│  │  └─────────────────────────────────────────────────┘  │  │
│  │                                                       │  │
│  └───────────────────────────────────────────────────────┘  │
│                                                             │
│  DRAG BEHAVIOR:                                             │
│  • initialChildSize: 0.5 - 0.8 (50% - 80%)                  │
│  • minChildSize: 0.5 (50%)                                  │
│  • maxChildSize: 0.95 (95%)                                 │
│  • Drag handle or content to resize                         │
│  • Swipe down past min to dismiss                           │
│  • Tap barrier (dimmed area) to dismiss                     │
│                                                             │
└─────────────────────────────────────────────────────────────┘

STYLING:
• Background: AppColors.surface (#1E1E1E)
• Top border radius: 20px
• Handle: 40px × 4px, grey[600], 2px border radius
• Header padding: 20px
• Header divider: 1px, AppColors.border
• Content padding: 20px
• Button: Full width, primary blue, 16px vertical padding

EXAMPLES:
1. ScanReceiptSheet (initialChildSize: 0.8)
2. NewNoteSheet (initialChildSize: 0.7)
3. CreateAnnouncementSheet
4. SiteDetailSheet
5. EquipmentDetailSheet
6. CourseDetailView
```

---

## Component Hierarchy Tree

```
MaterialApp
  └─ MainNavigationScreen (Stateful)
      └─ LayoutBuilder (Responsive breakpoint at 600px)
          ├─ Desktop (≥600px)
          │   └─ Row
          │       ├─ Sidebar (240px)
          │       │   ├─ Logo + Brand
          │       │   ├─ Divider
          │       │   ├─ Nav Items List
          │       │   │   └─ Nav Item Buttons (10)
          │       │   ├─ Divider
          │       │   └─ User Profile
          │       └─ PortalShell (Expanded)
          │           └─ Row
          │               ├─ Selected Screen Widget (Expanded)
          │               │   ├─ HomeView
          │               │   ├─ WorkView
          │               │   ├─ OperationsView
          │               │   ├─ LocationsView
          │               │   ├─ PeopleView
          │               │   ├─ KnowledgeHomeView
          │               │   ├─ ContinuingEducationHomeView
          │               │   ├─ EquipmentHomeView
          │               │   ├─ ExpensesHomeView
          │               │   └─ SettingsView
          │               └─ EVA Panel (400px or 56px)
          │                   ├─ EvaPanel (Expanded)
          │                   │   ├─ Header
          │                   │   ├─ Conversation Canvas
          │                   │   └─ Input Bar
          │                   └─ EvaCollapseRail (Collapsed)
          │                       ├─ Indicator Button
          │                       ├─ Unread Dot
          │                       └─ Rotated Text
          └─ Mobile (<600px)
              └─ Column
                  ├─ PortalShell
                  │   └─ Row
                  │       ├─ Selected Screen (Expanded)
                  │       └─ EVA Collapsed Rail (56px)
                  └─ BottomNavigationBar
                      └─ Nav Items (First 5 only)

PROVIDERS (Global):
• AppDatabase (Singleton)
• WeatherUpdateManager (Singleton)
• EvaState (ChangeNotifier)
• NavigationState (ChangeNotifier)
```

---

## Dimension Quick Reference

### Layout Dimensions
```
Sidebar Width:           240px
EVA Expanded:            400px
EVA Collapsed:           56px
Header Height:           64px
Button Height:           40px
Nav Item Height:         48px
Bottom Nav Height:       56px
Handle Bar:              40px × 4px
```

### Spacing Values
```
XS:   4px
SM:   8px
MD:   16px
LG:   24px
XL:   32px
XXL:  48px
```

### Border Radius
```
SM:   4px   (Tags)
MD:   8px   (Buttons, Inputs)
LG:   12px  (Cards)
XL:   16px  (Large Cards, Modals)
```

### Font Sizes
```
XS:   10px  (Tags, Labels)
SM:   12px  (Timestamps)
MD:   14px  (Body Text)
LG:   16px  (Card Titles)
XL:   18px  (App Title)
XXL:  20px  (Section Titles)
Huge: 24px  (Large Headings)
Mass: 32px  (KPI Numbers)
```

### Icon Sizes
```
XS:   16px  (Small icons)
SM:   20px  (Activity icons)
MD:   24px  (Standard icons)
LG:   32px  (Card icons)
XL:   48px  (Logo)
```

---

**End of ASCII Layout Maps**
