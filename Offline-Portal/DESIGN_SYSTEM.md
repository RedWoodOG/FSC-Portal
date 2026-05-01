# FSC Portal Offline - Design System

**Version:** 2.0.26  
**Last Updated:** January 31, 2026  
**Purpose:** Complete design token reference for colors, typography, spacing, and visual styling

---

## Table of Contents

1. [Color System](#color-system)
2. [Typography](#typography)
3. [Spacing System](#spacing-system)
4. [Layout Specifications](#layout-specifications)
5. [Gradients](#gradients)
6. [Effects & Shadows](#effects--shadows)
7. [Component Styles](#component-styles)
8. [Icons](#icons)
9. [Animations](#animations)
10. [Usage Guidelines](#usage-guidelines)

---

## Color System

**Source File:** `lib/theme/app_theme.dart`

### Color Palette

#### Background Colors

```
┌─────────────────────────────────────────────────────┐
│ Deep Black (#121212)                                │ ← Main application background
├─────────────────────────────────────────────────────┤
│ Dark Grey (#1E1E1E)                                 │ ← Cards, surfaces, modals
└─────────────────────────────────────────────────────┘
```

**Usage:**
- **Deep Black (#121212):** 
  - Class: `AppPalette.deepBlack`, `AppColors.background`
  - Use: Scaffold backgrounds, main screen backgrounds
  - Example: `backgroundColor: AppColors.background`

- **Dark Grey (#1E1E1E):**
  - Class: `AppPalette.darkGrey`, `AppColors.surface`
  - Use: Cards, panels, dialog backgrounds, AppBar
  - Example: `color: AppColors.surface`

---

#### Brand Colors

```
Primary Blue (#0056D2)    ████████
Portal Blue Light (#1E6FE8)  ████████ (Lighter variant for hover)
```

**Primary Blue (#0056D2):**
- Class: `AppPalette.portalBlue`, `AppColors.primary`
- Use: Primary buttons, active states, links, focus indicators
- RGB: (0, 86, 210)
- HSL: (214°, 100%, 41%)

**Examples:**
- Active navigation items
- Primary buttons
- Active border colors
- Icon highlights
- Progress indicators

**Portal Blue Light (#1E6FE8):**
- Class: `AppPalette.portalBlueLight`
- Use: Hover states, lighter accents
- RGB: (30, 111, 232)

---

#### Status Colors

```
Success Green (#03DAC6)   ████████  ✓ Completed, Checkmarks
Warning Amber (#FFC107)   ████████  ⚠ Low Priority, Warnings
Alert Red (#CF6679)       ████████  ✗ Errors, Notifications
Quiet Day Green (#4CAF50) ████████  ● Status Tags
```

**Success Green (#03DAC6):**
- Class: `AppPalette.successGreen`, `AppColors.success`
- Use: Completed states, success messages, positive indicators
- Snackbar background for success

**Warning Amber (#FFC107):**
- Class: `AppPalette.warningAmber`, `AppColors.warning`
- Use: Warnings, low priority items, caution states
- Medium priority badges

**Alert Red (#CF6679):**
- Class: `AppPalette.alertRed`, `AppColors.error`
- Use: Errors, high priority, delete actions, failures
- Error snackbars, validation errors

**Quiet Day Green (#4CAF50):**
- Class: `AppPalette.quietDayGreen`
- Use: "Quiet Day" status tags
- Positive status indicators

---

#### Accent Colors

```
Purple Accent (#9C27B0)   ████████  Graphs, Route Lines, Charts
```

**Purple Accent (#9C27B0):**
- Class: `AppPalette.purpleAccent`, `AppColors.purpleAccent`
- Use: Chart icons, route polylines, special accents
- Weekly throughput KPI color
- PM route planning lines

---

#### Text Colors

```
White (#FFFFFF)           ████████  Primary text
Grey (#B0B0B0)            ████████  Secondary text
Grey Dark (#808080)       ████████  Tertiary text
```

**Text Hierarchy:**

1. **Primary Text (#FFFFFF):**
   - Class: `AppPalette.textWhite`, `AppColors.textPrimary`
   - Use: Headings, titles, important text, labels
   - Font weight: Normal to Bold

2. **Secondary Text (#B0B0B0):**
   - Class: `AppPalette.textGrey`, `AppColors.textSecondary`
   - Use: Descriptions, subtitles, metadata, placeholders
   - Font weight: Normal

3. **Tertiary Text (#808080):**
   - Class: `AppPalette.textGreyDark`, `AppColors.textTertiary`
   - Use: Timestamps, secondary metadata, disabled text
   - Font weight: Normal

---

#### Border Colors

```
Border Grey (#2A2A2F)     ████████  Dividers, Borders
```

**Border Grey (#2A2A2F):**
- Class: `AppPalette.borderGrey`, `AppColors.border`, `AppColors.divider`
- Use: Card borders, dividers, input borders (unfocused)
- Subtle separation between elements

---

#### Client Theme Colors (Map Pins)

```
RBFCU Pin       Blue    ████████
Jefferson Pin   Yellow  ████████ (Amber)
Prosperity Pin  Red     ████████
Starting Point  Green   ████████
```

**Usage:**
- `AppColors.pinRBFCU` - Blue
- `AppColors.pinJefferson` - Colors.amber
- `AppColors.pinProsperity` - Red
- `AppColors.pinStartPoint` - Success green

---

### Color Usage Matrix

| Element | Color | Class |
|---------|-------|-------|
| **Backgrounds** |
| App background | #121212 | `AppColors.background` |
| Cards/Surfaces | #1E1E1E | `AppColors.surface` |
| Input fields | #121212 | `AppColors.background` |
| **Interactive** |
| Primary button | #0056D2 | `AppColors.primary` |
| Active nav item | #0056D2 | `AppColors.primary` |
| Focus border | #0056D2 | `AppColors.primary` |
| Link color | #0056D2 | `AppColors.primary` |
| **Status** |
| Success | #03DAC6 | `AppColors.success` |
| Warning | #FFC107 | `AppColors.warning` |
| Error | #CF6679 | `AppColors.error` |
| **Text** |
| Headings | #FFFFFF | `AppColors.textPrimary` |
| Body text | #B0B0B0 | `AppColors.textSecondary` |
| Metadata | #808080 | `AppColors.textTertiary` |
| **Borders** |
| Default | #2A2A2F | `AppColors.border` |
| Dividers | #2A2A2F | `AppColors.divider` |

---

## Typography

**Source File:** `lib/theme/app_theme.dart` (lines 129-234)

### Font Scale

```
Massive  32px  ████████████  KPI Numbers, Large Values
Huge     24px  ██████████    Large Headings
XXL      20px  ████████      Section Titles
XL       18px  ███████       App Title, Section Titles
LG       16px  ██████        Card Titles, Navigation
MD       14px  █████         Body Text, Subtitles
SM       12px  ████          Timestamps, Small Text
XS       10px  ███           Tags, Labels
```

**Font Sizes:**
- `AppTypography.fontSizeXS` = 10px
- `AppTypography.fontSizeSM` = 12px
- `AppTypography.fontSizeMD` = 14px
- `AppTypography.fontSizeLG` = 16px
- `AppTypography.fontSizeXL` = 18px
- `AppTypography.fontSizeXXL` = 20px
- `AppTypography.fontSizeHuge` = 24px
- `AppTypography.fontSizeMassive` = 32px

---

### Font Weights

```
Normal    400  Regular text, body copy
Medium    500  Subtle emphasis, buttons
SemiBold  600  Navigation items (active), card titles
Bold      700  Headings, important labels
```

**Font Weights:**
- `AppTypography.weightNormal` = FontWeight.normal (400)
- `AppTypography.weightMedium` = FontWeight.w500 (500)
- `AppTypography.weightSemiBold` = FontWeight.w600 (600)
- `AppTypography.weightBold` = FontWeight.bold (700)

---

### Text Styles

#### App Title
```dart
AppTypography.appTitle
Font: 18px, Bold
Color: textPrimary (#FFFFFF)
Use: "Portal" text in sidebar
```

#### Section Titles
```dart
AppTypography.sectionTitle
Font: 20px, Bold
Color: textPrimary
Use: Major section headings
```

#### Section Subtitles
```dart
AppTypography.sectionSubtitle
Font: 14px, Normal
Color: textSecondary (#B0B0B0)
Use: Descriptions below section titles
```

#### Card Titles
```dart
AppTypography.cardTitle
Font: 16px, SemiBold
Color: textPrimary
Use: Card headings, item titles
```

#### Card Subtitles
```dart
AppTypography.cardSubtitle
Font: 14px, Normal
Color: textSecondary
Use: Secondary info in cards
```

#### Card Numbers (KPIs)
```dart
AppTypography.cardNumber
Font: 32px, Bold
Color: textPrimary
Use: Large numeric displays, KPI values
```

#### Body Text
```dart
AppTypography.bodyText
Font: 14px, Normal
Color: textSecondary
Use: Paragraphs, descriptions, content
```

#### Navigation Items

**Active:**
```dart
AppTypography.navItemActive
Font: 14px, SemiBold
Color: textPrimary
Use: Selected navigation item
```

**Inactive:**
```dart
AppTypography.navItemInactive
Font: 14px, Normal
Color: textSecondary
Use: Unselected navigation items
```

#### Button Text
```dart
AppTypography.buttonText
Font: 14px, Medium
Color: textPrimary
Use: Button labels
```

#### Tags
```dart
AppTypography.tagText
Font: 12px, Medium
Color: textPrimary
Use: Status badges, category tags
```

#### Timestamps
```dart
AppTypography.timestamp
Font: 12px, Normal
Color: textSecondary
Use: Dates, times, "X ago" text
```

---

### Typography Usage Guidelines

**Hierarchy:**
```
AppTitle (18px Bold)           "Portal"
    ↓
SectionTitle (20px Bold)       "Operations"
    ↓
SectionSubtitle (14px Normal)  "Manage clients and sites"
    ↓
CardTitle (16px SemiBold)      "RBFCU Main Branch"
    ↓
CardSubtitle (14px Normal)     "123 Main St, San Antonio"
    ↓
BodyText (14px Normal)         "Description text here..."
    ↓
Timestamp (12px Normal)        "2 hours ago"
```

**Special Cases:**
- **KPI Numbers:** Massive (32px) for visual impact
- **Labels:** XS (10px) for compact UI elements
- **Form Labels:** SM (12px) above inputs

---

## Spacing System

**Source File:** `lib/theme/app_theme.dart` (lines 87-103, 486-503)

### Spacing Scale

```
XS    4px   ▌        Fine-tuning, tight spacing
SM    8px   ▌▌       Compact spacing, between related items
MD    16px  ▌▌▌▌     Standard spacing, most common use
LG    24px  ▌▌▌▌▌▌   Section spacing, card padding
XL    32px  ▌▌▌▌▌▌▌▌ Large gaps, screen padding
XXL   48px  ▌▌▌▌▌▌▌▌▌▌▌▌ Extra large gaps, major sections
```

**Spacing Constants:**
- `AppLayout.spacingXS` = 4.0
- `AppLayout.spacingSM` = 8.0
- `AppLayout.spacingMD` = 16.0
- `AppLayout.spacingLG` = 24.0
- `AppLayout.spacingXL` = 32.0
- `AppLayout.spacingXXL` = 48.0

---

### Spacing Widgets

**Vertical:**
```dart
AppSpacing.v4   = SizedBox(height: 4)
AppSpacing.v8   = SizedBox(height: 8)
AppSpacing.v12  = SizedBox(height: 12)
AppSpacing.v16  = SizedBox(height: 16)
AppSpacing.v24  = SizedBox(height: 24)
AppSpacing.v32  = SizedBox(height: 32)
AppSpacing.v48  = SizedBox(height: 48)
```

**Horizontal:**
```dart
AppSpacing.h4   = SizedBox(width: 4)
AppSpacing.h8   = SizedBox(width: 8)
AppSpacing.h12  = SizedBox(width: 12)
AppSpacing.h16  = SizedBox(width: 16)
AppSpacing.h24  = SizedBox(width: 24)
AppSpacing.h32  = SizedBox(width: 32)
```

---

### Spacing Usage

| Use Case | Spacing | Example |
|----------|---------|---------|
| Between related items | SM (8px) | Icon and text in a row |
| Between form fields | LG (24px) | Text inputs in a form |
| Card internal padding | MD-LG (16-24px) | GlassCard padding |
| Screen edge padding | XL (32px) | Home screen container |
| Section gaps | XL-XXL (32-48px) | Between major sections |
| Button padding horizontal | MD (16px) | Button text padding |
| Button padding vertical | SM-MD (8-12px) | Button height |
| Tight spacing | XS (4px) | Tags, badges |

---

## Layout Specifications

**Source File:** `lib/theme/app_theme.dart` (lines 86-125)

### Border Radius

```
SM    4px   ▢   Tags, small elements
MD    8px   ▢   Buttons, nav items, inputs
LG    12px  ▢   Cards, standard components
XL    16px  ▢   Large cards, modal top corners
```

**Border Radius Constants:**
- `AppLayout.radiusSM` = 4.0
- `AppLayout.radiusMD` = 8.0
- `AppLayout.radiusLG` = 12.0
- `AppLayout.radiusXL` = 16.0

**Usage:**
```dart
BorderRadius.circular(AppLayout.radiusMD)  // Buttons
BorderRadius.circular(AppLayout.radiusLG)  // Cards
BorderRadius.vertical(
  top: Radius.circular(AppLayout.radiusXL)  // Modals
)
```

---

### Component Dimensions

```
┌─────────────────────────────────────────┐
│ Sidebar Navigation    240px             │
│ EVA Panel (Expanded)  400px             │
│ EVA Panel (Collapsed) 56px              │
│ Header Height         64px              │
│ Button Height         40px              │
│ Nav Item Height       48px              │
│ Nav Icon Size         24px              │
│ Logo Size             48px              │
└─────────────────────────────────────────┘
```

**Layout Constants:**
- `AppLayout.sidebarWidth` = 240.0
- `AppLayout.rightSidebarWidth` = 280.0 (not currently used)
- `AppLayout.headerHeight` = 64.0
- `AppLayout.buttonHeight` = 40.0
- `AppLayout.navItemHeight` = 48.0
- `AppLayout.navIconSize` = 24.0
- `AppLayout.logoSize` = 48.0

---

### Card Specifications

**Standard Card:**
```dart
Padding: AppLayout.cardPaddingAll (16px all sides)
Elevation: AppLayout.cardElevation (2.0)
Border Radius: AppLayout.radiusLG (12px)
```

**Button Specifications:**
```dart
Height: AppLayout.buttonHeight (40px)
Padding Horizontal: AppLayout.buttonPaddingH (16px)
Padding Vertical: AppLayout.buttonPaddingV (12px)
Border Radius: AppLayout.buttonBorderRadius (8px)
```

**Navigation Item:**
```dart
Height: AppLayout.navItemHeight (48px)
Padding Horizontal: AppLayout.navItemPaddingH (16px)
Icon Size: AppLayout.navIconSize (24px)
```

---

## Gradients

**Source File:** `lib/theme/app_theme.dart` (lines 390-435)

### Deep Ocean (Background Gradient)

```
┌─────────────────────────────────────────┐
│ #0F172A (Deep Slate/Blue)               │ ← Start (Top-Left)
│                  ↘                      │
│                    ↘                    │
│                      ↘                  │
│                        ↘                │
│                          ↘              │
│                            ↘            │
│                              ↘          │
│               #020617 (Midnight)        │ ← End (Bottom-Right)
└─────────────────────────────────────────┘
```

**Definition:**
```dart
AppGradients.deepOcean
LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF0F172A),  // Deep Slate/Blue
    Color(0xFF020617),  // Midnight
  ],
)
```

**Usage:** Main screen backgrounds (Home view, etc.)

---

### Primary Gradient (Electric Blue)

```
┌─────────────────────────────────────────┐
│ #0056D2 (Portal Blue)                   │ ← Start
│              ↘                          │
│                ↘                        │
│                  ↘                      │
│                    ↘                    │
│                      #002D72 (Deep Blue)│ ← End
└─────────────────────────────────────────┘
```

**Definition:**
```dart
AppGradients.primary
LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF0056D2),  // Portal Blue
    Color(0xFF002D72),  // Deep Blue
  ],
)
```

**Usage:** Primary action buttons, special accent elements

---

### Glass Surface (Mica)

```
┌─────────────────────────────────────────┐
│ White 5% opacity                        │ ← Start
│              ↘                          │
│                ↘                        │
│                  ↘                      │
│                    ↘                    │
│                      White 2% opacity   │ ← End
└─────────────────────────────────────────┘
```

**Definition:**
```dart
AppGradients.glassSurface
LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Colors.white.withOpacity(0.05),
    Colors.white.withOpacity(0.02),
  ],
)
```

**Usage:** GlassCard backgrounds (glassmorphism effect)

---

### Border Shine

```
┌─────────────────────────────────────────┐
│ White 10% ──► White 0% ──► White 2%     │
└─────────────────────────────────────────┘
   Stops:        0.0     0.5     1.0
```

**Definition:**
```dart
AppGradients.borderShine
LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Colors.white.withOpacity(0.1),
    Colors.white.withOpacity(0.0),
    Colors.white.withOpacity(0.02),
  ],
  stops: [0.0, 0.5, 1.0],
)
```

**Usage:** Subtle shine effect on borders (optional, currently `hasShine` parameter)

---

## Effects & Shadows

### Glassmorphism Effect

**Implementation (GlassCard):**

```dart
// 1. Backdrop Blur
BackdropFilter(
  filter: ImageFilter.blur(
    sigmaX: AppGlass.blurSigma,  // 10.0
    sigmaY: AppGlass.blurSigma,  // 10.0
  ),
)

// 2. Translucent Gradient Background
decoration: BoxDecoration(
  gradient: AppGradients.glassSurface,
)

// 3. Subtle Border
border: Border.all(
  color: Colors.white.withOpacity(0.1),
  width: 1,
)
```

**Visual Result:**
- Blurred background content visible through card
- Translucent white overlay
- Subtle border for definition
- Modern, premium appearance

---

### Box Shadows

**GlassCard Shadow:**
```dart
boxShadow: [
  BoxShadow(
    color: Colors.black.withOpacity(0.3),
    blurRadius: 20,
    spreadRadius: -5,
    offset: Offset(0, 8),
  ),
]
```

**Visual:**
- Soft shadow below cards
- 8px vertical offset
- Negative spread creates tighter shadow
- 30% black opacity

**NewsCard Shadow:**
```dart
boxShadow: [
  BoxShadow(
    color: Colors.black.withOpacity(0.2),
    blurRadius: 4,
    offset: Offset(0, 2),
  ),
]
```

**Visual:**
- Lighter shadow
- Smaller offset (2px)
- Less pronounced than GlassCard

---

### Glass Decorations

**Medium Glass (Default):**
```dart
AppGlass.mediumDecoration
BoxDecoration(
  gradient: AppGradients.glassSurface,
  borderRadius: BorderRadius.circular(AppLayout.radiusLG),
  border: Border.all(
    color: Colors.white.withOpacity(0.05),
    width: 1,
  ),
  boxShadow: [/* ... */],
)
```

**Active Glass:**
```dart
AppGlass.activeDecoration
BoxDecoration(
  color: AppPalette.portalBlue.withOpacity(0.15),
  borderRadius: BorderRadius.circular(AppLayout.radiusMD),
  border: Border.all(
    color: AppPalette.portalBlue.withOpacity(0.3),
    width: 1,
  ),
)
```

**Usage:** Selected/active states with blue tint

---

## Component Styles

### Navigation Items

**Active:**
```dart
AppComponents.navItemActiveDecoration
BoxDecoration(
  color: AppColors.primary,
  borderRadius: BorderRadius.circular(AppLayout.radiusMD),
)
```

**Inactive:**
```dart
AppComponents.navItemInactiveDecoration
BoxDecoration(
  color: Colors.transparent,
)
```

---

### Buttons

**Primary Button:**
```dart
AppComponents.primaryButtonStyle
ElevatedButton.styleFrom(
  backgroundColor: AppColors.primary,
  foregroundColor: AppColors.textPrimary,
  padding: EdgeInsets.symmetric(
    horizontal: 16px,
    vertical: 12px,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8px),
  ),
  elevation: 0,
)
```

**Text Button:**
```dart
AppComponents.textButtonStyle
TextButton.styleFrom(
  foregroundColor: AppColors.primary,
  padding: EdgeInsets.symmetric(
    horizontal: 8px,
    vertical: 4px,
  ),
)
```

---

### Tags/Badges

**Quiet Day Tag:**
```dart
AppComponents.tagQuietDayDecoration
BoxDecoration(
  color: AppPalette.quietDayGreen,
  borderRadius: BorderRadius.circular(AppLayout.radiusSM),
)
Padding: EdgeInsets.symmetric(horizontal: 8px, vertical: 4px)
```

**Low Priority:**
```dart
AppComponents.tagLowDecoration
BoxDecoration(
  color: AppPalette.warningAmber,
  borderRadius: BorderRadius.circular(AppLayout.radiusSM),
)
```

**Completed:**
```dart
AppComponents.tagCompletedDecoration
BoxDecoration(
  color: AppPalette.successGreen,
  borderRadius: BorderRadius.circular(AppLayout.radiusSM),
)
```

---

### User Avatar

```dart
AppComponents.userAvatarDecoration
BoxDecoration(
  color: AppColors.primary,
  shape: BoxShape.circle,
)
Size: 40x40px
Content: Initials (centered, white text)
```

---

## Icons

**Source File:** `lib/theme/app_theme.dart` (lines 369-387)

### Icon Sizes

```
XS    16px  Small graph icons, badges
SM    20px  Activity entry icons
MD    24px  Card icons, navigation icons (standard)
LG    32px  Summary card icons
XL    48px  Logo size
```

**Icon Size Constants:**
- `AppIcons.sizeXS` = 16.0
- `AppIcons.sizeSM` = 20.0
- `AppIcons.sizeMD` = 24.0
- `AppIcons.sizeLG` = 32.0
- `AppIcons.sizeXL` = 48.0

---

### Icon Colors

```
Primary   #0056D2  ████████  Interactive, active states
Success   #03DAC6  ████████  Completed, positive
Warning   #FFC107  ████████  Warnings, caution
Error     #CF6679  ████████  Errors, failures
White     #FFFFFF  ████████  Default icons
Grey      #B0B0B0  ████████  Inactive, secondary
Purple    #9C27B0  ████████  Special accents
```

**Icon Color Constants:**
- `AppIcons.colorPrimary` = `AppPalette.portalBlue`
- `AppIcons.colorSuccess` = `AppPalette.successGreen`
- `AppIcons.colorWarning` = `AppPalette.warningAmber`
- `AppIcons.colorError` = `AppPalette.alertRed`
- `AppIcons.colorWhite` = `AppPalette.textWhite`
- `AppIcons.colorGrey` = `AppPalette.textGrey`
- `AppIcons.colorPurple` = `AppPalette.purpleAccent`

---

## Animations

**Source File:** `lib/theme/app_theme.dart` (lines 470-480)

### Animation Durations

```
Quick   200ms  ████          Button presses, quick feedback
Normal  300ms  ██████        Standard transitions
Slow    500ms  ██████████    Emphasized transitions
```

**Duration Constants:**
- `AppAnimations.quick` = Duration(milliseconds: 200)
- `AppAnimations.normal` = Duration(milliseconds: 300)
- `AppAnimations.slow` = Duration(milliseconds: 500)

---

### Animation Curves

```
Emphasis  Curves.easeInOutCubic  Smooth, emphasized motion
Entrance  Curves.easeOutQuad     Elements appearing
Exit      Curves.easeInQuad      Elements disappearing
```

**Curve Constants:**
- `AppAnimations.emphasis` = Curves.easeInOutCubic
- `AppAnimations.entrance` = Curves.easeOutQuad
- `AppAnimations.exit` = Curves.easeInQuad

---

### Usage Example

```dart
AnimatedContainer(
  duration: AppAnimations.normal,
  curve: AppAnimations.emphasis,
  // ... properties
)

Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => NextScreen(),
    transitionDuration: AppAnimations.slow,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  ),
);
```

---

## Usage Guidelines

### When to Use Each Color

**Background Colors:**
- Use `AppColors.background` for main scaffold backgrounds
- Use `AppColors.surface` for elevated surfaces (cards, modals, AppBar)

**Interactive Elements:**
- Use `AppColors.primary` for:
  - Primary action buttons
  - Active navigation items
  - Focus states
  - Links and tappable text
  - Progress indicators

**Status Indication:**
- Use `AppColors.success` for:
  - Completed states
  - Success messages
  - Positive confirmations
  
- Use `AppColors.warning` for:
  - Warnings
  - Medium priority
  - Caution states
  
- Use `AppColors.error` for:
  - Errors
  - High priority
  - Destructive actions
  - Validation failures

**Text Colors:**
- Use `AppColors.textPrimary` for headings and important text
- Use `AppColors.textSecondary` for body text and descriptions
- Use `AppColors.textTertiary` for timestamps and metadata

---

### Spacing Best Practices

**Consistent Spacing:**
- Always use spacing constants (never magic numbers)
- Prefer spacing widgets (`AppSpacing.v16`) for readability
- Use larger spacing between unrelated elements
- Use smaller spacing between related elements

**Example:**
```dart
Column(
  children: [
    Text('Heading'),
    AppSpacing.v4,  // Small gap to subtitle
    Text('Subtitle'),
    AppSpacing.v24, // Large gap to next section
    NextSection(),
  ],
)
```

---

### Typography Best Practices

**Hierarchy:**
- Establish clear visual hierarchy
- Limit to 3-4 text sizes per screen
- Use font weight for differentiation
- Don't rely solely on color for hierarchy

**Readability:**
- Body text should be at least 14px
- Sufficient contrast against background
- Adequate line height (default is good)
- Avoid long line lengths

---

### Accessibility Considerations

**Color Contrast:**
- Primary text on background: 14.7:1 (AAA)
- Secondary text on background: 7.8:1 (AA)
- Primary blue on background: 4.7:1 (AA)

**Touch Targets:**
- Minimum 48x48px for interactive elements
- Navigation items: 48px height ✓
- Buttons: 40px height (close, acceptable)
- Icon buttons: 48x48px ✓

**Visual Feedback:**
- All interactive elements provide visual feedback
- InkWell ripples on tappable cards
- Color changes on active states
- Loading indicators for async operations

---

## Design Token Reference

### Quick Reference Table

| Token | Value | Usage |
|-------|-------|-------|
| **Colors** |
| `AppColors.background` | #121212 | Main backgrounds |
| `AppColors.surface` | #1E1E1E | Cards, modals |
| `AppColors.primary` | #0056D2 | Primary actions |
| `AppColors.success` | #03DAC6 | Success states |
| `AppColors.error` | #CF6679 | Error states |
| `AppColors.textPrimary` | #FFFFFF | Headings |
| `AppColors.textSecondary` | #B0B0B0 | Body text |
| **Spacing** |
| `AppLayout.spacingSM` | 8px | Tight spacing |
| `AppLayout.spacingMD` | 16px | Standard spacing |
| `AppLayout.spacingLG` | 24px | Section spacing |
| `AppLayout.spacingXL` | 32px | Large gaps |
| **Typography** |
| `AppTypography.bodyText` | 14px Normal | Body text |
| `AppTypography.cardTitle` | 16px SemiBold | Card titles |
| `AppTypography.sectionTitle` | 20px Bold | Section titles |
| **Border Radius** |
| `AppLayout.radiusMD` | 8px | Buttons, inputs |
| `AppLayout.radiusLG` | 12px | Cards |
| `AppLayout.radiusXL` | 16px | Large cards |

---

**End of Design System**
