# Quick Start - Operations Integration

## ✅ What's Ready

- ✅ Backend API deployed on Render
- ✅ API Service methods added
- ✅ Widgets created and integrated
- ✅ All existing functionality preserved

## 🚀 Quick Integration (3 Steps)

### Step 1: Add Dependencies

The `google_maps_flutter` dependency has been added to `pubspec.yaml`. Run:

```bash
cd H:\FSC_Portal\client
flutter pub get
```

### Step 2: Add Widget to Operations Screen

Open `lib/modules/operations/operations_screen.dart` and add:

```dart
import '../../widgets/operations_map_widget.dart';
import '../../widgets/operations_clients_list_widget.dart';

// Then in your build method, add as a tab or section:
TabBarView(
  children: [
    OperationsMapWidget(), // Map view
    OperationsClientsListWidget(), // List view
  ],
)
```

### Step 3: Test

Run the app and navigate to Operations. You should see:
- Map view with all client locations
- List view with hierarchical client → locations structure

## 📋 API Configuration

The widgets automatically use your Render backend URL from `ApiConfig.newBackendUrl`.

**Current setting**: `https://fsc-enterprise-core.onrender.com`

If using Cloudflare, update `lib/config/api_config.dart`:
```dart
static const String _newBackendUrl = 'https://your-cloudflare-url.com';
```

## 🎯 Features Available

### Map Widget
- ✅ Shows all client locations on map
- ✅ Color-coded markers (blue = operational, red = maintenance)
- ✅ Tap marker for location details
- ✅ Navigate button opens Google Maps
- ✅ Filter by region or client

### List Widget
- ✅ Hierarchical view (Client → Locations)
- ✅ Expandable client cards
- ✅ Location details with equipment counts
- ✅ Status indicators
- ✅ Filter by region, client, or status

## 🔧 Troubleshooting

**Map not showing:**
- Check Google Maps API key in `android/app/src/main/AndroidManifest.xml`
- See `fsc-enterprise-core/FLUTTER_MAPS_SETUP.md` for details

**Empty data:**
- Verify backend is running on Render
- Check `ApiConfig.newBackendUrl` is correct
- Ensure clients/locations are imported in database

**API errors:**
- Check `ApiService.loadToken()` is called
- Verify Render deployment is live
- Check network connectivity

---

**Ready to use!** Start with one widget, test, then add the other. 🎉
