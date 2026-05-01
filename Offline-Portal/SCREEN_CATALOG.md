# FSC Portal Offline - Screen Catalog

**Version:** 2.0.26  
**Last Updated:** January 31, 2026  
**Purpose:** Detailed breakdown of all 10 main screens with component specifications

---

## Table of Contents

1. [Screen 0: Home (Dashboard)](#screen-0-home-dashboard)
2. [Screen 1: Work Orders](#screen-1-work-orders)
3. [Screen 2: Operations](#screen-2-operations)
4. [Screen 3: Locations (Map)](#screen-3-locations-map)
5. [Screen 4: People](#screen-4-people)
6. [Screen 5: Knowledge Base](#screen-5-knowledge-base)
7. [Screen 6: Continuing Education](#screen-6-continuing-education)
8. [Screen 7: Equipment](#screen-7-equipment)
9. [Screen 8: Expenses](#screen-8-expenses)
10. [Screen 9: Settings](#screen-9-settings)

---

## Screen 0: Home (Dashboard)

**File:** `lib/features/home/home_view.dart`  
**Navigation Index:** 0  
**Icon:** `Icons.home`  
**Label:** "Home"

### Purpose

The Home screen serves as the main dashboard, providing a comprehensive overview of daily operations, KPIs, weather, tactical shortcuts, and company/industry news.

### Layout Modes

**Responsive Breakpoint:** 1100px

**Wide Mode (>1100px):**
```
┌────────────────────────────────────────────────────┬──────────────────┐
│                                                    │                  │
│  Header Section                                    │  Status Panel    │
│  Morning Briefing Card                             │                  │
│  KPI Row (3 tiles)                                 │  Mission         │
│  Tactical Shortcuts (2x2 grid)                     │  Duration        │
│  Industry Briefing (News Feed)                     │                  │
│  Corporate Intel (Announcements)                   │  Progress Bar    │
│                                                    │                  │
│  (7 columns)                                       │  (3 columns)     │
└────────────────────────────────────────────────────┴──────────────────┘
```

**Narrow Mode (≤1100px):**
```
┌──────────────────────────────────────────────────────┐
│  Header Section                                      │
│  Morning Briefing Card                               │
│  KPI Row (3 tiles)                                   │
│  Status Panel                                        │
│  Tactical Shortcuts (2x2 grid)                       │
│  Industry Briefing                                   │
│  Corporate Intel                                     │
│  (Single column, stacked)                            │
└──────────────────────────────────────────────────────┘
```

### Components Breakdown

#### 1. Header Section

**Visual Structure:**
```
┌─────────────────────────────────────────────────────────────────────┐
│  [🔷]  FIELD SERVICE PORTAL              [Search Bar]  [Profile]    │
│   Logo  ● OPERATIONAL STATE: SECURE                                 │
└─────────────────────────────────────────────────────────────────────┘
```

**Elements:**
- **Logo Container:**
  - Size: 48x48px
  - Gradient background (primary gradient)
  - Bolt icon
  - Border radius: 12px
  - Box shadow: Colored glow
  - Hero animation

- **Title:**
  - Text: "FIELD SERVICE PORTAL"
  - Font: 24px, bold
  - Letter spacing: Increased
  - Color: White

- **Status Indicator:**
  - Green dot (8px diameter)
  - Text: "OPERATIONAL STATE: SECURE"
  - Font: 12px
  - Color: Success green

- **Search Button:**
  - GlassCard component
  - Search icon + "Quick Search (CTRL + K)" hint
  - Placeholder (functionality not implemented)

- **Profile Circle:**
  - Gradient border
  - Person icon
  - Size: 40px diameter
  - Clickable (opens user profile)

**Spacing:** 24px between elements

---

#### 2. Morning Briefing Card

**Data Source:** `StreamBuilder<WeatherSnapshotData?>`  
**Stream:** `db.watchLatestWeather()`

**Visual Structure:**
```
┌────────────────────────────────────────────────────────────┐
│  ┌──────────────────────────┬──────────────────────────┐  │
│  │ ATMOSPHERIC CONDITIONS   │ LOGISTIC FEEDBACK        │  │
│  │                          │                          │  │
│  │  [☁] 72°F                │  [🧭] TRAFFIC: MODERATE  │  │
│  │  Cloudy                  │  Scanning first stop...  │  │
│  │                          │                          │  │
│  └──────────────────────────┴──────────────────────────┘  │
└────────────────────────────────────────────────────────────┘
```

**Left Side - Weather:**
- Label: "ATMOSPHERIC CONDITIONS" (10px, uppercase, letter-spaced)
- Icon: Dynamic based on condition
  - `Icons.cloud` - Cloudy
  - `Icons.umbrella` - Rainy
  - `Icons.wb_sunny` - Clear/Sunny
  - Default: Cloud
- Temperature: 32px, bold, white, suffix "°F"
- Condition: 14px, grey

**Right Side - Traffic/Logistics:**
- Label: "LOGISTIC FEEDBACK"
- Navigation icon in colored container
- Traffic status: "TRAFFIC: [CONDITION]"
  - Color-coded: Red (heavy), Green (light), Grey (moderate)
- Route: Shows current route or "SCANNING FIRST STOP..."

**Styling:**
- GlassCard component
- Border radius: 24px
- Padding: 32px
- Vertical divider between sections

---

#### 3. KPI Row

**Data Sources:** 3 separate StreamBuilders  
**Streams:**
- `db.watchOpenCallsCount()`
- `db.watchCompletedCallsCount()`
- `db.watchWeeklyCallsCount()`

**Visual Structure:**
```
┌──────────────┬──────────────┬──────────────┐
│  ACTIVE      │  COMPLETED   │  WEEKLY      │
│  DEPLOYMENTS │  MISSIONS    │  THROUGHPUT  │
│              │              │              │
│    12   📋   │    45   ✓    │    67   📊   │
│    ━━        │    ━━        │    ━━        │
│              │              │              │
└──────────────┴──────────────┴──────────────┘
```

**KPI Tile Structure:**

Each tile (GlassCard):
- **Label:** Uppercase, 10px, letter-spaced, white38
- **Value:** 32px, bold, white
- **Accent Bar:** 2px height, 40px width, colored
- **Icon:** Top-right corner, 24px
- **Border:** Active border color (optional)

**Tile Specifications:**

1. **Active Deployments:**
   - Icon: `assignment_turned_in_outlined`
   - Color: `AppColors.primary` (blue)
   - Label: "ACTIVE DEPLOYMENTS"

2. **Completed Missions:**
   - Icon: `verified_outlined`
   - Color: `AppColors.success` (green)
   - Label: "COMPLETED MISSIONS"

3. **Weekly Throughput:**
   - Icon: `leaderboard_outlined`
   - Color: `Colors.purpleAccent`
   - Label: "WEEKLY THROUGHPUT"

**Layout:** Horizontal Row, equal flex (1:1:1)  
**Gap:** 24px between tiles

---

#### 4. Tactical Shortcuts

**Visual Structure:**
```
┌──────────────────┬──────────────────┐
│  [📷]            │  [📝]            │
│  SCAN RECEIPTS   │  INTEL ENTRY     │
│                  │                  │
├──────────────────┼──────────────────┤
│  [🗺]            │  [⚙]            │
│  THEATRE MAP     │  AGENT TOOLS     │
│                  │                  │
└──────────────────┴──────────────────┘
```

**GridView Specifications:**
- Type: 2x2 non-scrollable grid
- Cross-axis count: 2
- Shrink wrap: true
- Physics: NeverScrollable

**Action Tile Structure:**

Each tile (GlassCard with onTap):
- Icon: Centered, 28px
- Label: Below icon, 11px, bold, uppercase, letter-spaced
- Padding: 20px
- Border radius: 16px

**Tile Definitions:**

1. **SCAN RECEIPTS**
   - Icon: `qr_code_scanner`
   - Color: `AppColors.primary` (blue)
   - Action: Opens `ScanReceiptSheet` modal

2. **INTEL ENTRY**
   - Icon: `edit_note`
   - Color: `Colors.orangeAccent`
   - Action: Opens `NewNoteSheet` modal

3. **THEATRE MAP**
   - Icon: `map_outlined`
   - Color: `Colors.greenAccent`
   - Action: `NavigationState().navigateToLocations()`

4. **AGENT TOOLS**
   - Icon: `terminal`
   - Color: `Colors.blueGrey`
   - Action: Navigate to `KnowledgeImportScreen`

---

#### 5. Status Panel (Wide Layout Only)

**Visual Structure:**
```
┌──────────────────────────┐
│  MISSION DURATION        │
│                          │
│  Mission Start    08:00  │ (green)
│  ─────────────────────   │
│  Estimated End    17:00  │ (white60)
│                          │
│  ████████░░░░░░   65%    │ (progress bar)
│                          │
└──────────────────────────┘
```

**Elements:**
- Title: "MISSION DURATION" (uppercase)
- Status rows:
  - Label: Left-aligned, 11px, white38
  - Value: Right-aligned, 13px, bold, colored
- Divider: Thin horizontal line
- Progress bar:
  - Height: 8px
  - Value: 65% (hardcoded)
  - Color: Primary blue
  - Border radius: 4px

---

#### 6. Industry Briefing (News Feed)

**Component:** `NewsFeedWidget`  
**File:** `lib/widgets/news_feed.dart`

**Data Source:** `StreamBuilder<List<IndustryBriefingData>>`  
**Stream:** `db.watchLatestIndustryBriefing(limit: 5)`

**Visual Structure:**
```
┌─────────────────────────────────────────────────────────────┐
│  Industry Briefing (5) • Last updated: 2 min ago   [RSS]    │
├─────────────────────────────────────────────────────────────┤
│  ┌────────┐  ┌────┐  ┌────┐  ┌────┐  ┌────┐               │
│  │Featured│  │Item│  │Item│  │Item│  │Item│  ──►          │
│  └────────┘  └────┘  └────┘  └────┘  └────┘               │
│  (300px)     (160px each)                                   │
└─────────────────────────────────────────────────────────────┘
   Height: 220px, Horizontal scroll
```

**Header:**
- Title: "Industry Briefing"
- Count badge: "(5)"
- Last update: Time ago
- RSS icon: Right-aligned

**Card Types:**
- **Featured (first):** 300px wide, full image background, gradient overlay
- **Regular:** 160px wide, compact layout

**Empty State:** "No industry news available"

---

#### 7. Corporate Intel (Announcements)

**Data Source:** `StreamBuilder<List<CompanyAnnouncement>>`  
**Stream:** `db.watchActiveCompanyAnnouncements()`

**Visual Structure:**
```
┌─────────────────────────────────────────────────────────────┐
│  CORPORATE INTEL              [+]  ACCESS ARCHIVE           │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐       │
│  │NewsCard │  │NewsCard │  │NewsCard │  │NewsCard │  ──►  │
│  └─────────┘  └─────────┘  └─────────┘  └─────────┘       │
│  (340px each)                                               │
└─────────────────────────────────────────────────────────────┘
   Height: 180px, Horizontal scroll
```

**Header:**
- Title: "CORPORATE INTEL"
- Add button: Opens `CreateAnnouncementSheet`
- Archive button: "ACCESS ARCHIVE" text button

**Cards:** NewsCard component (340px each)
- Left border: 4px, category-colored
- Icon + title
- Body text
- Optional action button

**Categories:**
- HR: Blue, security icon
- Safety: Red, warning icon
- Fleet: Orange, shipping icon
- General: Primary, info icon

---

### Data Streams Summary

| Component | Stream | Update Frequency |
|-----------|--------|------------------|
| Weather | `watchLatestWeather()` | Real-time |
| Active Deployments | `watchOpenCallsCount()` | Real-time |
| Completed Missions | `watchCompletedCallsCount()` | Real-time |
| Weekly Throughput | `watchWeeklyCallsCount()` | Real-time |
| Industry Briefing | `watchLatestIndustryBriefing(5)` | Real-time |
| Announcements | `watchActiveCompanyAnnouncements()` | Real-time |

### Screen Background

- Gradient: `AppGradients.deepOcean`
- Padding: 32px all sides
- Scroll: Vertical (SingleChildScrollView)

---

## Screen 1: Work Orders

**File:** `lib/features/work/work_view.dart`  
**Navigation Index:** 1  
**Icon:** `Icons.work`  
**Label:** "Work"

### Purpose

Manage and view work orders with filtering, pagination, and detailed views.

### Visual Layout

```
┌─────────────────────────────────────────────────────────────┐
│  Work Orders                          [+ Create Work Order] │
├─────────────────────────────────────────────────────────────┤
│  [All] [Open] [On Hold] [Completed]  (Filter Chips)        │
├─────────────────────────────────────────────────────────────┤
│  ┌───────────────────────────────────────────────────────┐ │
│  │ WO-001  [OPEN]  [HIGH]                                │ │
│  │ Site: Main Branch                                     │ │
│  │ Client: RBFCU                                         │ │
│  │ Description: ATM maintenance required                 │ │
│  │ Equipment: [ATM-9400] [ATM-9401]                      │ │
│  │ Assigned: John Doe                                    │ │
│  │ Created: 2026-01-15                                   │ │
│  └───────────────────────────────────────────────────────┘ │
│  ┌───────────────────────────────────────────────────────┐ │
│  │ WO-002  [ON_HOLD]  [MEDIUM]                           │ │
│  │ ...                                                   │ │
│  └───────────────────────────────────────────────────────┘ │
│  ...                                                        │
│  [Load More]                                                │
└─────────────────────────────────────────────────────────────┘
```

### Components

**AppBar:**
- Title: "Work Orders"
- Action: "Create Work Order" button → Opens `CreateWorkOrderSheet`

**Filter Chips:**
- Types: All, Open, On Hold, Completed
- Selected: Primary blue background
- Unselected: Transparent with border

**Work Order Card (GlassCard):**

Structure:
```
┌─────────────────────────────────────────────┐
│ WO-[ID]  [STATUS]  [PRIORITY]               │
│                                             │
│ Site: [Branch Name]                         │
│ Client: [Client Name] (theme-colored)       │
│ Description: [Work description]             │
│ Equipment: [Chip] [Chip] [Chip]             │
│ Assigned: [Technician Name]                 │
│ Created: [Date]                             │
└─────────────────────────────────────────────┘
```

**Status Badge Colors:**
- Open: Blue
- On Hold: Orange
- Completed: Green

**Priority Badge Colors:**
- High: Red
- Medium: Orange
- Low: Grey

**Pagination:**
- Items per page: 20
- Infinite scroll
- "Load More" button at bottom

### Data Flow

- **Initial Load:** Fetch first 20 work orders
- **Filter Change:** Reset pagination, fetch filtered set
- **Scroll to Bottom:** Fetch next 20 work orders
- **Card Tap:** Open work order detail dialog

---

## Screen 2: Operations

**File:** `lib/features/operations/operations_view.dart`  
**Navigation Index:** 2  
**Icon:** `Icons.settings`  
**Label:** "Operations"

### Purpose

Manage clients, sites, and equipment hierarchically.

### Visual Layout

```
┌─────────────────────────────────────────────────────────────┐
│  Operations                     [Filter: All Clients ▼]     │
├─────────────────────────────────────────────────────────────┤
│  [Clients]  [Equipment]  (Tab Selector)                     │
├─────────────────────────────────────────────────────────────┤
│  CLIENT VIEW:                                               │
│  ┌───────────────────────────────────────────────────────┐ │
│  │ RBFCU                                    [12 Locations]│ │
│  │ [View Sites]                                          │ │
│  └───────────────────────────────────────────────────────┘ │
│  ┌───────────────────────────────────────────────────────┐ │
│  │ Jefferson Credit Union                  [8 Locations] │ │
│  │ [View Sites]                                          │ │
│  └───────────────────────────────────────────────────────┘ │
│                                                             │
│  EQUIPMENT VIEW (when Equipment tab selected):              │
│  ┌───────────────────────────────────────────────────────┐ │
│  │ ATM-9400                     [WARRANTY] [CONTRACT]    │ │
│  │ Manufacturer: Hyosung                                 │ │
│  │ Model: MX8600                                         │ │
│  │ Serial: SN123456                                      │ │
│  │ Location: RBFCU Main Branch                           │ │
│  └───────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

### Navigation Hierarchy

```
Clients View
    ├─ Client List
    │   └─ Client Card → [View Sites]
    │       └─ Sites View (replaces client list)
    │           ├─ Back Button
    │           └─ Site Cards with Equipment Lists
    └─ Back to Clients

Equipment View
    └─ Equipment List (all equipment)
        ├─ Filtered by selected client (if filter active)
        └─ Equipment Cards
```

### Client Card

```
┌──────────────────────────────────────┐
│ [CLIENT NAME]       [X Locations]    │
│ ● Theme color dot                    │
│                                      │
│ [View Sites >]                       │
└──────────────────────────────────────┘
```

### Site Card (when viewing client sites)

```
┌──────────────────────────────────────┐
│ [BRANCH NAME]                        │
│ Address: [Full Address]              │
│ Region: [Region]                     │
│ Coordinates: [Lat, Lng]              │
│                                      │
│ Equipment ([count] items):           │
│ • [Equipment Type] - [Manufacturer]  │
│ • [Equipment Type] - [Manufacturer]  │
│ ...                                  │
└──────────────────────────────────────┘
```

### Equipment Card

```
┌──────────────────────────────────────────┐
│ [EQUIPMENT TYPE]  [WARRANTY] [CONTRACT]  │
│                                          │
│ Manufacturer: [Name]                     │
│ Model: [Model Number]                    │
│ Serial: [Serial Number]                  │
│ Location: [Site Name]                    │
└──────────────────────────────────────────┘
```

**Badges:**
- WARRANTY: Green if active
- CONTRACT: Blue if active

---

## Screen 3: Locations (Map)

**File:** `lib/features/locations/locations_view.dart`  
**Navigation Index:** 3  
**Icon:** `Icons.location_on`  
**Label:** "Locations"

### Purpose

Interactive map showing all sites and starting points with optional PM route planning.

### Visual Layout

```
┌─────────────────────────────────────────────────────────────┐
│  ╔═══════════════════════════════════════════════════════╗ │
│  ║            OpenStreetMap Tiles                        ║ │
│  ║                                                       ║ │
│  ║    📍 Site Markers (color-coded by client)           ║ │
│  ║    🏠 Starting Point Markers (green)                 ║ │
│  ║    ━━━ PM Route Polyline (purple, if active)        ║ │
│  ║                                                       ║ │
│  ╚═══════════════════════════════════════════════════════╝ │
│                                                             │
│  ┌─────────────────────────────────┐  (Overlay Panels)     │
│  │ PM ROUTE PLANNING               │                        │
│  │ [✓] Enable PM Mode              │                        │
│  │ Starting Point: [Select ▼]      │                        │
│  └─────────────────────────────────┘                        │
│                                                             │
│  ┌─────────────────────────────────┐                        │
│  │ LEGEND                          │                        │
│  │ ● Blue    - RBFCU               │                        │
│  │ ● Yellow  - Jefferson           │                        │
│  │ ● Red     - Prosperity          │                        │
│  │ 🏠 Green  - Starting Points     │                        │
│  └─────────────────────────────────┘                        │
└─────────────────────────────────────────────────────────────┘
```

### Map Specifications

**FlutterMap Configuration:**
- Tile source: OpenStreetMap (`https://tile.openstreetmap.org/{z}/{x}/{y}.png`)
- Initial center: `AppConstants.defaultMapLat/Lng` (configurable)
- Initial zoom: `AppConstants.defaultMapZoom`
- Min zoom: `AppConstants.mapMinZoom`
- Max zoom: `AppConstants.mapMaxZoom`

**Layers (in order):**
1. TileLayer (base map)
2. PolylineLayer (PM route, if active)
3. MarkerLayer (starting points, green home icons)
4. MarkerLayer (site markers, color-coded circles)

### Site Markers

**Visual:**
- Circle marker
- Color: Based on client theme color
  - RBFCU: Blue
  - Jefferson: Yellow (amber)
  - Prosperity: Red
- Size: Default marker size
- Label: Branch name (on hover/tap)

**Interaction:**
- Tap marker → Opens `SiteDetailSheet` modal

### Starting Point Markers

**Visual:**
- Home icon (🏠)
- Color: Green (`AppColors.pinStartPoint`)
- Size: Larger than site markers

### PM Route Planning

**When Enabled:**
1. Select starting point from dropdown
2. Algorithm:
   - Find farthest site from starting point
   - Find 5 closest sites to farthest site
   - Draw route: Starting Point → Farthest → 5 Closest
3. Display purple polyline connecting points

**Route Line:**
- Color: `AppColors.purpleAccent` with 0.7 opacity
- Width: 5px

**Control Panel (GlassCard overlay):**
- Toggle: "Enable PM Mode" checkbox
- Dropdown: Starting point selector
- Auto-calculates route on change

### Legend Panel (GlassCard overlay)

Lists all client colors and marker types for reference.

---

## Screen 4: People

**File:** `lib/features/people/people_view.dart`  
**Navigation Index:** 4  
**Icon:** `Icons.people`  
**Label:** "People"

### Purpose

Team directory with search functionality.

### Visual Layout

```
┌─────────────────────────────────────────────────────────────┐
│  People                                                     │
│  Team Directory and Contact Information                    │
├─────────────────────────────────────────────────────────────┤
│  ┌──────────────────────────────────────────────────────┐  │
│  │ 🔍 Search by name, role, or location...             │  │
│  └──────────────────────────────────────────────────────┘  │
├─────────────────────────────────────────────────────────────┤
│  ┌─────┬─────┬─────┬─────┬─────┐  (Grid: 5 columns)       │
│  │ JD  │ SM  │ AR  │ LM  │ TH  │                           │
│  │ John│ Sara│ Alex│ Lisa│ Tom │                           │
│  │ Tech│ Mgr │ Tech│ Tech│ Tech│                           │
│  │ SA  │ SA  │ SA  │ Aust│ SA  │                           │
│  └─────┴─────┴─────┴─────┴─────┘                           │
│  ┌─────┬─────┬─────┬─────┬─────┐                           │
│  │ ... │ ... │ ... │ ... │ ... │                           │
│  └─────┴─────┴─────┴─────┴─────┘                           │
└─────────────────────────────────────────────────────────────┘
```

### Components

**Header:**
- Title: "People"
- Subtitle: "Team Directory and Contact Information"

**Search Bar (GlassCard):**
- Icon: Search
- Placeholder: "Search by name, role, or location..."
- Real-time filtering

**Grid Layout:**
- Columns: 5
- Grid view auto-sizes cards
- Scrollable

**UserCard Component:**

```
┌──────────────┐
│              │
│   ┌────┐     │ ← Avatar circle (initials)
│   │ JD │     │   40px diameter, primary background
│   └────┘     │
│              │
│  John Doe    │ ← Name (14px, bold, white)
│  Field Tech  │ ← Role (12px, grey)
│  San Antonio │ ← Location (12px, grey)
│              │
└──────────────┘
  GlassCard
```

### Search Functionality

**Searches across:**
- Full name
- Role
- Location

**Case-insensitive** partial matching

### Empty State

When no users match search: "No team members found"

---

## Screen 5: Knowledge Base

**File:** `lib/features/knowledge/knowledge_home_view.dart`  
**Navigation Index:** 5  
**Icon:** `Icons.library_books`  
**Label:** "Knowledge"

### Purpose

Search and browse knowledge base entries with multiple organization modes.

### Visual Layout

```
┌─────────────────────────────────────────────────────────────┐
│  Knowledge Base                           (542 entries)     │
├─────────────────────────────────────────────────────────────┤
│  ┌──────────────────────────────────────────────────────┐  │
│  │ 🔍 Search knowledge base...                          │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                             │
│  [By Equipment]  [By Function]  (View Toggle)              │
├─────────────────────────────────────────────────────────────┤
│  BY EQUIPMENT VIEW:                                         │
│  ┌───────────────────────────────────────────────────────┐ │
│  │ 🏧 ATM                                      (45 entries)│ │
│  └───────────────────────────────────────────────────────┘ │
│  ┌───────────────────────────────────────────────────────┐ │
│  │ 💻 Computer                                 (32 entries)│ │
│  └───────────────────────────────────────────────────────┘ │
│  ...                                                        │
│                                                             │
│  BY FUNCTION VIEW:                                          │
│  ┌───────────────────────────────────────────────────────┐ │
│  │ ⚙ Troubleshooting                          (67 entries)│ │
│  └───────────────────────────────────────────────────────┘ │
│  ┌───────────────────────────────────────────────────────┐ │
│  │ 📖 Procedures                               (54 entries)│ │
│  └───────────────────────────────────────────────────────┘ │
│  ...                                                        │
└─────────────────────────────────────────────────────────────┘
```

### Features

**AppBar:**
- Title: "Knowledge Base"
- Entry count badge

**Search:**
- Full-text search across title and content
- Real-time filtering
- Shows matching entries with category

**View Modes:**

1. **By Equipment:**
   - Groups entries by equipment type
   - Shows entry count per type
   - Tap → Navigate to equipment-specific view

2. **By Function:**
   - Groups entries by category (Troubleshooting, Procedures, etc.)
   - Shows entry count per category
   - Tap → Navigate to category view

**Category/Type Card:**

```
┌────────────────────────────────────────┐
│ [Icon] [Name]           ([X] entries)  │
└────────────────────────────────────────┘
```

**Icons:** Dynamic based on type/category

### Navigation Flow

```
Knowledge Home
    ├─ By Equipment
    │   └─ Equipment Type → Equipment View → Entry Detail
    └─ By Function
        └─ Category → Category View → Entry Detail
```

---

## Screen 6: Continuing Education

**File:** `lib/features/continuing_education/continuing_education_home_view.dart`  
**Navigation Index:** 6  
**Icon:** `Icons.school`  
**Label:** "Training"

### Purpose

Browse and search training courses.

### Visual Layout

```
┌─────────────────────────────────────────────────────────────┐
│  Continuing Education                                       │
├─────────────────────────────────────────────────────────────┤
│  ┌──────────────────────────────────────────────────────┐  │
│  │ 🔍 Search courses...                                 │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                             │
│  [All] [Technical] [Safety] [Compliance] [HR]  (Filters)   │
├─────────────────────────────────────────────────────────────┤
│  ┌───────────────────────────────────────────────────────┐ │
│  │ ATM Maintenance Certification            [TECHNICAL]  │ │
│  │ Provider: Hyosung Training Institute                 │ │
│  │ Learn advanced ATM maintenance techniques...          │ │
│  │ [View Details]                                        │ │
│  └───────────────────────────────────────────────────────┘ │
│  ┌───────────────────────────────────────────────────────┐ │
│  │ Workplace Safety Fundamentals              [SAFETY]   │ │
│  │ Provider: OSHA Certified                              │ │
│  │ Essential safety protocols for field technicians...   │ │
│  │ [View Details]                                        │ │
│  └───────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

### Features

**Search:**
- Searches: Title, Description, Provider
- Real-time filtering

**Category Filters:**
- All (default)
- Technical
- Safety
- Compliance
- HR

**Course Card (CourseCard component):**

```
┌───────────────────────────────────────────┐
│ [Course Title]               [CATEGORY]   │
│ Provider: [Provider Name]                 │
│ [Description excerpt...]                  │
│ [View Details]                            │
└───────────────────────────────────────────┘
```

**View Details → CourseDetailView bottom sheet**

### Empty States

- No courses: "No courses available"
- No search results: "No courses match your search"

---

## Screen 7: Equipment

**File:** `lib/features/equipment/equipment_home_view.dart`  
**Navigation Index:** 7  
**Icon:** `Icons.inventory`  
**Label:** "Equipment"

### Purpose

Browse and search equipment inventory.

### Visual Layout

```
┌─────────────────────────────────────────────────────────────┐
│  Equipment Inventory                        (127 items)     │
├─────────────────────────────────────────────────────────────┤
│  ┌──────────────────────────────────────────────────────┐  │
│  │ 🔍 Search by serial, model, manufacturer, type...   │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                             │
│  [All] [ATM] [Computer] [Printer] [Other]  (Type Filters)  │
├─────────────────────────────────────────────────────────────┤
│  ┌───────────────────────────────────────────────────────┐ │
│  │ ATM-9400                    [WARRANTY] [CONTRACT]     │ │
│  │ Hyosung MX8600                                        │ │
│  │ Serial: SN123456789                                   │ │
│  │ Location: RBFCU Main Branch                           │ │
│  │ [View Details]                                        │ │
│  └───────────────────────────────────────────────────────┘ │
│  ┌───────────────────────────────────────────────────────┐ │
│  │ COMP-001                                              │ │
│  │ Dell OptiPlex 7090                                    │ │
│  │ Serial: DELL12345                                     │ │
│  │ Location: Jefferson Downtown                          │ │
│  │ [View Details]                                        │ │
│  └───────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

### Features

**AppBar:**
- Title: "Equipment Inventory"
- Total count

**Search:**
- Searches: Serial Number, Model, Manufacturer, Type
- Real-time filtering

**Type Filters:**
- Dynamic chips based on equipment types in database
- "All" shows everything
- Tap type to filter

**Equipment Card (EquipmentCard component):**

```
┌──────────────────────────────────────────┐
│ [Type-ID]         [WARRANTY] [CONTRACT]  │
│ [Manufacturer] [Model]                   │
│ Serial: [Serial Number]                  │
│ Location: [Site Name]                    │
│ [View Details]                           │
└──────────────────────────────────────────┘
```

**Badges:**
- WARRANTY: Green if under warranty
- CONTRACT: Blue if under service contract

**View Details → EquipmentDetailSheet bottom sheet**

---

## Screen 8: Expenses

**File:** `lib/features/expenses/expenses_home_view.dart`  
**Navigation Index:** 8  
**Icon:** `Icons.receipt_long`  
**Label:** "Expenses"

### Purpose

Placeholder for future expense tracking functionality.

### Visual Layout

```
┌─────────────────────────────────────────────────────────────┐
│  Expense Tracking                                           │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│                      [📊]                                   │
│                                                             │
│            COMING SOON                                      │
│                                                             │
│  Expense tracking features will include:                   │
│                                                             │
│  • Expense entry with categories                           │
│  • Receipt photo upload                                    │
│  • Expense report generation                               │
│  • Approval workflow                                       │
│  • Integration with work orders                            │
│                                                             │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Current State

**Placeholder screen** with:
- Icon (chart/receipt icon)
- "COMING SOON" message
- List of planned features
- Centered layout

**Note:** Receipt scanning is currently available via Home screen tactical shortcuts, but full expense management is not yet implemented.

---

## Screen 9: Settings

**File:** `lib/features/settings/settings_view.dart`  
**Navigation Index:** 9  
**Icon:** `Icons.settings_applications`  
**Label:** "Settings"

### Purpose

System configuration and settings management.

### Visual Layout

```
┌─────────────────────────────────────────────────────────────┐
│  System Configuration                         v2.0.26       │
├─────────────────────────────────────────────────────────────┤
│  [General] [Knowledge] [Security]  (Tab Selector)           │
├─────────────────────────────────────────────────────────────┤
│  GENERAL TAB:                                               │
│  ┌───────────────────────────────────────────────────────┐ │
│  │ Offline-First Mode                          [ON]      │ │
│  └───────────────────────────────────────────────────────┘ │
│  ┌───────────────────────────────────────────────────────┐ │
│  │ Biometric Authentication                    [OFF]     │ │
│  └───────────────────────────────────────────────────────┘ │
│  ┌───────────────────────────────────────────────────────┐ │
│  │ High-Density UI                             [OFF]     │ │
│  └───────────────────────────────────────────────────────┘ │
│  ┌───────────────────────────────────────────────────────┐ │
│  │ Dynamic Color                               [OFF]     │ │
│  └───────────────────────────────────────────────────────┘ │
│                                                             │
│  System Health:                                             │
│  • CPU: Normal                                              │
│  • Storage: 45% used                                        │
│  • Database: Healthy                                        │
│  • Latency: <10ms                                           │
│                                                             │
│  KNOWLEDGE TAB:                                             │
│  Knowledge Entries: 542                                     │
│  Repository: C:\Users\...\knowledge\                        │
│  [Rebuild Knowledge Index]                                  │
│  [Ingest from File System]                                  │
│                                                             │
│  SECURITY TAB:                                              │
│  Security Status: ✓ Secure                                  │
│  (Additional security settings)                             │
└─────────────────────────────────────────────────────────────┘
```

### Tabs

**1. General:**
- Toggle cards for preferences
- System health metrics
- Version info

**2. Knowledge:**
- Entry count
- Repository path
- Index rebuild button
- File system ingestion

**3. Security:**
- Security status
- Security-related settings

### Toggle Card Structure

```
┌────────────────────────────────────┐
│ [Setting Name]          [Toggle]   │
│ [Description if any]               │
└────────────────────────────────────┘
```

**Toggles:** Material Switch component

---

## Summary Table

| Index | Screen | File | Primary Purpose | Key Feature |
|-------|--------|------|-----------------|-------------|
| 0 | Home | `home_view.dart` | Dashboard | KPIs, Weather, News |
| 1 | Work | `work_view.dart` | Work Orders | Filtering, Pagination |
| 2 | Operations | `operations_view.dart` | Clients/Sites/Equipment | Hierarchical Navigation |
| 3 | Locations | `locations_view.dart` | Map | PM Route Planning |
| 4 | People | `people_view.dart` | Team Directory | Search |
| 5 | Knowledge | `knowledge_home_view.dart` | Knowledge Base | Multi-view Grouping |
| 6 | Training | `continuing_education_home_view.dart` | Courses | Category Filtering |
| 7 | Equipment | `equipment_home_view.dart` | Inventory | Type Filtering |
| 8 | Expenses | `expenses_home_view.dart` | Placeholder | Future Feature |
| 9 | Settings | `settings_view.dart` | Configuration | System Settings |

---

**End of Screen Catalog**
