# Dashboard Mode Memory System

## Overview
The `DashboardModeProvider` gives the system **consciousness** of workflow changes by tracking mode transitions and generating contextual narratives.

## Key Features

### 1. **Mode Transition Tracking**
Every time the dashboard switches modes (Quiet ↔ Hybrid ↔ Surge), the system records:
- Previous mode
- New mode  
- Timestamp
- Ticket count at transition
- Optional reason for change

### 2. **Contextual Narratives**
The system generates intelligent messages based on the transition:

**Entering Quiet Mode:**
- From Hybrid: *"Entering quiet mode. 2 tickets resolved. Time to prepare and restock."*
- From Surge: *"Surge complete. You cleared 8 tickets. Well done."*

**Entering Hybrid Mode:**
- From Quiet: *"Transitioning to active mode. 5 tickets assigned."*
- From Surge: *"Workload stabilizing. 7 active tickets remaining."*

**Entering Surge Mode:**
- *"Surge mode activated. 15 active tickets. Dispatch recommends reviewing Route Optimizer."*
- *"Surge mode activated. 12 active tickets. Prioritize high-urgency calls first."*

### 3. **Visual Transition Banner**
When a mode change occurs, a colored banner appears for 10 seconds showing:
- Mode-appropriate icon (✓ for quiet, ↗ for hybrid, ⚠ for surge)
- Contextual narrative message
- Color-coded border (Green/Purple/Red)
- Dismiss button

### 4. **Transition History**
The provider maintains a rolling history of the last 20 transitions, enabling:
- Daily statistics tracking
- Pattern analysis
- Mode duration calculations

## Usage

### Basic Integration

```dart
// In your widget
final modeProvider = Provider.of<DashboardModeProvider>(context);

// Update ticket count (triggers mode calculation)
modeProvider.updateTicketCount(5, reason: 'New assignments from dispatch');

// Check current mode
final mode = modeProvider.currentMode; // DashboardMode.hybrid

// Get transition narrative if recent
final narrative = modeProvider.transitionNarrative;
if (narrative != null) {
  // Display banner with narrative
}
```

### Getting Mode Statistics

```dart
final stats = modeProvider.getModeStats();

print(stats['surgeEventsToday']);  // How many surge periods today
print(stats['totalSurgeTime']);     // Duration spent in surge mode
print(stats['transitionsToday']);   // Total mode changes
print(stats['currentStreak']);      // e.g., "Quiet for 2h 15m"
```

### Contextual Suggestions

```dart
final suggestions = modeProvider.getContextualSuggestions();
// Returns mode-appropriate action suggestions:
// Quiet: ["Review inventory levels...", "Complete training..."]
// Hybrid: ["Confirm parts availability...", "Review route..."]
// Surge: ["Enable Route Optimizer...", "Check dispatch..."]
```

## Implementation Details

### Mode Calculation Logic
```dart
if (ticketCount < 3) return DashboardMode.quiet;
if (ticketCount < 10) return DashboardMode.hybrid;
return DashboardMode.surge;
```

### Transition Message Duration
Messages display for **10 seconds** after a mode change, then automatically hide. Users can manually dismiss by clicking the X button.

### Memory Retention
- Keeps last **20 transitions** in memory
- Cleared on app restart
- Could be persisted to storage for longer-term analytics

## Example Scenarios

### Scenario 1: Morning Ramp-Up
```
08:00 - Start day with 1 ticket (Quiet Mode)
       → "Quiet mode active. Stay ready."

09:15 - 4 tickets assigned (Hybrid Mode)
       → "Transitioning to active mode. 4 tickets assigned."

11:30 - 12 tickets now active (Surge Mode)
       → "Surge mode activated. 12 active tickets. 
          Prioritize high-urgency calls first."
```

### Scenario 2: End of Day Wind-Down
```
15:00 - Completing surge with 14 tickets (Surge Mode)

16:30 - Down to 6 tickets (Hybrid Mode)
       → "Workload stabilizing. 6 active tickets remaining."

17:45 - Last tickets closed, 1 remaining (Quiet Mode)
       → "Entering quiet mode. 5 tickets resolved. 
          Time to prepare and restock."
```

### Scenario 3: Emergency Surge
```
Normal day with 4 tickets (Hybrid Mode)

Alert: 10 new urgent tickets assigned (Surge Mode)
       → "Surge mode activated. 14 active tickets. 
          Dispatch recommends reviewing Route Optimizer."
```

## Testing the System

Use the built-in simulator (science flask icon) in the dashboard header:

1. **Set 1 ticket (Quiet)** - Test quiet mode transition
2. **Set 5 tickets (Hybrid)** - Test hybrid activation  
3. **Set 15 tickets (Surge)** - Test surge mode alert
4. **Resolve to 2 (Quiet)** - Test completion narrative

Watch the transition banner appear with contextual messaging.

## Future Enhancements

### Potential Additions:
- **Persistence**: Save transition history to local storage
- **Analytics Dashboard**: Visualize daily/weekly patterns
- **Predictions**: "Based on patterns, surge expected at 2 PM"
- **Team Coordination**: "3 other techs entered surge mode in your region"
- **Performance Metrics**: "You resolved 8 tickets in 2.5 hours (above average)"
- **Celebration Messages**: "100th ticket completed this month! 🎉"

### Smart Narratives:
- Weather integration: "Surge mode + rain detected. Drive carefully."
- Time-based: "Surge mode at 4:45 PM. Manage overtime expectations."
- Historical: "This is your 3rd surge today. Great work managing load."

## Design Philosophy

> **"The system doesn't just react to state changes—it remembers them, learns from them, and communicates about them with personality and context."**

This creates the feeling that the portal **understands your workday** rather than just displaying data.

The technician isn't managing a static dashboard—they're working with a system that's **aware of the flow of their work** and adapts its communication accordingly.
