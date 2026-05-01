# Portal Backend Connection

**Portal is now wired to the new backend.**

## What Was Done

### 1. API Service Updated ✅

**File**: `client/lib/services/api_service.dart`

**Added Methods:**
- **Locations**: `getLocations()`, `getLocation()`, `getLocationSummary()`, `getEquipmentByLocation()`, `getWorkOrdersByLocation()`, `getLocationServiceHistory()`, `getLocationContacts()`
- **Equipment**: `getEquipment()`, `getEquipmentById()`, `getEquipmentBySerial()` (critical for global search), `searchEquipment()`
- **Sync**: `syncPull()`, `syncPush()` (for offline-first operations)

**Base URL**: `http://localhost:3000` (matches new backend)

**API Prefix**: `/api/portal` (matches new backend routes)

### 2. Clients Screen Updated ✅

**File**: `client/lib/modules/operations/clients_screen.dart`

**Now:**
- Calls `getLocations()` API
- Displays real location data from backend
- Shows location status with color coding
- Shows equipment counts
- Error handling and loading states

**Status Colors:**
- Red - Active or overdue work order
- Yellow - Upcoming PM or low urgency
- Blue - RBFCU specific
- Cyan - Work in progress
- Green - Low priority

---

## How to Test

### 1. Start Backend

```bash
cd c:\Users\jwhit\local-cursor\fsc-enterprise-core
npm run dev
```

Backend runs on `http://localhost:3000`

### 2. Run Portal

```bash
cd H:\FSC_Portal\client
flutter run
```

### 3. Navigate to Clients Screen

The Clients screen should now:
- Show loading indicator
- Fetch locations from `/api/portal/locations`
- Display location list with status colors
- Show error message if backend is down

---

## What's Connected

✅ **Clients Screen** → Calls `getLocations()` → Shows all locations

⏳ **Other Screens** → Still need to be connected:
- Work Orders screen (needs Work Order Service)
- Inventory screen (needs Inventory Service)
- Equipment views (needs Equipment Service integration)

---

## Next Steps

1. **Create Location Details Screen** - Full location view with tabs
2. **Add Equipment Views** - Equipment list and detail screens
3. **Wire Work Orders** - When Work Order Service is built
4. **Add Global Search** - Serial number search UI
5. **Implement Sync** - Offline-first Drift database integration

---

**Portal frontend is now connected to the new backend. Location data will display when backend is running.**
