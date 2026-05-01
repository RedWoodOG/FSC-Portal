# FSC Portal - Complete UI Specification

## 📋 Overview
This document provides a comprehensive breakdown of all visual elements, colors, layout, typography, and components visible in the FSC Portal application.

---

## 🎨 COLOR PALETTE

### Background Colors
- **Deep Black** (`#121212` / `0xFF121212`)
  - Main application background
  - Used throughout the entire interface

- **Dark Grey** (`#1E1E1E` / `0xFF1E1E1E`)
  - Card backgrounds
  - Surface elements
  - Selected navigation items
  - All interactive cards

### Primary Brand Colors
- **Portal Blue** (`#0056D2` / `0xFF0056D2`)
  - Primary brand color
  - Active navigation items
  - Primary buttons ("New Call", "Time Entry")
  - Action buttons ("Review", "Watch", "Submit")
  - Main icons and accents
  - User avatar background

- **Portal Blue Light** (`#1E6FE8` / `0xFF1E6FE8`)
  - Lighter variant for hover states

### Status Colors
- **Success Green** (`#03DAC6` / `0xFF03DAC6`)
  - Completed states
  - Checkmark icons
  - "Completed Today" card icon
  - "completed" tags
  - Activity entry icons

- **Warning Amber** (`#FFC107` / `0xFFFFC107`)
  - Low priority tags
  - Warning states

- **Alert Red** (`#CF6679` / `0xFFCF6679`)
  - Notification badges (bell icon with "2")
  - Error states

- **Quiet Day Green** (`#4CAF50` / `0xFF4CAF50`)
  - "Quiet Day" tag background

### Accent Colors
- **Purple Accent** (`#9C27B0` / `0xFF9C27B0`)
  - Graph icons
  - "This Week" card icon

### Text Colors
- **Text White** (`#FFFFFF` / `0xFFFFFFFF`)
  - Primary text
  - Titles and headings
  - Large numbers in cards
  - Active navigation text
  - Button text

- **Text Grey** (`#B0B0B0` / `0xFFB0B0B0`)
  - Secondary text
  - Subtitles
  - Inactive navigation items
  - Card subtitles
  - Timestamps

- **Text Grey Dark** (`#808080` / `0xFF808080`)
  - Tertiary text (less prominent)

### Border Colors
- **Border Grey** (`#2A2A2F` / `0xFF2A2A2F`)
  - Subtle borders and dividers

---

## 📐 LAYOUT STRUCTURE

### Screen Layout
```
┌─────────────────────────────────────────────────────────────┐
│ Header Bar (64px height)                                    │
├──────────┬──────────────────────────────┬───────────────────┤
│          │                              │                   │
│ Left     │ Main Content Area            │ Right Sidebar     │
│ Sidebar  │ (Scrollable)                 │ (280px width)    │
│ (240px)  │                              │                   │
│          │                              │                   │
│          │                              │                   │
│          │                              │                   │
└──────────┴──────────────────────────────┴───────────────────┘
```

### Component Dimensions

#### Header Bar
- **Height**: 64px
- **Background**: Deep Black (`#121212`)
- **Border**: Bottom border (1px, Border Grey)

#### Left Navigation Sidebar
- **Width**: 240px
- **Background**: Deep Black (`#121212`)
- **Logo Size**: 48px × 48px
- **Navigation Item Height**: 48px
- **Padding**: 16px horizontal

#### Main Content Area
- **Width**: Flexible (fills remaining space)
- **Background**: Deep Black (`#121212`)
- **Padding**: 32px all sides
- **Scrollable**: Yes (vertical)

#### Right Sidebar
- **Width**: 280px
- **Background**: Deep Black (`#121212`)
- **Padding**: 32px all sides

---

## 🎯 COMPONENT SPECIFICATIONS

### Header Bar Components

#### App Name
- **Text**: "client"
- **Font Size**: 16px
- **Font Weight**: Medium (500)
- **Color**: White

#### Primary Buttons
**"New Call" Button:**
- **Background**: Portal Blue (`#0056D2`)
- **Text Color**: White
- **Icon**: Phone receiver
- **Padding**: 16px horizontal, 12px vertical
- **Border Radius**: 8px
- **Height**: ~40px

**"Time Entry" Button:**
- **Background**: Portal Blue (`#0056D2`)
- **Text Color**: White
- **Icon**: Clock
- **Padding**: 16px horizontal, 12px vertical
- **Border Radius**: 8px
- **Height**: ~40px

#### Notification Icon
- **Icon**: Bell
- **Badge**: Red circle with "2"
- **Badge Color**: Alert Red (`#CF6679`)
- **Badge Size**: ~16px diameter

#### User Icon
- **Icon**: User silhouette
- **Size**: ~32px

---

### Left Navigation Sidebar

#### Logo Section
- **Logo**: Blue shield with stylized letter
- **Size**: 48px × 48px
- **Position**: Centered at top
- **Padding**: 32px top, 16px bottom

#### App Title
- **Text**: "Portal"
- **Font Size**: 18px
- **Font Weight**: Bold
- **Color**: White
- **Position**: Below logo

#### Navigation Items

**Active Item (Home):**
- **Background**: Portal Blue (`#0056D2`)
- **Icon Color**: White
- **Text Color**: White
- **Font Weight**: Semi-bold (600)
- **Padding**: 16px horizontal, 8px vertical
- **Border Radius**: 8px
- **Height**: 48px

**Inactive Items:**
- **Background**: Transparent
- **Icon Color**: Text Grey (`#B0B0B0`)
- **Text Color**: Text Grey (`#B0B0B0`)
- **Font Weight**: Normal (400)
- **Padding**: 16px horizontal, 8px vertical
- **Height**: 48px

**Navigation Items List:**
1. Home (Active)
2. Work
3. Field Readiness
4. Operations
5. Locations
6. People
7. FLO
8. Me

#### Bottom Section

**Admin Item:**
- **Icon**: Shield (grey)
- **Text**: "Admin"
- **Color**: Text Grey (`#B0B0B0`)

**Dark Mode Toggle:**
- **Label**: "Dark Mode"
- **Icon**: Moon (outlined, white)
- **Toggle**: On (dark mode active)
- **Text Color**: Text Grey (`#B0B0B0`)

**User Profile:**
- **Avatar**: Blue circle with white "A"
- **Avatar Size**: ~40px
- **Name**: "Admin" (White, Semi-bold)
- **Role**: "Administrator" (Text Grey)

---

### Main Content Area

#### Section: "Home"
- **Title**: "Home"
  - Font Size: 20px
  - Font Weight: Bold
  - Color: White

- **Tag**: "Quiet Day"
  - Background: Quiet Day Green (`#4CAF50`)
  - Text: White
  - Font Size: 12px
  - Font Weight: Medium
  - Border Radius: 4px
  - Padding: 4px horizontal, 2px vertical

- **Subtitle**: "Staying ready and informed"
  - Font Size: 14px
  - Font Weight: Normal
  - Color: Text Grey (`#B0B0B0`)

#### Summary Cards (Top Row - 3 Cards)

**Card Structure:**
- **Background**: Dark Grey (`#1E1E1E`)
- **Border Radius**: 12px
- **Padding**: 16px all sides
- **Elevation**: 2px shadow
- **Spacing**: 16px between cards

**1. "Open Calls" Card:**
- **Icon**: Blue briefcase (32px)
- **Number**: "2" (32px, Bold, White)
- **Label**: "Open Calls" (14px, Text Grey)
- **Graph Icon**: Small blue upward trend (16px, top right)

**2. "Completed Today" Card:**
- **Icon**: Green checkmark (32px)
- **Number**: "2" (32px, Bold, White)
- **Label**: "Completed Today" (14px, Text Grey)
- **Graph Icon**: Small green upward trend (16px, top right)

**3. "This Week" Card:**
- **Icon**: Purple upward graph (32px)
- **Number**: "12" (32px, Bold, White)
- **Label**: "This Week" (14px, Text Grey)
- **Graph Icon**: Small purple upward trend (16px, top right)

#### Section: "Operational Environment"
- **Title**: "Operational Environment" (20px, Bold, White)
- **Subtitle**: "Regional coverage and preparation" (14px, Text Grey)
- **Spacing**: 16px below subtitle

**Information Cards:**

**1. Weather/Coverage Card:**
- **Background**: Dark Grey (`#1E1E1E`)
- **Border Radius**: 12px
- **Padding**: 16px
- **Icon**: Green location pin (24px)
- **Text**: "Covering North Region today. Weather: Clear, 72°F. All routes accessible."
- **Text Color**: Text Grey (`#B0B0B0`)
- **Text Size**: 14px

**2. Inventory Status Card:**
- **Background**: Dark Grey (`#1E1E1E`)
- **Border Radius**: 12px
- **Padding**: 16px
- **Icon**: Blue info icon (24px)
- **Text**: "Inventory status available in Operations"
- **Text Color**: Text Grey (`#B0B0B0`)
- **Text Size**: 14px

#### Section: "Recommended Next Actions"
- **Title**: "Recommended Next Actions" (20px, Bold, White)
- **Subtitle**: "Optimization opportunities" (14px, Text Grey)
- **Spacing**: 16px below subtitle

**Action Cards:**

**Card Structure:**
- **Background**: Dark Grey (`#1E1E1E`)
- **Border Radius**: 12px
- **Padding**: 16px
- **Layout**: Horizontal (Icon + Text + Button)

**1. "Schedule Preventative Maintenance" Card:**
- **Icon**: Blue clipboard (24px)
- **Title**: "Schedule Preventative Maintenance" (16px, Semi-bold, White)
- **Subtitle**: "3 clients due for quarterly ATM checks" (14px, Text Grey)
- **Button**: "Review" (Text button, Portal Blue)

**2. "Training Module Available" Card:**
- **Icon**: Blue book (24px)
- **Title**: "Training Module Available" (16px, Semi-bold, White)
- **Subtitle**: "New video tutorial: Advanced Lock Troubleshooting" (14px, Text Grey)
- **Button**: "Watch" (Text button, Portal Blue)

**3. "Expense Report Reminder" Card:**
- **Icon**: Blue document (24px)
- **Title**: "Expense Report Reminder" (16px, Semi-bold, White)
- **Subtitle**: "Submit your expenses from last week" (14px, Text Grey)
- **Button**: "Submit" (Text button, Portal Blue)

#### Section: "Recent Completions"
- **Title**: "Recent Completions" (20px, Bold, White)
- **Subtitle**: "Your latest completed work" (14px, Text Grey)
- **Spacing**: 16px below subtitle

**Completion Entry:**
- **Background**: Dark Grey (`#1E1E1E`)
- **Border Radius**: 12px
- **Padding**: 16px
- **Layout**: Horizontal with tags on right

**Content:**
- **Title**: "Regional Bank - Main Branch" (16px, White)
- **Subtitle**: "ATM Maintenance Check" (14px, Text Grey)
- **Tags**:
  - "low" (Amber background, White text, 12px, Medium weight)
  - "completed" (Green background, White text, 12px, Medium weight)
- **Right Side**:
  - "#SC-2843" (12px, Text Grey)
  - "Yesterday" (12px, Text Grey)

#### Section: "Recent Activity"
- **Title**: "Recent Activity" (20px, Bold, White)
- **Spacing**: 16px below title

**Activity Entries:**

**Entry Structure:**
- **Background**: Dark Grey (`#1E1E1E`)
- **Border Radius**: 12px
- **Padding**: 16px
- **Layout**: Horizontal (Icon + Text + Timestamp)

**Entry 1:**
- **Icon**: Green checkmark (20px)
- **Text**: "Ticket #SC-2838 completed at Metro Credit Union" (14px, Text Grey)
- **Timestamp**: "17:54" (12px, Text Grey, right-aligned)

**Entry 2:**
- **Icon**: Green checkmark (20px)
- **Text**: "Ticket #SC-2843 completed at Regional Bank" (14px, Text Grey)
- **Timestamp**: "17:54" (12px, Text Grey, right-aligned)

---

### Right Sidebar

#### Title Section
- **Icon**: Blue icon with radiating waves (24px)
- **Title**: "Dispatch Insights" (18px, Semi-bold, White)
- **Spacing**: 32px padding all sides

**Note**: Rest of sidebar is empty in current view

---

## 📏 SPACING SYSTEM

### Vertical Spacing
- **XS**: 4px
- **SM**: 8px
- **MD**: 16px
- **LG**: 24px
- **XL**: 32px
- **XXL**: 48px

### Horizontal Spacing
- **XS**: 4px
- **SM**: 8px
- **MD**: 16px
- **LG**: 24px
- **XL**: 32px

### Component Spacing
- **Between Cards**: 16px
- **Section Title to Content**: 16px
- **Card Internal Padding**: 16px
- **Button Padding**: 16px horizontal, 12px vertical

---

## 🔤 TYPOGRAPHY

### Font Sizes
- **XS**: 10px (Tags, small labels)
- **SM**: 12px (Timestamps, small text)
- **MD**: 14px (Body text, subtitles)
- **LG**: 16px (Card titles, navigation)
- **XL**: 18px (Section titles, app title)
- **XXL**: 20px (Section titles)
- **Huge**: 24px (Large headings)
- **Massive**: 32px (Card numbers)

### Font Weights
- **Normal**: 400 (Body text, subtitles)
- **Medium**: 500 (Buttons, labels)
- **Semi-bold**: 600 (Card titles, active nav)
- **Bold**: 700 (Section titles, numbers)

### Text Styles by Usage

**App Title:**
- Size: 18px
- Weight: Bold
- Color: White

**Section Titles:**
- Size: 20px
- Weight: Bold
- Color: White

**Section Subtitles:**
- Size: 14px
- Weight: Normal
- Color: Text Grey

**Card Titles:**
- Size: 16px
- Weight: Semi-bold
- Color: White

**Card Numbers:**
- Size: 32px
- Weight: Bold
- Color: White

**Card Subtitles:**
- Size: 14px
- Weight: Normal
- Color: Text Grey

**Body Text:**
- Size: 14px
- Weight: Normal
- Color: Text Grey

**Navigation Active:**
- Size: 14px
- Weight: Semi-bold
- Color: White

**Navigation Inactive:**
- Size: 14px
- Weight: Normal
- Color: Text Grey

**Button Text:**
- Size: 14px
- Weight: Medium
- Color: White (for primary buttons)

**Tag Text:**
- Size: 12px
- Weight: Medium
- Color: White

**Timestamps:**
- Size: 12px
- Weight: Normal
- Color: Text Grey

---

## 🎨 BORDER RADIUS

- **SM**: 4px (Tags)
- **MD**: 8px (Buttons, navigation items)
- **LG**: 12px (Cards)
- **XL**: 16px (Large cards)

---

## 🖼️ ICON SPECIFICATIONS

### Icon Sizes
- **XS**: 16px (Small graph icons, badges)
- **SM**: 20px (Activity entry icons)
- **MD**: 24px (Card icons, navigation icons)
- **LG**: 32px (Summary card icons)
- **XL**: 48px (Logo)

### Icon Colors
- **Primary**: Portal Blue (`#0056D2`)
- **Success**: Success Green (`#03DAC6`)
- **Warning**: Warning Amber (`#FFC107`)
- **Error**: Alert Red (`#CF6679`)
- **White**: White (`#FFFFFF`)
- **Grey**: Text Grey (`#B0B0B0`)
- **Purple**: Purple Accent (`#9C27B0`)

---

## 📦 COMPONENT LIBRARY

### Buttons

#### Primary Button (Elevated)
- **Background**: Portal Blue
- **Text**: White
- **Padding**: 16px H, 12px V
- **Border Radius**: 8px
- **Height**: 40px
- **Examples**: "New Call", "Time Entry"

#### Text Button
- **Background**: Transparent
- **Text**: Portal Blue
- **Padding**: 8px H, 4px V
- **Examples**: "Review", "Watch", "Submit"

### Cards

#### Summary Card
- **Background**: Dark Grey
- **Border Radius**: 12px
- **Padding**: 16px
- **Elevation**: 2px shadow
- **Layout**: Vertical (Icon top, Number middle, Label bottom)

#### Information Card
- **Background**: Dark Grey
- **Border Radius**: 12px
- **Padding**: 16px
- **Layout**: Horizontal (Icon left, Text right)

#### Action Card
- **Background**: Dark Grey
- **Border Radius**: 12px
- **Padding**: 16px
- **Layout**: Horizontal (Icon left, Text center, Button right)

#### Entry Card
- **Background**: Dark Grey
- **Border Radius**: 12px
- **Padding**: 16px
- **Layout**: Horizontal (Icon left, Text center, Tags/Timestamp right)

### Tags

#### Tag Structure
- **Padding**: 4px horizontal, 2px vertical
- **Border Radius**: 4px
- **Font Size**: 12px
- **Font Weight**: Medium
- **Text Color**: White

#### Tag Variants
- **Quiet Day**: Green background (`#4CAF50`)
- **Low**: Amber background (`#FFC107`)
- **Completed**: Green background (`#03DAC6`)

### Navigation Items

#### Active State
- **Background**: Portal Blue
- **Icon**: White
- **Text**: White, Semi-bold
- **Border Radius**: 8px

#### Inactive State
- **Background**: Transparent
- **Icon**: Text Grey
- **Text**: Text Grey, Normal

---

## 🎭 SHADOWS

### Card Shadow
- **Color**: Black with 20% opacity
- **Blur**: 4px
- **Offset**: (0, 2)

### Button Shadow (if needed)
- **Color**: Portal Blue with 30% opacity
- **Blur**: 8px
- **Offset**: (0, 4)

---

## ✅ IMPLEMENTATION CHECKLIST

- [x] Color palette defined
- [x] Layout structure documented
- [x] Typography system specified
- [x] Component specifications created
- [x] Spacing system defined
- [x] Icon specifications documented
- [x] Border radius values specified
- [x] Shadow specifications included
- [x] All buttons documented
- [x] All cards documented
- [x] Navigation system documented
- [x] Tag system documented

---

## 📝 NOTES

- All measurements are in pixels
- Colors are specified in both hex and Flutter Color format
- The layout is responsive but fixed-width sidebars
- Main content area is scrollable
- All interactive elements should have hover states (not visible in screenshot)
- Dark mode is the default and only theme

---

**Last Updated**: Based on screenshot analysis
**Version**: 1.0.0
