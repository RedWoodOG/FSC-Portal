# Offline-First Architecture - Local Database Setup

## 🎯 Goal

Move from remote database (Render/PostgreSQL) to **local SQLite database** for:
- ✅ **Offline operation** - Works without internet
- ✅ **Fast queries** - Local database is instant
- ✅ **No server dependency** - Core features work standalone
- ✅ **Embedded maps** - Can cache map data locally

## ✅ What's Been Created

### 1. Local Database (`lib/database/app_database.dart`)
- **Drift** (type-safe SQLite ORM)
- Tables: `Clients`, `Locations`, `Equipment`
- Matches Prisma schema structure
- Stored in app documents directory: `portal.db`

### 2. Database Service (`lib/database/database_service.dart`)
- Wrapper for easy access
- Handles initialization
- Provides convenience methods

### 3. Data Import Service (`lib/services/data_import_service.dart`)
- Imports from API (one-time sync)
- Can import from JSON files
- Converts API format to local format

### 4. Updated Locations Screen (`lib/modules/locations/locations_screen_local.dart`)
- Uses local database instead of API
- Works completely offline
- PM routing algorithm unchanged

## 📋 Setup Steps

### Step 1: Install Dependencies

```bash
cd H:\FSC_Portal\client
flutter pub get
```

### Step 2: Generate Database Code

Drift requires code generation:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

This creates `app_database.g.dart` with generated code.

### Step 3: Database Already Initialized

The `main.dart` has been updated to initialize the database on app start.

### Step 4: Import Initial Data

You have two options:

**Option A: Import from API (One-time)**
```dart
// In your app, after login or on first launch
final importService = DataImportService(
  Provider.of<DatabaseService>(context, listen: false),
  apiService: ApiService(),
);
await importService.importLocationsFromAPI();
await importService.importClientsFromAPI();
```

**Option B: Import from JSON File**
- Create JSON file with location data
- Use `importFromJsonFile()` method

## 🔄 Migration Path

1. **Current State**: App tries to connect to Render API
2. **New State**: App uses local SQLite database
3. **Future**: Add sync mechanism if needed (optional)

## 📦 Dependencies Added

- `drift: ^2.14.1` - SQLite ORM
- `sqlite3_flutter_libs: ^0.5.18` - SQLite native libs
- `path_provider: ^2.1.1` - App documents directory
- `path: ^1.8.3` - Path manipulation
- `drift_dev: ^2.14.1` - Code generation (dev)
- `build_runner: ^2.4.7` - Code generation tool (dev)

## 🗺️ Maps Offline Support

Google Maps can work offline with:
1. **Cached tiles** - Maps SDK caches tiles automatically
2. **Local data** - All location data is in local DB
3. **No API calls** - Map renders from cached data

For full offline maps, consider:
- `flutter_map` with offline tile provider
- Or pre-download map tiles for your region

## 🚀 Benefits

- ✅ **No Render dependency** - Works without backend
- ✅ **Fast** - Local queries are instant
- ✅ **Offline** - Works without internet
- ✅ **Type-safe** - Drift provides compile-time safety
- ✅ **Similar to Prisma** - Easy migration from backend patterns

## 📋 Next Steps

1. ✅ Run `flutter pub get`
2. ✅ Run `flutter pub run build_runner build`
3. ✅ Test Locations screen (will be empty until data imported)
4. ✅ Add data import on first launch or via settings
5. ✅ Test PM routing with local data

---

**The app is now offline-first!** 🚀
