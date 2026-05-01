# FSC Portal Offline - Component Library

**Version:** 2.0.26  
**Last Updated:** January 31, 2026  
**Purpose:** Complete catalog of all reusable UI components with specifications and usage guidelines

---

## Table of Contents

1. [Core Components](#core-components)
2. [Card Components](#card-components)
3. [Modal Components](#modal-components)
4. [Specialized Widgets](#specialized-widgets)
5. [Usage Guidelines](#usage-guidelines)

---

## Core Components

### 1. GlassCard

**File:** `lib/widgets/glass_card.dart`  
**Purpose:** Premium glassmorphism card with backdrop blur effect

**Description:**
The GlassCard is the foundational UI component implementing the 2026 "Mica" glassmorphism design pattern. It provides a translucent, blurred background effect with subtle gradients and shine borders.

#### Visual Specification

```
┌─────────────────────────────────────────────────────────┐
│  ┌───────────────────────────────────────────────────┐  │ ← 1px border
│  │                                                   │  │   (white 0.1 opacity
│  │                GlassCard Content                  │  │    or custom color)
│  │                                                   │  │
│  │  ╔══════════════════════════════════════════╗     │  │
│  │  ║  Backdrop Blur Filter (sigma: 10.0)     ║     │  │
│  │  ║  + Translucent gradient background      ║     │  │
│  │  ║  + Subtle shadow effect                 ║     │  │
│  │  ╚══════════════════════════════════════════╝     │  │
│  │                                                   │  │
│  │  [Child Widget Content Here]                      │  │
│  │                                                   │  │
│  └───────────────────────────────────────────────────┘  │
│                    ↓ Shadow (8px Y offset)              │
└─────────────────────────────────────────────────────────┘
```

#### Technical Specifications

**Properties:**
```dart
final Widget child;                    // Required: Content to display
final EdgeInsetsGeometry? padding;     // Optional: Internal padding (default: 16px all)
final EdgeInsetsGeometry? margin;      // Optional: External margin
final VoidCallback? onTap;             // Optional: Tap handler
final double borderRadius;             // Border radius (default: 12px)
final bool hasShine;                   // Shine effect (default: true)
final Color? activeBorderColor;        // Custom border color for active state
```

**Visual Effects:**
- **Blur Sigma:** 10.0 (X and Y)
- **Gradient:** `AppGradients.glassSurface`
  - Start: White with 0.05 opacity
  - End: White with 0.02 opacity
  - Direction: Top-left to bottom-right
- **Border:**
  - Width: 1px
  - Color: White with 0.1 opacity (default) or `activeBorderColor`
- **Shadow:**
  - Color: Black with 0.3 opacity
  - Blur radius: 20px
  - Spread radius: -5px
  - Offset: (0, 8px)
- **Touch Feedback:**
  - Splash color: Primary with 0.1 opacity
  - Highlight color: White with 0.05 opacity

**Layering Structure (lines 41-83):**
```
Container (margin)
  └─ ClipRRect (border radius)
      └─ BackdropFilter (blur effect)
          └─ Container (gradient + border + shadow)
              └─ Material (transparent)
                  └─ InkWell (touch feedback)
                      └─ Padding
                          └─ Child Widget
```

#### Usage Examples

**Basic Usage:**
```dart
GlassCard(
  child: Text('Card Content'),
)
```

**With Tap Handler:**
```dart
GlassCard(
  onTap: () => print('Card tapped'),
  child: Column(
    children: [
      Icon(Icons.star),
      Text('Interactive Card'),
    ],
  ),
)
```

**With Active Border:**
```dart
GlassCard(
  activeBorderColor: AppColors.primary,
  borderRadius: 16,
  padding: EdgeInsets.all(24),
  child: Text('Active State Card'),
)
```

**Common Use Cases:**
- Dashboard KPI tiles
- Morning briefing cards
- Tactical shortcut buttons
- Status panels
- Search bars
- Control panels
- Info cards

---

### 2. NewsCard

**File:** `lib/widgets/news_card.dart`  
**Purpose:** Announcement and news display with category-based theming

**Description:**
NewsCard is a specialized card component for displaying company announcements and news items with left-border accent colors based on category.

#### Visual Specification

```
┌──┬─────────────────────────────────────────────────────┐
│  │                                                     │
│  │  ┌────┐                                             │
│  │  │ 🔷 │  Announcement Title                         │
│  │  └────┘                                             │
│C │                                                     │
│A │  This is the body text of the announcement.        │
│T │  It provides details and information in grey       │
│E │  text color for readability.                       │
│G │                                                     │
│O │                              ┌──────────────────┐   │
│R │                              │  ACTION BUTTON   │   │
│Y │                              └──────────────────┘   │
│  │                                                     │
│B │                                                     │
│A │                                                     │
│R │                                                     │
│  │                                                     │
└──┴─────────────────────────────────────────────────────┘
 ↑
 4px left border (category-colored)
```

#### Technical Specifications

**Properties:**
```dart
final String title;                    // Required: Card title/headline
final String body;                     // Required: Card body text
final IconData icon;                   // Required: Category icon
final Color accentColor;               // Accent color (default: Portal Blue #0056D2)
final String? actionLabel;             // Optional: Action button text
final VoidCallback? onAction;          // Optional: Action button handler
```

**Styling:**
- **Background:** Dark grey (#1E1E1E)
- **Border Radius:** 8px
- **Left Border:**
  - Width: 4px
  - Color: `accentColor`
- **Shadow:**
  - Color: Black with 0.2 opacity
  - Blur radius: 4px
  - Offset: (0, 2px)
- **Margin:** 16px bottom
- **Padding:** 16px all sides

**Layout Structure (lines 36-90):**
```
Container (margin + decoration + shadow)
  └─ Padding (16px)
      └─ Column
          ├─ Row (Icon + Title)
          │   ├─ Icon (20px, accent color)
          │   ├─ SizedBox (12px gap)
          │   └─ Text (title, white, 16px, bold)
          ├─ SizedBox (8px gap)
          ├─ Text (body, grey #B0B0B0, 14px)
          └─ Optional Action Button
              └─ Align (right)
                  └─ InkWell
                      └─ Container (accent bg + border)
                          └─ Text (action label)
```

#### Category Theming

NewsCard uses different colors and icons based on announcement category:

| Category | Icon | Color | Use Case |
|----------|------|-------|----------|
| **HR** | `Icons.security` | Blue (#0056D2) | HR announcements, policies |
| **Safety** | `Icons.warning` | Red (#CF6679) | Safety alerts, warnings |
| **Fleet** | `Icons.local_shipping` | Orange (#FFC107) | Fleet updates, logistics |
| **General** | `Icons.info` | Primary (#0056D2) | General announcements |

**Implementation Example:**
```dart
// Safety Announcement (Home View)
NewsCard(
  title: 'SAFETY: Wear PPE',
  body: 'All technicians must wear appropriate PPE on site.',
  icon: Icons.warning,
  accentColor: Colors.red,
  actionLabel: 'ACKNOWLEDGE',
  onAction: () {
    // Handle acknowledgment
  },
)
```

#### Action Button Specifications

**When Present:**
- Padding: 16px horizontal, 8px vertical
- Background: Accent color with 0.15 opacity
- Border: 1px accent color with 0.5 opacity
- Border radius: 4px
- Text: Accent color, 600 weight, 12px
- Alignment: Right-aligned

**Common Action Labels:**
- "ACKNOWLEDGE" - Safety announcements
- "VIEW DETAILS" - General information
- "COMPLETE" - Tasks
- "DISMISS" - Optional items

#### Usage Examples

**Basic Announcement:**
```dart
NewsCard(
  title: 'Team Meeting',
  body: 'Monthly all-hands meeting scheduled for Friday at 2 PM.',
  icon: Icons.info,
)
```

**Safety Alert with Action:**
```dart
NewsCard(
  title: 'SAFETY: New Protocol',
  body: 'Updated safety protocols effective immediately. Please review and acknowledge.',
  icon: Icons.warning,
  accentColor: AppColors.error,
  actionLabel: 'ACKNOWLEDGE',
  onAction: () async {
    await db.acknowledgeAnnouncement(announcementId);
  },
)
```

**Fleet Update:**
```dart
NewsCard(
  title: 'Fleet: Vehicle Maintenance',
  body: 'All vehicles must be serviced before month end.',
  icon: Icons.local_shipping,
  accentColor: Colors.orange,
)
```

---

## Modal Components

### 3. ScanReceiptSheet

**File:** `lib/features/home/scan_receipt_sheet.dart`  
**Purpose:** Modal bottom sheet for scanning and saving receipts with expense metadata

#### Visual Layout

```
┌─────────────────────────────────────────────────────────┐
│                      ═ (Handle)                         │ ← Draggable handle
├─────────────────────────────────────────────────────────┤
│  📷  Scan Receipt                            [X]        │ ← Header (20px padding)
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Receipt Photo *                                        │
│  ┌─────────────────┐  ┌──────────────────────────┐     │
│  │ [📷] Take Photo │  │ [🖼] Choose from Gallery │     │
│  └─────────────────┘  └──────────────────────────┘     │
│                                                         │
│  [Preview Image if selected - 200px height]            │
│  [🗑 Remove Photo button if image selected]            │
│                                                         │
│  Amount                                                 │
│  ┌─────────────────────────────────────────────────┐   │
│  │ $ 0.00                                          │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  Category                                               │
│  ┌─────────────────────────────────────────────────┐   │
│  │ Select category ▼                               │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  Receipt Date                                           │
│  ┌─────────────────────────────────────────────────┐   │
│  │ 2026-01-31                             📅       │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  Vendor/Merchant                                        │
│  ┌─────────────────────────────────────────────────┐   │
│  │ Store name                                      │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  Site (Optional)                                        │
│  ┌─────────────────────────────────────────────────┐   │
│  │ None ▼                                          │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  Work Order (Optional) [if site selected]               │
│  ┌─────────────────────────────────────────────────┐   │
│  │ None ▼                                          │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  Notes                                                  │
│  ┌─────────────────────────────────────────────────┐   │
│  │ Additional notes...                             │   │
│  │                                                 │   │
│  │                                                 │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  ┌─────────────────────────────────────────────────┐   │
│  │          SAVE RECEIPT                           │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  (Scrollable content)                                   │
└─────────────────────────────────────────────────────────┘
```

#### Technical Specifications

**Modal Properties:**
- **Type:** `DraggableScrollableSheet`
- **Initial Size:** 80% of screen height
- **Min Size:** 50%
- **Max Size:** 95%
- **Background:** `AppColors.surface` (#1E1E1E)
- **Top Border Radius:** 20px
- **Expand:** false

**Handle Bar:**
- Width: 40px
- Height: 4px
- Color: Grey[600]
- Border radius: 2px
- Top margin: 12px

**Form Fields:**

1. **Receipt Photo** (Required)
   - Two action buttons: "Take Photo" / "Choose from Gallery"
   - Image preview: 200px height, 8px border radius
   - Remove button appears when image selected
   - Uses `ImagePicker` package

2. **Amount** (Optional)
   - Type: Number with decimal
   - Prefix: "$ "
   - Hint: "0.00"
   - Keyboard: Numeric with decimals

3. **Category** (Optional)
   - Type: Dropdown
   - Options: Fuel, Meals, Supplies, Tools, Parts, Other
   - Default: None selected

4. **Receipt Date** (Optional)
   - Type: Date picker
   - Default: Current date
   - Format: YYYY-MM-DD
   - Icon: Calendar (right-aligned)

5. **Vendor/Merchant** (Optional)
   - Type: Text input
   - Hint: "Store name"

6. **Site** (Optional)
   - Type: Dropdown
   - Options: All sites from database + "None"
   - Conditional: Shows Work Order field if site selected

7. **Work Order** (Optional, conditional)
   - Type: Dropdown
   - Options: Open work orders for selected site + "None"
   - Only visible when site is selected
   - Filtered by `wo.siteId == _selectedSiteId`

8. **Notes** (Optional)
   - Type: Multi-line text (3 lines)
   - Hint: "Additional notes..."

**Save Button:**
- Width: Full width
- Padding: 16px vertical
- Background: `AppColors.primary`
- Text: "Save Receipt" (white, 16px, bold)
- Border radius: 8px

#### Data Flow

```
User Selects/Takes Photo
        ↓
Fills Form Fields (optional)
        ↓
Clicks "Save Receipt"
        ↓
Validation Check (image required)
        ↓
┌──────────────────────────────────────┐
│  Image Processing:                   │
│  1. Create receipts directory        │
│  2. Generate unique filename         │
│  3. Copy image to app directory      │
│  4. Get file path                    │
└──────────────┬───────────────────────┘
               ↓
┌──────────────────────────────────────┐
│  Database Insert:                    │
│  1. Insert to Documents table        │
│     - workOrderId (optional)         │
│     - siteId (optional)              │
│     - fileName, filePath             │
│     - uploadedAt, uploadedBy         │
└──────────────┬───────────────────────┘
               ↓
┌──────────────────────────────────────┐
│  Create Note (if metadata provided): │
│  1. Build note text from fields      │
│  2. Insert to Notes table            │
│     - siteId (required for note)     │
│     - workOrderId (optional)         │
│     - noteType: 'general'            │
│     - noteText (formatted)           │
└──────────────┬───────────────────────┘
               ↓
Success: Close sheet, show snackbar
Error: Show error snackbar
```

#### File Storage

**Location:** `%AppData%/portal_offline/receipts/`  
**Filename Format:** `receipt_[timestamp][extension]`  
**Example:** `receipt_1738368000000.jpg`

#### Usage Example

```dart
// From Home View tactical shortcuts
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  builder: (context) => const ScanReceiptSheet(),
);
```

---

### 4. NewNoteSheet

**File:** `lib/features/home/new_note_sheet.dart`  
**Purpose:** Modal bottom sheet for creating site notes and observations

#### Visual Layout

```
┌─────────────────────────────────────────────────────────┐
│                      ═ (Handle)                         │
├─────────────────────────────────────────────────────────┤
│  📝  New Note                                [X]        │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Note Type                                              │
│  ┌─────────┬─────────┬──────────┐                       │
│  │ General │  POI   │ Warning  │ (Segmented Button)    │
│  └─────────┴─────────┴──────────┘                       │
│                                                         │
│  Site *                                                 │
│  ┌─────────────────────────────────────────────────┐   │
│  │ [Select site] ▼                                 │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  Work Order (Optional)                                  │
│  ┌─────────────────────────────────────────────────┐   │
│  │ None ▼                                          │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  Note Text *                                            │
│  ┌─────────────────────────────────────────────────┐   │
│  │ Enter your note...                              │   │
│  │                                                 │   │
│  │                                                 │   │
│  │                                                 │   │
│  │                                                 │   │
│  │                                                 │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  ┌─────────────────────────────────────────────────┐   │
│  │          SAVE NOTE                              │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

#### Technical Specifications

**Modal Properties:**
- **Type:** `DraggableScrollableSheet`
- **Initial Size:** 70% of screen height
- **Min Size:** 50%
- **Max Size:** 95%
- **Background:** `AppColors.surface`
- **Top Border Radius:** 20px

**Form Fields:**

1. **Note Type** (Required)
   - Type: Segmented Button
   - Options: General, POI, Warning
   - Default: 'general'
   - Single selection
   - Material 3 component

2. **Site** (Required)
   - Type: Dropdown
   - Options: All sites from database
   - Default: First site (auto-selected)
   - Validation: Must be selected

3. **Work Order** (Optional)
   - Type: Dropdown
   - Options: All open work orders + "None"
   - Filtered by selected site (if site changes, work order clears)

4. **Note Text** (Required)
   - Type: Multi-line text (6 lines)
   - Hint: "Enter your note..."
   - Validation: Cannot be empty
   - Max lines: 6

**Save Button:**
- Width: Full width
- Padding: 16px vertical
- Background: `AppColors.primary`
- Text: "Save Note" (white, 16px, bold)

#### Note Type Descriptions

| Type | Purpose | Example Use Cases |
|------|---------|-------------------|
| **General** | Standard observations and notes | Work progress, general observations |
| **POI** | Points of Interest | Important landmarks, access points |
| **Warning** | Hazards and warnings | Safety concerns, equipment issues |

#### Data Flow

```
User Selects Note Type
        ↓
Selects Site (Required)
        ↓
Optionally Selects Work Order
        ↓
Enters Note Text
        ↓
Clicks "Save Note"
        ↓
Form Validation
        ↓
┌──────────────────────────────────────┐
│  Database Insert:                    │
│  - siteId (required)                 │
│  - workOrderId (optional)            │
│  - noteType (general/poi/warning)    │
│  - noteText (trimmed)                │
│  - createdAt (DateTime.now())        │
│  - createdBy (current user)          │
└──────────────┬───────────────────────┘
               ↓
Success: Close sheet, show snackbar
Error: Show error snackbar
```

#### Usage Example

```dart
// From Home View tactical shortcuts
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  builder: (context) => const NewNoteSheet(),
);
```

---

### 5. CreateAnnouncementSheet

**File:** `lib/features/home/create_announcement_sheet.dart`  
**Purpose:** Create new company announcements

#### Structure

Similar to NewNoteSheet with these fields:
- Category selector (General, HR, Safety, Fleet)
- Title/Headline field
- Body/Message field (multi-line)
- Optional action label
- Save button

**Categories:**
- **General:** Info icon, primary blue
- **HR:** Security icon, blue
- **Safety:** Warning icon, red
- **Fleet:** Shipping icon, orange

---

### 6. EditWeatherSheet

**File:** `lib/features/home/edit_weather_sheet.dart`  
**Purpose:** Update weather information manually or via API

#### Structure

Two sections:
1. **API Fetch:**
   - Zip code input
   - Fetch button (calls wttr.in API)

2. **Manual Entry:**
   - Region/Location text field
   - Temperature number field
   - Condition dropdown (Clear, Cloudy, Rainy, etc.)
   - Save button

---

## Specialized Widgets

### 7. NewsFeedWidget

**File:** `lib/widgets/news_feed.dart`  
**Purpose:** Horizontal scrollable industry news feed with featured card

#### Visual Layout

```
┌────────────────────────────────────────────────────────────────┐
│  Industry Briefing  (5) • Last updated: 2 min ago     [RSS]    │
├────────────────────────────────────────────────────────────────┤
│                                                                │
│  ┌──────────┐  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐        │
│  │          │  │      │  │      │  │      │  │      │  ...   │
│  │ Featured │  │ News │  │ News │  │ News │  │ News │        │
│  │  Card    │  │ Card │  │ Card │  │ Card │  │ Card │        │
│  │ 300px    │  │ 160px│  │ 160px│  │ 160px│  │ 160px│        │
│  │          │  │      │  │      │  │      │  │      │        │
│  └──────────┘  └──────┘  └──────┘  └──────┘  └──────┘        │
│                                                                │
│  ◄───────────── Horizontal Scroll ───────────────►            │
└────────────────────────────────────────────────────────────────┘
     220px height
```

#### Specifications

**Container:**
- Height: 220px
- Scroll: Horizontal `ListView`
- Data: `StreamBuilder<List<IndustryBriefingData>>`
- Limit: Latest 5 briefings

**Header:**
- Title: "Industry Briefing"
- Count: `(${briefings.length})`
- Last update: Time ago format
- RSS icon: Right-aligned

**Card Types:**

1. **Featured Card** (First item):
   - Width: 300px
   - Full-height image background
   - Gradient overlay (top to bottom, black 0.3 to 0.7 opacity)
   - Source badge (circular icon + name)
   - Headline (3-4 lines max, ellipsis)
   - Time ago indicator

2. **Regular Cards** (Remaining items):
   - Width: 160px
   - Compact layout
   - Background image or placeholder
   - Source info
   - Headline (2-3 lines max)

**Empty State:**
- Centered icon + text
- Message: "No industry news available"

---

### 8. UserCard

**File:** `lib/features/people/user_card.dart`  
**Purpose:** Display team member information in grid layout

#### Structure

```
┌──────────────────────┐
│                      │
│      ┌────────┐      │
│      │   JD   │      │ ← Avatar with initials
│      └────────┘      │
│                      │
│   John Doe           │ ← Full name (bold)
│   Field Technician   │ ← Role (grey)
│   San Antonio        │ ← Location (grey)
│                      │
└──────────────────────┘
   GlassCard container
```

---

### 9. Equipment/Course Cards

**Purpose:** Display items in list/grid format

**Common Pattern:**
- GlassCard container
- Icon or image
- Title/Name
- Subtitle/Description
- Badge indicators (warranty, status, etc.)
- Tap to view details (opens bottom sheet)

---

## Usage Guidelines

### When to Use GlassCard

**✅ Use GlassCard for:**
- Dashboard KPI tiles
- Info panels
- Control panels
- Interactive buttons/tiles
- Search bars
- Status displays
- Any card that needs glassmorphism effect

**❌ Don't use GlassCard for:**
- Simple text containers (use Container)
- List items (use ListTile or custom)
- Full-screen backgrounds
- Overlay dialogs (use Dialog)

### When to Use NewsCard

**✅ Use NewsCard for:**
- Company announcements
- Category-based messaging
- Actionable notifications
- Feed items with actions

**❌ Don't use NewsCard for:**
- Industry news (use NewsFeedWidget)
- Simple notifications (use SnackBar)
- Full articles (use dedicated view)

### Modal Bottom Sheet Best Practices

**DraggableScrollableSheet Configuration:**
```dart
DraggableScrollableSheet(
  initialChildSize: 0.7,    // 70% of screen
  minChildSize: 0.5,        // Can shrink to 50%
  maxChildSize: 0.95,       // Can expand to 95%
  expand: false,            // Don't force full screen
  builder: (context, scrollController) {
    // Pass scrollController to ListView
    return ListView(
      controller: scrollController,
      children: [...]
    );
  },
)
```

**Always Include:**
1. Handle bar (40px wide, 4px tall, grey, 12px top margin)
2. Header with title + close button
3. Divider after header
4. Scrollable content area
5. Primary action button at bottom

**Color Scheme:**
- Background: `AppColors.surface`
- Border radius: 20px (top only)
- Text fields: `AppColors.background` fill
- Buttons: `AppColors.primary` background

### Form Field Standards

**All Input Fields:**
- Fill color: `AppColors.background`
- Border: `AppColors.border` (enabled), `AppColors.primary` (focused)
- Border radius: 8px
- Label: 12px, `AppColors.textSecondary`
- Input text: 14px, `AppColors.textPrimary`
- Padding: 16px horizontal, 12px vertical

**Dropdowns:**
- Dropdown color: `AppColors.surface`
- Consistent styling with text fields
- Include "None" option for optional fields

**Multi-line Text:**
- Min lines: 3-6 depending on use case
- Max lines: Null (unlimited) or specific limit
- Same styling as single-line fields

---

## Component Checklist

Before creating a new component, check if you can use:

- [ ] GlassCard for card layouts
- [ ] NewsCard for announcements
- [ ] DraggableScrollableSheet for modals
- [ ] Standard form field styling
- [ ] StreamBuilder for real-time data
- [ ] Provider for database access
- [ ] AppColors/AppTypography constants

**Consistency is key:** Reuse existing components and patterns for a cohesive user experience.

---

**End of Component Library**
