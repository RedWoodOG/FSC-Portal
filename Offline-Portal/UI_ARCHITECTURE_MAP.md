# FSC Portal Offline - UI Architecture Map

**Version:** 2.0.26  
**Last Updated:** January 31, 2026  
**Purpose:** Complete architectural overview of the UI structure, navigation system, and layout patterns

---

## Table of Contents

1. [Application Architecture Overview](#application-architecture-overview)
2. [Layout Foundation](#layout-foundation)
3. [Navigation System](#navigation-system)
4. [Responsive Behavior](#responsive-behavior)
5. [State Management](#state-management)
6. [Data Flow Architecture](#data-flow-architecture)

---

## Application Architecture Overview

### High-Level Structure

The FSC Portal Offline application follows a **shell-based architecture** with persistent UI elements and swappable content views.

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         PortalOfflineApp                                │
│                        (MaterialApp Root)                               │
│                                                                         │
│  ┌───────────────────────────────────────────────────────────────────┐ │
│  │                  MainNavigationScreen                             │ │
│  │                   (Stateful Widget)                               │ │
│  │                                                                   │ │
│  │  ┌─────────────────────────────────────────────────────────────┐ │ │
│  │  │                    LayoutBuilder                            │ │ │
│  │  │              (Responsive Breakpoint)                        │ │ │
│  │  │                                                             │ │ │
│  │  │  Desktop (≥600px)        │        Mobile (<600px)          │ │ │
│  │  │  ┌──────────────────────┐│┌──────────────────────────────┐ │ │ │
│  │  │  │ Row Layout           │││ Column Layout                │ │ │ │
│  │  │  │                      │││                              │ │ │ │
│  │  │  │ ┌──────────────────┐ │││ ┌──────────────────────────┐ │ │ │
│  │  │  │ │ Sidebar Nav      │ │││ │ Content Area             │ │ │ │
│  │  │  │ │ (240px fixed)    │ │││ │ (Expanded)               │ │ │ │
│  │  │  │ └──────────────────┘ │││ └──────────────────────────┘ │ │ │
│  │  │  │ ┌──────────────────┐ │││ ┌──────────────────────────┐ │ │ │
│  │  │  │ │ PortalShell      │ │││ │ Bottom Nav Bar           │ │ │ │
│  │  │  │ │ (Expanded)       │ │││ │ (Fixed, 5 items)         │ │ │ │
│  │  │  │ └──────────────────┘ │││ └──────────────────────────┘ │ │ │
│  │  │  └──────────────────────┘│└──────────────────────────────┘ │ │ │
│  │  └─────────────────────────────────────────────────────────────┘ │ │
│  └───────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
```

### Architecture Layers

**Layer 1: Application Root**
- **File:** `lib/main.dart` (lines 137-149)
- **Component:** `PortalOfflineApp` (StatelessWidget)
- **Purpose:** MaterialApp configuration, theme setup, initial route
- **Configuration:**
  - Dark theme only (`AppTheme.darkTheme`)
  - Material 3 design system
  - No debug banner
  - Home: `MainNavigationScreen`

**Layer 2: Navigation Shell**
- **File:** `lib/main.dart` (lines 151-452)
- **Component:** `MainNavigationScreen` (StatefulWidget)
- **Purpose:** Main navigation controller and screen switcher
- **Responsibilities:**
  - Manages 10 navigation destinations
  - Handles responsive layout switching
  - Provides navigation sidebar (desktop) or bottom bar (mobile)
  - Wraps content in `PortalShell`

**Layer 3: Portal Shell**
- **File:** `lib/app_shell/portal_shell.dart` (lines 7-37)
- **Component:** `PortalShell` (StatelessWidget)
- **Purpose:** Core layout container with EVA integration
- **Structure:** Horizontal Row with main content + EVA panel

**Layer 4: Content Views**
- **Location:** `lib/features/*/`
- **Purpose:** Individual screen implementations
- **Count:** 10 main views + supporting dialogs/sheets

---

## Layout Foundation

### Portal Shell Architecture

The `PortalShell` is the **foundational layout component** that wraps all main content views.

**Source:** `lib/app_shell/portal_shell.dart`

```
┌─────────────────────────────────────────────────────────────────────────┐
│                            PortalShell                                  │
│                         (Horizontal Row)                                │
│                                                                         │
│  ┌──────────────────────────────────────────┬────────────────────────┐ │
│  │                                          │                        │ │
│  │  Main Content Area                       │    EVA Panel           │ │
│  │  (Expanded - Takes Remaining Width)      │    (Fixed Width)       │ │
│  │                                          │                        │ │
│  │  ┌────────────────────────────────────┐  │  ┌──────────────────┐ │ │
│  │  │                                    │  │  │                  │ │ │
│  │  │  Current Screen Widget             │  │  │  EvaPanel        │ │ │
│  │  │  (e.g., HomeView, WorkView, etc.)  │  │  │  (400px wide)    │ │ │
│  │  │                                    │  │  │                  │ │ │
│  │  │  - Receives full vertical space    │  │  │  OR              │ │ │
│  │  │  - Width = Screen - Sidebar - EVA  │  │  │                  │ │ │
│  │  │  - Scrollable content              │  │  │  EvaCollapseRail │ │ │
│  │  │  - No fixed positioning            │  │  │  (56px wide)     │ │ │
│  │  │                                    │  │  │                  │ │ │
│  │  └────────────────────────────────────┘  │  └──────────────────┘ │ │
│  │                                          │                        │ │
│  └──────────────────────────────────────────┴────────────────────────┘ │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘

Key Principle: NO Stack, NO Overlay, NO Drawer
- Clean horizontal layout only
- EVA always visible (expanded or collapsed)
- Main content resizes automatically when EVA state changes
```

**Layout Code (lines 24-36):**
```dart
Row(
  children: [
    // Main Content Area (LEFT)
    Expanded(child: child),
    
    // EVA Panel (RIGHT) - Always present
    evaState.isExpanded
        ? const EvaPanel()           // 400px
        : const EvaCollapseRail(),   // 56px
  ],
)
```

### Desktop Layout (≥600px)

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                              Window (Full Screen)                               │
│                                                                                 │
│  ┌──────────────┬──────────────────────────────────────────┬─────────────────┐ │
│  │              │                                          │                 │ │
│  │  Sidebar     │           Main Content                   │   EVA Panel     │ │
│  │  Navigation  │           (PortalShell Child)            │                 │ │
│  │              │                                          │                 │ │
│  │  240px       │           Expanded Width                 │   400px / 56px  │ │
│  │  Fixed       │           (Responsive)                   │   Fixed         │ │
│  │              │                                          │                 │ │
│  │  ┌────────┐  │  ┌────────────────────────────────────┐  │  ┌───────────┐  │ │
│  │  │ Logo   │  │  │                                    │  │  │ Header    │  │ │
│  │  │ Portal │  │  │  Screen-Specific Content           │  │  │ EVA       │  │ │
│  │  └────────┘  │  │  (HomeView, WorkView, etc.)        │  │  ├───────────┤  │ │
│  │  ┌────────┐  │  │                                    │  │  │ Messages  │  │ │
│  │  │ Home   │  │  │  - Headers                         │  │  │ Canvas    │  │ │
│  │  ├────────┤  │  │  - Data cards                      │  │  │           │  │ │
│  │  │ Work   │  │  │  - Lists                           │  │  │ (Scroll)  │  │ │
│  │  ├────────┤  │  │  - Forms                           │  │  │           │  │ │
│  │  │ Ops    │  │  │  - Interactive elements            │  │  ├───────────┤  │ │
│  │  ├────────┤  │  │                                    │  │  │ Input Bar │  │ │
│  │  │ ...    │  │  │  Full vertical height              │  │  └───────────┘  │ │
│  │  └────────┘  │  │  Scrollable if needed              │  │                 │ │
│  │  ┌────────┐  │  └────────────────────────────────────┘  │                 │ │
│  │  │ User   │  │                                          │                 │ │
│  │  │ Profile│  │                                          │                 │ │
│  │  └────────┘  │                                          │                 │ │
│  │              │                                          │                 │ │
│  └──────────────┴──────────────────────────────────────────┴─────────────────┘ │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘

Dimensions:
- Sidebar: 240px (AppLayout.sidebarWidth)
- EVA Expanded: 400px
- EVA Collapsed: 56px
- Main Content: Remaining width (dynamic)

Example Screen Widths:
- 1920px screen: 240 + 1280 + 400 = 1920px
- 1920px (EVA collapsed): 240 + 1624 + 56 = 1920px
- 1366px screen: 240 + 726 + 400 = 1366px
```

### Mobile Layout (<600px)

```
┌─────────────────────────────────────────┐
│         Window (Mobile/Tablet)          │
│                                         │
│  ┌───────────────────────────────────┐  │
│  │                                   │  │
│  │      Main Content                 │  │
│  │      (PortalShell Child)          │  │
│  │                                   │  │
│  │      Full Width                   │  │
│  │                                   │  │
│  │  ┌─────────────────────────────┐  │  │
│  │  │                             │  │  │
│  │  │  Screen Content             │  │  │
│  │  │                             │  │  │
│  │  │  - Stacked vertically       │  │  │
│  │  │  - Full width cards         │  │  │
│  │  │  - Simplified layout        │  │  │
│  │  │                             │  │  │
│  │  │  (Scrollable)               │  │  │
│  │  │                             │  │  │
│  │  └─────────────────────────────┘  │  │
│  │                                   │  │
│  └───────────────────────────────────┘  │
│  ┌───────────────────────────────────┐  │
│  │     Bottom Navigation Bar         │  │
│  │  [Home] [Work] [Ops] [Loc] [Ppl]  │  │
│  └───────────────────────────────────┘  │
│                                         │
└─────────────────────────────────────────┘

Notes:
- No sidebar navigation
- Bottom bar shows first 5 destinations only
- EVA panel still present (collapsed on right side)
- Reduced to single column layout
```

---

## Navigation System

### Navigation Destinations

**Total Screens:** 10  
**Navigation Type:** Index-based (0-9)  
**State Management:** `NavigationState` (ChangeNotifier)

**Source:** `lib/main.dart` (lines 207-235)

| Index | Icon | Label | Screen Widget | Purpose |
|-------|------|-------|---------------|---------|
| 0 | `Icons.home` | Home | `HomeView` | Dashboard with KPIs, weather, news |
| 1 | `Icons.work` | Work | `WorkView` | Work order management |
| 2 | `Icons.settings` | Operations | `OperationsView` | Clients, sites, equipment |
| 3 | `Icons.location_on` | Locations | `LocationsView` | Interactive map with routes |
| 4 | `Icons.people` | People | `PeopleView` | Team directory |
| 5 | `Icons.library_books` | Knowledge | `KnowledgeHomeView` | Knowledge base search |
| 6 | `Icons.school` | Training | `ContinuingEducationHomeView` | Course catalog |
| 7 | `Icons.inventory` | Equipment | `EquipmentHomeView` | Equipment inventory |
| 8 | `Icons.receipt_long` | Expenses | `ExpensesHomeView` | Expense tracking (placeholder) |
| 9 | `Icons.settings_applications` | Settings | `SettingsView` | System configuration |

### Navigation State Manager

**File:** `lib/app_shell/navigation_state.dart`

**Class:** `NavigationState extends ChangeNotifier`

**Properties:**
- `_selectedIndex`: Current navigation index (private)
- `selectedIndex`: Public getter

**Methods:**
```dart
void navigateTo(int index)        // Navigate to specific index
void navigateToHome()             // Navigate to index 0
void navigateToWork()             // Navigate to index 1
void navigateToOperations()       // Navigate to index 2
void navigateToLocations()        // Navigate to index 3
void navigateToPeople()           // Navigate to index 4
void navigateToKnowledge()        // Navigate to index 5
void navigateToSettings()         // Navigate to index 6
```

**Usage Pattern:**
```dart
// In any widget with Provider context:
final navState = context.read<NavigationState>();
navState.navigateToLocations(); // Switches to map view

// Watching for changes:
final navState = context.watch<NavigationState>();
final currentIndex = navState.selectedIndex;
```

### Navigation UI Components

#### Desktop Sidebar Navigation (lines 259-383)

**Structure:**
```
┌────────────────────────┐
│  Sidebar Container     │
│  240px width           │
│  ┌──────────────────┐  │
│  │ Logo & Brand     │  │ ← 24px padding, logo.webp (48px) + "Portal" text
│  ├──────────────────┤  │
│  │ Divider          │  │ ← 1px, white10
│  ├──────────────────┤  │
│  │                  │  │
│  │ Nav Items List   │  │ ← ListView.builder, 8px vertical padding
│  │ ┌──────────────┐ │  │
│  │ │ [Icon] Home  │ │  │ ← Active: primary blue bg, white text
│  │ ├──────────────┤ │  │
│  │ │ [Icon] Work  │ │  │ ← Inactive: transparent bg, grey text
│  │ ├──────────────┤ │  │
│  │ │ [Icon] Ops   │ │  │
│  │ │ ...          │ │  │
│  │ └──────────────┘ │  │
│  │                  │  │
│  ├──────────────────┤  │
│  │ Divider          │  │ ← 1px, white10
│  ├──────────────────┤  │
│  │ User Profile     │  │ ← 16px padding
│  │ [Avatar] Name    │  │ ← Clickable, opens UserDetailsDialog
│  │          Role    │  │ ← Shows current user info
│  └──────────────────┘  │
└────────────────────────┘
```

**Nav Item Specs (lines 413-451):**
- Height: 48px (implicit from padding)
- Horizontal padding: 16px
- Vertical padding: 12px
- Margin: 8px horizontal, 2px vertical
- Border radius: 8px
- Icon size: 24px (`AppLayout.navIconSize`)
- Icon-text gap: 12px

**Active State:**
- Background: `AppColors.primary` (#0056D2)
- Text color: White
- Icon color: `AppColors.primary`
- Font: SemiBold, 14px

**Inactive State:**
- Background: Transparent
- Text color: `AppColors.textSecondary` (grey)
- Icon color: `AppColors.textSecondary`
- Font: Normal, 14px

#### Mobile Bottom Navigation (lines 392-407)

**Structure:**
```
┌─────────────────────────────────────────────────────────┐
│              BottomNavigationBar                        │
│  [Icon] [Icon] [Icon] [Icon] [Icon]                     │
│   Home   Work   Ops    Loc    Ppl                       │
└─────────────────────────────────────────────────────────┘
```

**Specifications:**
- Type: `BottomNavigationBarType.fixed`
- Background: `AppColors.background` (#121212)
- Selected color: `AppColors.primary` (#0056D2)
- Unselected color: `AppColors.textSecondary` (#B0B0B0)
- Items: First 5 destinations only (indices 0-4)
- Limitation: Remaining screens (5-9) not accessible from bottom bar

**Navigation Logic (line 399):**
```dart
currentIndex: selectedIndex >= 5 ? 0 : selectedIndex
```
If user navigates to index ≥5 via other means, bottom bar shows Home as active.

### Navigation Flow Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                      User Action                                │
│  (Click nav item / Tap bottom bar / Programmatic navigation)    │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│              NavigationState.navigateTo(index)                  │
│                                                                 │
│  1. Check if index != _selectedIndex                            │
│  2. Update _selectedIndex = index                               │
│  3. Call notifyListeners()                                      │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│           MainNavigationScreen.build() Triggered                │
│                (via context.watch<NavigationState>())           │
│                                                                 │
│  1. Read selectedIndex from NavigationState                     │
│  2. Update sidebar/bottom bar active item styling               │
│  3. Select corresponding screen widget from _screens list       │
│  4. Pass selected widget to PortalShell                         │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                  PortalShell.build()                            │
│                                                                 │
│  1. Wrap child (selected screen) in Expanded                    │
│  2. Add EVA panel to the right                                  │
│  3. Render as horizontal Row                                    │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    Screen Rendered                              │
│         (e.g., HomeView, WorkView, LocationsView)               │
│                                                                 │
│  - Screen receives full layout space                            │
│  - Can access NavigationState for further navigation            │
│  - Can trigger navigation to other screens                      │
└─────────────────────────────────────────────────────────────────┘
```

---

## Responsive Behavior

### Breakpoint System

**Primary Breakpoint:** 600px  
**Location:** `lib/main.dart` (line 241)

```dart
LayoutBuilder(
  builder: (context, constraints) {
    final bool isMobile = constraints.maxWidth < 600;
    // ...
  }
)
```

**Layout Decisions:**

| Screen Width | Layout Mode | Sidebar | Bottom Bar | EVA Panel |
|--------------|-------------|---------|------------|-----------|
| < 600px | Mobile | Hidden | Visible (5 items) | Collapsed (56px) |
| ≥ 600px | Desktop | Visible (240px) | Hidden | Expanded/Collapsed |

### Secondary Breakpoints (Screen-Specific)

**Home View:** 1100px  
**Location:** `lib/features/home/home_view.dart`

```dart
final isWide = MediaQuery.of(context).size.width > 1100;

// Wide layout: 7:3 column split (main content : sidebar)
// Narrow layout: Single column, stacked vertically
```

**Impact:**
- **Wide (>1100px):** Two-column dashboard with tactical sidebar
- **Narrow (≤1100px):** Single column, components stack vertically

### Responsive Content Adaptation

**Grid Layouts:**
- **People View:** 5-column grid (desktop), adjusts on smaller screens
- **Home Tactical Shortcuts:** 2x2 grid (desktop), may stack on mobile

**Scrolling:**
- **Horizontal scroll:** News feeds, announcement cards (maintained on all sizes)
- **Vertical scroll:** Main content area (all screens)

**Font Scaling:**
- Uses fixed pixel sizes (no responsive scaling)
- Relies on OS-level accessibility settings

---

## State Management

### Provider Architecture

**Setup:** `lib/main.dart` (lines 124-134)

```dart
MultiProvider(
  providers: [
    Provider<AppDatabase>.value(value: database),
    Provider<WeatherUpdateManager>.value(value: weatherManager),
    ChangeNotifierProvider<EvaState>.value(value: evaState),
    ChangeNotifierProvider<NavigationState>.value(value: navigationState),
  ],
  child: const PortalOfflineApp(),
)
```

**Provider Types:**

1. **AppDatabase** (Singleton Provider)
   - Type: `Provider<AppDatabase>`
   - Scope: Global
   - Purpose: SQLite database access
   - Usage: `context.read<AppDatabase>()`

2. **WeatherUpdateManager** (Singleton Provider)
   - Type: `Provider<WeatherUpdateManager>`
   - Scope: Global
   - Purpose: Periodic weather updates
   - Usage: `context.read<WeatherUpdateManager>()`

3. **EvaState** (ChangeNotifier Provider)
   - Type: `ChangeNotifierProvider<EvaState>`
   - File: `lib/app_shell/eva_state.dart`
   - Purpose: EVA panel state (expanded/collapsed, pending queries)
   - Properties:
     - `isExpanded`: bool
     - `isThinking`: bool
     - `hasUnread`: bool
     - `_pendingQuery`: String?
   - Methods:
     - `setExpanded(bool value)`
     - `setThinking(bool value)`
     - `setHasUnread(bool value)`
     - `setPendingQuery(String query)`
     - `consumePendingQuery()`
     - `setDatabase(AppDatabase db)`

4. **NavigationState** (ChangeNotifier Provider)
   - Type: `ChangeNotifierProvider<NavigationState>`
   - File: `lib/app_shell/navigation_state.dart`
   - Purpose: Main navigation index
   - Properties:
     - `selectedIndex`: int
   - Methods:
     - `navigateTo(int index)`
     - Helper methods for specific screens

### State Access Patterns

**Read (one-time access):**
```dart
final db = context.read<AppDatabase>();
final navState = context.read<NavigationState>();
navState.navigateToHome();
```

**Watch (rebuild on changes):**
```dart
final evaState = context.watch<EvaState>();
final isExpanded = evaState.isExpanded;
// Widget rebuilds when isExpanded changes
```

**Select (rebuild on specific property):**
```dart
final selectedIndex = context.select<NavigationState, int>(
  (state) => state.selectedIndex,
);
// Widget rebuilds only when selectedIndex changes
```

---

## Data Flow Architecture

### Database-Driven UI Pattern

**All data flows from SQLite → StreamBuilder → UI**

```
┌─────────────────────────────────────────────────────────────────┐
│                      SQLite Database                            │
│                    (app_database.dart)                          │
│                                                                 │
│  Tables: Users, Sites, Clients, Equipment, WorkOrders,          │
│          Notes, Documents, WeatherSnapshot, etc.                │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         │ Stream<T> methods (watch*)
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│                    Drift Database Streams                       │
│                                                                 │
│  Examples:                                                      │
│  - watchLatestWeather() → Stream<WeatherSnapshotData?>          │
│  - watchOpenCallsCount() → Stream<int>                          │
│  - watchActiveCompanyAnnouncements() → Stream<List<...>>        │
│  - watchAllSites() → Stream<List<Site>>                         │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         │ Subscribed by StreamBuilder
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│                      StreamBuilder Widget                       │
│                                                                 │
│  stream: db.watchLatestWeather(),                               │
│  builder: (context, snapshot) {                                 │
│    if (!snapshot.hasData) return LoadingIndicator();            │
│    final weather = snapshot.data;                               │
│    return WeatherCard(weather: weather);                        │
│  }                                                              │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         │ Renders UI
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│                        UI Components                            │
│                    (Auto-updating on data changes)              │
│                                                                 │
│  - Weather cards update when weather changes                    │
│  - KPI tiles update when counts change                          │
│  - News feeds update when new briefings added                   │
│  - Work order lists update when orders created/updated          │
└─────────────────────────────────────────────────────────────────┘
```

### Data Update Flow (User Actions)

```
User Action (e.g., Create Work Order)
        │
        ▼
┌─────────────────────────────┐
│  UI Event Handler           │
│  (e.g., button onPressed)   │
└─────────────┬───────────────┘
              │
              ▼
┌─────────────────────────────┐
│  Database Insert/Update     │
│  await db.insertWorkOrder() │
└─────────────┬───────────────┘
              │
              ▼ (Drift emits new stream value)
┌─────────────────────────────┐
│  Stream Updates             │
│  - watchAllWorkOrders()     │
│  - watchOpenCallsCount()    │
└─────────────┬───────────────┘
              │
              ▼ (StreamBuilder rebuilds)
┌─────────────────────────────┐
│  UI Auto-Refreshes          │
│  - Work order list updates  │
│  - KPI count increments     │
└─────────────────────────────┘
```

### Offline-First Architecture

**Key Principle:** All data operations are local-first

1. **No Network Dependency:**
   - App works completely offline
   - SQLite database is the single source of truth
   - No API calls required for core functionality

2. **Optional Network Features:**
   - Weather updates (via wttr.in API) - optional
   - News feed images (network URLs) - fallback to placeholders

3. **Data Persistence:**
   - All user data persists between app restarts
   - Database location: `%AppData%/portal_offline.sqlite` (Windows)
   - Seeded with demo data on first run

---

## File Structure Reference

```
lib/
├── main.dart                          # App entry, navigation shell
├── app_shell/
│   ├── portal_shell.dart              # Core layout container
│   ├── eva_panel.dart                 # EVA expanded panel
│   ├── eva_collapse_rail.dart         # EVA collapsed rail
│   ├── eva_state.dart                 # EVA state management
│   └── navigation_state.dart          # Navigation state management
├── features/
│   ├── home/
│   │   └── home_view.dart             # Dashboard (index 0)
│   ├── work/
│   │   └── work_view.dart             # Work orders (index 1)
│   ├── operations/
│   │   └── operations_view.dart       # Clients/Sites (index 2)
│   ├── locations/
│   │   └── locations_view.dart        # Map view (index 3)
│   ├── people/
│   │   └── people_view.dart           # Team directory (index 4)
│   ├── knowledge/
│   │   └── knowledge_home_view.dart   # Knowledge base (index 5)
│   ├── continuing_education/
│   │   └── continuing_education_home_view.dart  # Training (index 6)
│   ├── equipment/
│   │   └── equipment_home_view.dart   # Equipment (index 7)
│   ├── expenses/
│   │   └── expenses_home_view.dart    # Expenses (index 8)
│   └── settings/
│       └── settings_view.dart         # Settings (index 9)
├── theme/
│   └── app_theme.dart                 # Complete design system
├── widgets/
│   ├── glass_card.dart                # Glassmorphism component
│   ├── news_card.dart                 # Announcement card
│   └── news_feed.dart                 # News feed widget
└── database/
    ├── app_database.dart              # Database definition
    └── seed_service.dart              # Demo data seeder
```

---

## Summary

The FSC Portal Offline UI architecture is built on these core principles:

1. **Shell-Based Layout:** Persistent `PortalShell` with EVA integration
2. **Index-Based Navigation:** Simple integer-based screen switching
3. **Responsive Design:** Desktop (sidebar) and mobile (bottom bar) layouts
4. **Provider State:** Centralized state via Provider pattern
5. **Stream-Driven UI:** Real-time updates via Drift database streams
6. **Offline-First:** No network dependency for core features
7. **Material 3:** Modern design system with dark theme

This architecture provides a solid foundation for a performant, maintainable, and user-friendly offline application.

---

**End of UI Architecture Map**
