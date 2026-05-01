# Drift Database Setup - Critical Steps

## ⚠️ IMPORTANT: Code Generation Required

Drift uses code generation. **You MUST run build_runner** before the app will compile.

## 📋 Setup Steps (In Order)

### Step 1: Install Dependencies
```bash
cd H:\FSC_Portal\client
flutter pub get
```

### Step 2: Generate Drift Code (CRITICAL!)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

**This creates `lib/database/app_database.g.dart`** with:
- `LocationData` class
- `ClientData` class  
- `EquipmentData` class
- `LocationsCompanion` class
- `ClientsCompanion` class
- `EquipmentCompanion` class
- `_$AppDatabase` class

**Without this file, compilation will fail!**

### Step 3: Hot Restart App
After code generation, hot restart the app (not just hot reload).

## 🔍 What Drift Generates

For each table (e.g., `Locations`), Drift generates:

1. **Data Class**: `LocationData` - Used for reading/querying
2. **Companion Class**: `LocationsCompanion` - Used for inserting/updating

**Example:**
```dart
// Reading (returns Data class)
Future<List<LocationData>> getAllLocations() => select(locations).get();

// Inserting (uses Companion)
await db.insertLocation(LocationsCompanion(
  id: Value('123'),
  clientName: Value('Bank Name'),
  // ...
));
```

## ✅ After Code Generation

The app will:
- ✅ Compile successfully
- ✅ Create local SQLite database on first run
- ✅ Work completely offline
- ✅ Locations screen will load from local DB

## 🐛 If Build Fails

**Error**: "A value of type 'Future<List<Equipment>>' can't be returned..."

**Fix**: You haven't run code generation yet. Run:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

**Run build_runner NOW - it's required!** 🚀
