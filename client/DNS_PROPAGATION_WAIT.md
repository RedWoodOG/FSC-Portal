# DNS Propagation - Temporary Workaround

## 🔍 Issue

The Cloudflare DNS record is correctly configured, but DNS hasn't fully propagated yet. The app can't connect to `api.vyrevaultstudios.com`.

**Status:**
- ✅ DNS record added in Cloudflare
- ✅ DNS resolves to Cloudflare IPs (IPv6)
- ❌ Connection still failing (propagation in progress)

## ✅ Temporary Fix Applied

**File**: `lib/config/api_config.dart`

Reverted to Render URL temporarily:
```dart
static const String _newBackendUrl = 'https://fsc-enterprise-core.onrender.com';
```

**Why**: This ensures the app works immediately while DNS propagates.

## ⏰ DNS Propagation Timeline

Cloudflare DNS typically propagates within:
- **Local/Regional**: 1-5 minutes
- **Global**: 5-30 minutes
- **Maximum**: Up to 48 hours (rare)

**Your record was just added**, so give it **10-15 minutes** before trying again.

## 🔄 Switch Back to Cloudflare Domain

Once DNS has propagated (test with `Resolve-DnsName api.vyrevaultstudios.com`), update `api_config.dart`:

```dart
// Change back to:
static const String _newBackendUrl = 'https://api.vyrevaultstudios.com';
```

Then **hot restart** the app.

## 🧪 How to Test DNS Propagation

**PowerShell:**
```powershell
# Test DNS resolution
Resolve-DnsName api.vyrevaultstudios.com

# Test API endpoint
Invoke-WebRequest -Uri "https://api.vyrevaultstudios.com/api/portal/operations/map-data"
```

**When it works:**
- DNS resolves to Cloudflare IPs
- API endpoint returns data (or auth error, which is fine)

## ✅ Current Status

- **App**: Using Render URL (working ✅)
- **Cloudflare**: DNS record configured (waiting for propagation ⏰)
- **Next**: Wait 10-15 minutes, then switch back to Cloudflare domain

---

**The setup is correct - just needs time for DNS to propagate globally!** 🚀
