# Adaptive Home Dashboard

## Overview
The Home Dashboard now automatically adapts to the field technician's workload, switching between three distinct modes based on active ticket count.

## Dashboard Modes

### 🟢 Quiet Mode (0-2 tickets)
**Purpose:** Keep technicians prepared, informed, and engaged during slow periods.

**Content Displayed:**
- Territory coverage and weather conditions
- Inventory health (Parts Stock, Tools, Vehicle status)
- Low stock alerts and restock suggestions
- Preventative maintenance opportunities
- Training modules and company announcements
- Expense report reminders
- Recent completed work

**Message:** "Staying ready and informed"

---

### 🟣 Hybrid Mode (3-9 tickets)
**Purpose:** Balanced view of active work with contextual support.

**Content Displayed:**
- Today's scheduled service calls with priorities
- Required parts/inventory confirmation
- Drive time estimates
- Recent completed calls for reference

**Message:** "Managing your workload"

---

### 🔴 Surge Mode (10+ tickets)
**Purpose:** Transform into a command center for high-volume operations.

**Content Displayed:**
- High-volume alert banners
- Urgent vs. Total Active ticket counts
- Estimated total time for all tickets
- Priority-sorted ticket queue with distances
- Route optimization button
- Dispatch coordination messages
- Critical inventory warnings
- "View All" expansion option

**Message:** "Command center active"

---

## Testing Different Modes

To test the dashboard modes, modify line 16 in `home_screen.dart`:

```dart
int get _activeTicketCount => 2; // Change this value to test modes
```

**Test Values:**
- `0-2` = Quiet Mode
- `3-9` = Hybrid Mode  
- `10+` = Surge Mode

---

## Implementation Notes

### Mode Detection Logic
```dart
DashboardMode get _currentMode {
  if (_activeTicketCount < 3) return DashboardMode.quiet;
  if (_activeTicketCount < 10) return DashboardMode.hybrid;
  return DashboardMode.surge;
}
```

### Production Integration
In production, replace the simulated `_activeTicketCount` getter with a real-time data source:
- Connect to work order provider/service
- Pull from backend API
- Update based on ticket state changes
- Trigger rebuilds when count changes

### Visual Indicators
Each mode displays a colored badge next to the "Home" title:
- 🟢 Green = "Quiet Day"
- 🟣 Purple = "Active"
- 🔴 Red = "Surge Mode"

### Stats Row Adaptation
The dashboard stats automatically adjust:
- **Quiet/Hybrid:** Open Calls, Completed Today, This Week
- **Surge:** Urgent Tickets, Total Active, Estimated Time

---

## Design Philosophy

> "Field tech reality is cyclical, not constant."

The dashboard reflects the natural rhythm of field work:
- **Quiet days** don't feel empty—they show preparedness and opportunity
- **Busy days** don't overwhelm—they provide structure and prioritization
- **Surge periods** activate command center features for crisis management

This adaptive approach ensures the portal feels relevant and useful regardless of workload intensity.

---

## Future Enhancements

Potential additions for each mode:

**Quiet Mode:**
- Interactive territory map
- Weather radar integration
- Vehicle maintenance scheduling
- Certification expiration tracking
- Peer performance comparisons

**Hybrid Mode:**
- Real-time traffic updates
- Customer communication shortcuts
- Quick parts lookup
- Photo upload for documentation

**Surge Mode:**
- Live route optimization with maps
- Team coordination chat
- Priority override requests
- SLA violation warnings
- Manager escalation buttons
