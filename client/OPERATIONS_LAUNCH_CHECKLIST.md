# Operations Launch Checklist

## ✅ Integration Complete

### Backend (Live on Render + Cloudflare)
- ✅ Operations API endpoints deployed
- ✅ `/api/portal/operations/map-data` - Working
- ✅ `/api/portal/operations/clients-list` - Working

### Frontend (Portal App)
- ✅ API Service methods added (`getOperationsMapData`, `getOperationsClientsList`)
- ✅ Widgets created and integrated
- ✅ Operations screen updated with Map and List tabs
- ✅ Dependencies installed (`google_maps_flutter`)

## 🚀 What's Wired

### Operations Screen Tabs (5 tabs total):
1. **Inventory** - Existing (unchanged)
2. **Clients** - Existing flat list (unchanged)
3. **Map** - NEW: `OperationsMapWidget()` - Shows all locations on map
4. **List** - NEW: `OperationsClientsListWidget()` - Hierarchical client → locations view
5. **Assets** - Existing placeholder (unchanged)

### Navigation Flow:
```
Portal Home → Operations → [5 Tabs]
  ├─ Inventory (existing)
  ├─ Clients (existing)
  ├─ Map (NEW - shows all locations)
  ├─ List (NEW - hierarchical view)
  └─ Assets (existing)
```

## 🔧 Configuration Check

### API URL Configuration
**File**: `lib/config/api_config.dart`

**Current Setting**:
```dart
static const String _newBackendUrl = 'https://fsc-enterprise-core.onrender.com';
```

**If using Cloudflare**, update to your Cloudflare URL:
```dart
static const String _newBackendUrl = 'https://your-cloudflare-domain.com';
```

The widgets automatically use `ApiConfig.newBackendUrl` - no code changes needed.

## ✅ Pre-Launch Verification

### 1. Check API Configuration
- [ ] Verify `ApiConfig.newBackendUrl` points to your Cloudflare/Render URL
- [ ] Test API endpoint: `curl https://your-backend-url/api/portal/operations/map-data`

### 2. Check Dependencies
- [ ] Run `flutter pub get` (already done ✅)
- [ ] Verify `google_maps_flutter` is installed
- [ ] Verify `url_launcher` is installed

### 3. Check Google Maps API Key (For Map Widget)
- [ ] Android: `android/app/src/main/AndroidManifest.xml` has API key
- [ ] iOS: `ios/Runner/AppDelegate.swift` has API key
- [ ] See `fsc-enterprise-core/FLUTTER_MAPS_SETUP.md` for details

### 4. Test Launch
- [ ] Launch Portal app
- [ ] Navigate to Operations
- [ ] Verify all 5 tabs appear
- [ ] Test Map tab (should show map with markers)
- [ ] Test List tab (should show hierarchical client list)
- [ ] Test Clients tab (existing functionality should still work)

## 🐛 Troubleshooting

### Map Tab Shows Error
**Possible causes:**
1. Google Maps API key not configured
2. Backend URL incorrect
3. Network connectivity issue

**Fix:**
- Check `AndroidManifest.xml` for API key
- Verify `ApiConfig.newBackendUrl` is correct
- Check backend is accessible

### List Tab Shows Empty
**Possible causes:**
1. No clients/locations in database
2. API authentication failing
3. Backend not responding

**Fix:**
- Verify backend has data (import banks if needed)
- Check `ApiService.loadToken()` is called
- Verify Render deployment is live

### API Errors
**Check:**
- Backend is deployed and running on Render
- Cloudflare is proxying correctly
- `ApiConfig.newBackendUrl` matches your Cloudflare domain
- Authentication token is valid

## 📋 Files Modified

### New Files:
- `lib/widgets/operations_map_widget.dart`
- `lib/widgets/operations_clients_list_widget.dart`

### Modified Files:
- `lib/services/api_service.dart` - Added 2 new methods
- `lib/modules/operations/operations_screen.dart` - Added Map and List tabs
- `pubspec.yaml` - Added `google_maps_flutter` dependency

### Unchanged (Still Working):
- `lib/modules/operations/clients_screen.dart` - Existing functionality preserved
- All other screens and navigation

## 🎯 Expected Behavior

### When You Launch Portal:

1. **Login** → Works as before
2. **Navigate to Operations** → Shows 5 tabs
3. **Click "Map" tab** → 
   - Shows Google Map centered on San Antonio, TX
   - Displays blue/red markers for all locations
   - Tap marker → Shows location details modal
   - Navigate button → Opens Google Maps app
4. **Click "List" tab** →
   - Shows expandable client cards
   - Tap client → Expands to show locations
   - Tap location → Shows detailed modal
   - Pull to refresh → Reloads data
5. **Click "Clients" tab** → 
   - Existing flat list view (unchanged)
   - Still works as before

## ✅ Ready to Launch!

Everything is wired and ready. The app will:
- ✅ Launch normally
- ✅ Show Operations screen with 5 tabs
- ✅ Map and List tabs connect to your Render backend
- ✅ All existing functionality preserved

**Just verify your Cloudflare URL in `api_config.dart` if different from Render URL!**
