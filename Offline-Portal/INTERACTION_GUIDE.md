# FSC Portal Offline - Interaction Guide

**Version:** 2.0.26  
**Last Updated:** January 31, 2026  
**Purpose:** Complete documentation of user interactions, gestures, navigation flows, and data patterns

---

## Table of Contents

1. [Navigation Patterns](#navigation-patterns)
2. [Touch Interactions](#touch-interactions)
3. [Data Flow Patterns](#data-flow-patterns)
4. [Search and Filter](#search-and-filter)
5. [Modal Interactions](#modal-interactions)
6. [Real-Time Updates](#real-time-updates)
7. [Error Handling](#error-handling)

---

## Navigation Patterns

### Primary Navigation

#### Desktop Sidebar Navigation

**Location:** Left sidebar (240px width)  
**Interaction:** Click navigation item

**Flow:**
```
User clicks nav item
        ↓
NavigationState.navigateTo(index) called
        ↓
_selectedIndex updated
        ↓
notifyListeners() triggers rebuild
        ↓
MainNavigationScreen rebuilds
        ↓
Active item styling updates (primary blue background)
        ↓
PortalShell receives new child widget
        ↓
Selected screen renders in main content area
```

**Visual Feedback:**
- **Active State:**
  - Background: Primary blue (#0056D2)
  - Text: White, SemiBold
  - Icon: Primary blue
  - Border radius: 8px

- **Inactive State:**
  - Background: Transparent
  - Text: Grey, Normal weight
  - Icon: Grey

- **Hover State:**
  - InkWell splash effect
  - Subtle highlight

**Keyboard Support:**
- None (mouse/touch only currently)

---

#### Mobile Bottom Navigation

**Location:** Bottom of screen (fixed)  
**Interaction:** Tap navigation item

**Limitations:**
- Shows only first 5 destinations (indices 0-4)
- Remaining screens (5-9) accessible via other means
- If user navigates to index ≥5, bottom bar shows Home as active

**Flow:**
```
User taps bottom nav item
        ↓
onTap(index) called
        ↓
NavigationState.navigateTo(index)
        ↓
Screen switches
        ↓
Bottom bar updates active indicator
```

**Visual Feedback:**
- Selected: Primary blue icon + label
- Unselected: Grey icon + label
- Type: Fixed (all items always visible)

---

### Secondary Navigation

#### Programmatic Navigation

**From Any Widget:**

```dart
// Get NavigationState from context
final navState = context.read<NavigationState>();

// Navigate to specific screen
navState.navigateTo(3);  // Go to Locations

// Or use helper methods
navState.navigateToHome();
navState.navigateToWork();
navState.navigateToOperations();
navState.navigateToLocations();
navState.navigateToPeople();
navState.navigateToKnowledge();
```

**Example Use Cases:**
1. **Home Tactical Shortcuts:**
   - "Theatre Map" button → `navigateToLocations()`
   - "Agent Tools" button → Navigate to KnowledgeImportScreen

2. **Cross-Screen Links:**
   - Work order → View site → Navigate to Locations (map)
   - Knowledge entry → View equipment → Navigate to Equipment screen

---

#### Hierarchical Navigation

**Operations Screen Pattern:**

```
Level 1: Client List
        ↓ [View Sites]
Level 2: Site List (for selected client)
        ↓ [Back Button]
Level 1: Client List
```

**Implementation:**
- Local state management (not NavigationState)
- Back button in AppBar when in site view
- setState() to switch between views

**Flow:**
```
User taps "View Sites" on client card
        ↓
setState(() { selectedClient = client })
        ↓
Rebuild shows site list instead of client list
        ↓
AppBar shows back button
        ↓
User taps back
        ↓
setState(() { selectedClient = null })
        ↓
Rebuild shows client list again
```

---

### Modal Navigation

**Bottom Sheet Pattern:**

```
User triggers action (button tap, etc.)
        ↓
showModalBottomSheet() called
        ↓
Sheet slides up from bottom
        ↓
User interacts with form/content
        ↓
User submits or closes
        ↓
Navigator.pop(context) called
        ↓
Sheet slides down and dismisses
        ↓
Optional: Snackbar confirmation shown
```

**Common Triggers:**
- Home → "Scan Receipts" → `ScanReceiptSheet`
- Home → "Intel Entry" → `NewNoteSheet`
- Home → "+" (announcements) → `CreateAnnouncementSheet`
- Equipment list → Card tap → `EquipmentDetailSheet`
- Locations → Marker tap → `SiteDetailSheet`

**Sheet Characteristics:**
- Type: `DraggableScrollableSheet`
- Initial size: 50-80% of screen
- Can be dragged to resize
- Tap outside or swipe down to dismiss
- X button in header for explicit close

---

## Touch Interactions

### Tap Interactions

#### Single Tap

**GlassCard with onTap:**
```
User taps card
        ↓
InkWell detects tap
        ↓
Splash animation (primary blue, 0.1 opacity)
        ↓
onTap callback executes
        ↓
Action performed (navigate, open modal, etc.)
```

**Examples:**
- KPI tiles (no action currently)
- Tactical shortcuts → Open modals
- News cards → View full article (if implemented)
- User cards → Open user details
- Equipment cards → Open detail sheet

**Visual Feedback:**
- InkWell splash color
- Ripple animation from tap point
- No color change on tap (handled by splash)

---

#### Long Press

**Map Markers (Locations screen):**

Not currently implemented. All interactions are single tap.

**Potential Future Use:**
- Long press marker → Quick actions menu
- Long press card → Context menu

---

### Scroll Interactions

#### Vertical Scroll

**Main Content Areas:**
- All screens use `SingleChildScrollView` or `ListView`
- Physics: Platform default (bounce on iOS, overscroll on Android)
- Scrollbar: Auto-shown when content exceeds viewport

**Infinite Scroll (Work Orders):**
```
User scrolls to bottom of list
        ↓
Scroll position detected
        ↓
_loadMoreWorkOrders() called
        ↓
Fetch next 20 items from database
        ↓
Add to existing list
        ↓
setState() triggers rebuild
        ↓
New items appear
        ↓
Loading indicator shows during fetch
```

**Scroll-to-Top:**
- No FAB or explicit scroll-to-top button
- User must manually scroll

---

#### Horizontal Scroll

**News Feeds:**
- Industry Briefing (Home)
- Corporate Intel announcements (Home)

**Interaction:**
```
User swipes left/right on feed
        ↓
ListView horizontal scroll physics
        ↓
Cards smoothly scroll
        ↓
Momentum continues after release
```

**Indicators:**
- No scroll indicators shown
- Visual overflow hint (cards appear to continue)
- No snap-to-card behavior

---

### Drag Interactions

#### DraggableScrollableSheet

**Bottom Sheets:**

```
User drags handle bar or sheet content
        ↓
Sheet resizes between min/max sizes
        ↓
minChildSize: 0.5 (50% of screen)
        ↓
maxChildSize: 0.95 (95% of screen)
        ↓
Release: Settles to nearest breakpoint
```

**Handle Bar:**
- Visual: 40px wide, 4px tall, grey
- Location: Top of sheet, 12px margin
- Purpose: Visual affordance for dragging

**Swipe to Dismiss:**
```
User swipes down past min size
        ↓
Sheet dismisses
        ↓
Navigator.pop() called
        ↓
Returns to previous screen
```

---

### Keyboard Interactions

#### Text Input

**Text Fields:**
```
User taps text field
        ↓
Keyboard appears
        ↓
Field gains focus (border turns primary blue)
        ↓
User types
        ↓
Text appears in field
        ↓
User taps outside or submit
        ↓
Keyboard dismisses
        ↓
Field loses focus (border returns to grey)
```

**Enter Key Behavior:**
- Single-line fields: Submit form or move to next field
- Multi-line fields: New line
- Search fields: Trigger search

**Tab Navigation:**
- Not implemented (mobile-first app)

---

#### On-Screen Keyboards

**Numeric Input (Amount fields):**
- Keyboard type: Number with decimals
- Shows decimal point
- No negative numbers

**Date Selection:**
- Tapping date field opens `DatePicker` dialog
- No direct keyboard input

**Dropdowns:**
- No keyboard input
- Must select from list

---

## Data Flow Patterns

### Real-Time Data Pattern

**StreamBuilder Architecture:**

```
Database Table Changes
        ↓
Drift emits new Stream value
        ↓
StreamBuilder receives update
        ↓
builder() function called with new snapshot
        ↓
Widget tree rebuilds with new data
        ↓
UI automatically updates
```

**Example (Weather Card):**

```dart
StreamBuilder<WeatherSnapshotData?>(
  stream: db.watchLatestWeather(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) {
      return LoadingIndicator();
    }
    
    final weather = snapshot.data;
    return WeatherCard(
      temperature: weather.temperature,
      condition: weather.condition,
    );
  },
)
```

**Characteristics:**
- No manual refresh needed
- Updates appear instantly
- No pull-to-refresh gesture
- Loading states handled automatically

---

### User-Initiated Data Changes

**Create Pattern:**

```
User fills form in modal sheet
        ↓
User taps "Save" button
        ↓
Form validation runs
        ↓
If valid: Database insert operation
        ↓
Drift emits stream update
        ↓
All watching widgets rebuild
        ↓
Modal closes
        ↓
Success snackbar shown
        ↓
New item appears in list automatically
```

**Update Pattern:**

```
User modifies existing data
        ↓
Database update operation
        ↓
Drift emits stream update
        ↓
Affected widgets rebuild
        ↓
UI reflects changes immediately
```

**Delete Pattern:**

Currently not widely implemented, but pattern would be:

```
User triggers delete action
        ↓
Confirmation dialog (if critical)
        ↓
Database delete operation
        ↓
Drift emits stream update
        ↓
Item disappears from list
        ↓
Snackbar confirmation
```

---

### Offline-First Pattern

**All Operations Are Local:**

```
User Action
        ↓
Local SQLite Database Operation
        ↓
Success/Failure (instant)
        ↓
UI Update
```

**No Network Dependency:**
- No loading spinners for network requests
- No timeout errors
- No connection status checks
- All data immediately available

**Optional Network Features:**
- Weather updates (via API)
- News feed images (network URLs)
- Both degrade gracefully if offline

---

## Search and Filter

### Search Patterns

#### Real-Time Search

**Implementation (People View):**

```
User types in search field
        ↓
onChange callback fires on each keystroke
        ↓
setState() updates search query
        ↓
Rebuild filters list
        ↓
Filtered results appear instantly
```

**Search Logic:**
```dart
final searchLower = searchQuery.toLowerCase();
final filtered = allUsers.where((user) {
  return user.fullName.toLowerCase().contains(searchLower) ||
         user.role.toLowerCase().contains(searchLower) ||
         user.location.toLowerCase().contains(searchLower);
}).toList();
```

**Characteristics:**
- Case-insensitive
- Partial matching
- Searches multiple fields
- No search button (instant)
- No minimum character requirement

---

#### Knowledge Base Search

**Full-Text Search:**

```
User types in search field
        ↓
Search query sent to database
        ↓
Database performs FTS (Full-Text Search)
        ↓
Results include title and content matches
        ↓
Results displayed with category info
```

**Special Feature:**
- Searches both title and markdown content
- Ranked by relevance
- Shows snippet of match

---

### Filter Patterns

#### Chip Filters

**Work Orders (Status Filter):**

```
┌──────┬──────┬──────────┬───────────┐
│ All  │ Open │ On Hold  │ Completed │
└──────┴──────┴──────────┴───────────┘
```

**Interaction:**
```
User taps filter chip
        ↓
setState() updates selected filter
        ↓
Rebuild fetches filtered data from database
        ↓
List updates with filtered items
        ↓
Selected chip shows primary blue background
```

**Multiple Selection:** No (single filter at a time)

---

#### Dropdown Filters

**Operations (Client Filter):**

```
User taps dropdown
        ↓
Dropdown menu opens
        ↓
User selects client
        ↓
onChanged callback fires
        ↓
setState() updates selected client
        ↓
Equipment list filters by client
        ↓
Rebuild shows filtered equipment
```

**Special Behavior:**
- "All Clients" option to clear filter
- Filtered items persist until changed

---

#### Dynamic Filters

**Equipment (Type Filters):**

```
App loads equipment data
        ↓
Extracts unique equipment types
        ↓
Generates filter chips dynamically
        ↓
User taps chip
        ↓
Filter applies
```

**Advantage:** Filters adapt to data in database

---

## Modal Interactions

### Bottom Sheet Lifecycle

**Open:**
```
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  builder: (context) => const ModalSheet(),
)
        ↓
Sheet slides up from bottom (animation)
        ↓
Barrier overlay appears (semi-transparent)
        ↓
Focus shifts to sheet
        ↓
Keyboard appears if text field focused
```

**Interact:**
```
User fills form/views content
        ↓
Can drag to resize
        ↓
Can scroll content if needed
        ↓
Form validation on input
```

**Close:**

**Method 1: Explicit Close**
```
User taps X button
        ↓
Navigator.pop(context) called
        ↓
Sheet slides down
        ↓
Barrier fades out
        ↓
Focus returns to main screen
```

**Method 2: Swipe Dismiss**
```
User swipes down
        ↓
Sheet follows finger
        ↓
Release past threshold
        ↓
Sheet dismisses with animation
```

**Method 3: Tap Barrier**
```
User taps dark overlay
        ↓
Sheet dismisses
```

**Method 4: Submit Form**
```
User taps "Save" button
        ↓
Form validation
        ↓
If valid: Database operation
        ↓
Navigator.pop(context)
        ↓
Sheet dismisses
        ↓
Snackbar shown with confirmation
```

---

### Dialog Interactions

**User Details Dialog:**

```
User taps profile circle (sidebar)
        ↓
showDialog() called
        ↓
Dialog fades in with barrier
        ↓
User views/edits details
        ↓
User closes dialog
        ↓
Dialog fades out
```

**Characteristics:**
- Center of screen
- Fixed size (not draggable)
- Must explicitly close (can't swipe)
- Tap barrier to dismiss

---

### Snackbar Notifications

**Success Pattern:**

```
Action completes successfully
        ↓
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('✓ Success message'),
    backgroundColor: Colors.green,
  ),
)
        ↓
Snackbar slides up from bottom
        ↓
Displays for 4 seconds (default)
        ↓
Auto-dismisses with slide down
```

**Error Pattern:**

```
Action fails
        ↓
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Error: [message]'),
    backgroundColor: Colors.red,
    duration: Duration(seconds: 5),
  ),
)
        ↓
Snackbar shows with red background
        ↓
Longer duration for errors (5 seconds)
        ↓
User can swipe to dismiss early
```

**Location:** Bottom of screen, above bottom navigation (mobile)

---

## Real-Time Updates

### Automatic UI Updates

**StreamBuilder Pattern:**

Every screen with dynamic data uses StreamBuilder to automatically update when database changes.

**Example Flow:**

```
User A creates work order
        ↓
Database INSERT
        ↓
Drift emits new stream value
        ↓
All StreamBuilder widgets watching work orders rebuild
        ↓
User A sees new work order in list
        ↓
User B (on different device, if multi-user) also sees update
        ↓
KPI tiles automatically increment counts
```

**No Manual Refresh Required:**
- No pull-to-refresh gestures
- No refresh buttons
- Data always current

---

### Background Updates

**Weather Update Manager:**

```
App starts
        ↓
WeatherUpdateManager.start() called
        ↓
Periodic timer starts (every X minutes)
        ↓
Timer fires
        ↓
Fetch weather from API
        ↓
Update database
        ↓
Stream emits new value
        ↓
Weather cards automatically update
```

**User Visibility:**
- Happens in background
- No loading indicators
- Seamless updates

---

## Error Handling

### Form Validation

**Pattern:**

```
User attempts to submit form
        ↓
Form.validate() called
        ↓
Each field validator runs
        ↓
If any fail: Error messages show below fields
        ↓
Form doesn't submit
        ↓
User corrects errors
        ↓
Validation passes
        ↓
Form submits
```

**Visual Feedback:**
- Error text appears below field (red)
- Field border turns red
- Submit button remains enabled (allows revalidation)

**Common Validations:**
- Required fields: "Please enter [field name]"
- Empty text: "Cannot be empty"
- Invalid format: "Invalid [format]"

---

### Network Errors

**Weather API Failure:**

```
Weather fetch fails (network/API error)
        ↓
Try-catch block catches error
        ↓
Error logged
        ↓
Weather display shows last known data
        ↓
Or shows placeholder/error message
```

**Graceful Degradation:**
- App continues to work
- Core features unaffected
- Optional features fail silently or show friendly message

---

### Database Errors

**Rare but Possible:**

```
Database operation fails
        ↓
Catch block executes
        ↓
Error logged to console
        ↓
Snackbar shown to user:
  "Error: [user-friendly message]"
        ↓
User can retry action
```

**User-Friendly Messages:**
- No stack traces shown
- Clear action to take
- Red snackbar for visibility

---

### Loading States

**StreamBuilder Handling:**

```dart
StreamBuilder<T>(
  stream: dataStream,
  builder: (context, snapshot) {
    // Loading state
    if (!snapshot.hasData) {
      return Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      );
    }
    
    // Error state
    if (snapshot.hasError) {
      return Center(
        child: Text(
          'Error: ${snapshot.error}',
          style: TextStyle(color: AppColors.error),
        ),
      );
    }
    
    // Success state
    final data = snapshot.data!;
    return DataDisplay(data: data);
  },
)
```

**Visual:**
- Primary blue circular progress indicator
- Centered on screen
- Replaces content area

---

## Interaction Checklist

### Every Interactive Element Should:

- [ ] Provide visual feedback (ripple, color change, etc.)
- [ ] Have appropriate touch target size (minimum 48x48px)
- [ ] Handle loading states
- [ ] Handle error states
- [ ] Show success confirmation
- [ ] Be keyboard accessible (if applicable)
- [ ] Have clear purpose/label
- [ ] Disable during processing (prevent double-tap)

### Every Form Should:

- [ ] Validate input
- [ ] Show error messages
- [ ] Disable submit during processing
- [ ] Show loading indicator on submit
- [ ] Close on success
- [ ] Show confirmation snackbar
- [ ] Clear form after submit (if reusable)
- [ ] Handle validation errors gracefully

### Every Navigation Action Should:

- [ ] Update visual active state
- [ ] Preserve context when needed
- [ ] Allow back navigation
- [ ] Handle deep linking (if applicable)
- [ ] Maintain scroll position (when returning)

---

**End of Interaction Guide**
