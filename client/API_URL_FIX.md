# API URL Fix - Connection Issue Resolved

## 🔍 Issue Found

The app was trying to connect to `localhost:3000` in debug mode, but your backend is deployed on Render (wrapped by Cloudflare).

**Error seen:**
```
SocketException: The remote computer refused the network connection
uri = http://localhost:3000/api/portal/operations/map-data
```

## ✅ Fix Applied

**File**: `lib/config/api_config.dart`

Changed:
```dart
static bool _useProductionInDebug = false;  // ❌ Was using localhost
```

To:
```dart
static bool _useProductionInDebug = true;   // ✅ Now uses Render URL
```

## 🚀 What This Means

Now the app will use:
- **Production URL**: `https://fsc-enterprise-core.onrender.com`
- **Instead of**: `http://localhost:3000`

## 📋 Next Steps

### 1. Hot Restart the App

**Important**: You need to **hot restart** (not just hot reload) for this change to take effect:

- **VS Code**: Press `Ctrl+Shift+F5` or click the restart button
- **Android Studio**: Click the restart button (circular arrow)
- **Command Line**: Stop and restart `flutter run`

### 2. If Using Cloudflare Custom Domain

If your backend is behind a Cloudflare custom domain (not the Render URL), update line 18 in `api_config.dart`:

```dart
// Change from:
static const String _newBackendUrl = 'https://fsc-enterprise-core.onrender.com';

// To your Cloudflare domain:
static const String _newBackendUrl = 'https://your-cloudflare-domain.com';
```

**Note**: If Cloudflare is just proxying the Render URL, the Render URL should still work fine.

### 3. Test After Restart

After hot restart:
1. Navigate to Operations
2. Click "Map" tab → Should connect to Render backend
3. Click "List" tab → Should connect to Render backend
4. Click "Clients" tab → Should connect to Render backend

## ✅ Expected Result

After hot restart, all tabs should:
- ✅ Connect to `https://fsc-enterprise-core.onrender.com`
- ✅ Load data from your Render backend
- ✅ No more "localhost refused connection" errors

## 🔧 If Still Not Working

1. **Verify Render backend is accessible:**
   ```bash
   curl https://fsc-enterprise-core.onrender.com/api/portal/operations/map-data
   ```

2. **Check Cloudflare domain** (if using custom domain):
   - Update `_newBackendUrl` in `api_config.dart`
   - Hot restart app

3. **Verify authentication:**
   - Make sure you're logged in
   - Check `ApiService.loadToken()` is called

---

**Fix applied!** Hot restart the app and it should connect to Render. 🚀
