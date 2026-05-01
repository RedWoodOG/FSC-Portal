# Cloudflare API Subdomain Setup

## 🎯 Goal

Set up a Cloudflare subdomain (e.g., `api.vyrevaultstudios.com`) to point to your Render backend, so the Portal app can use your branded domain instead of the Render URL.

## 📋 Current Setup

**Domain**: `vyrevaultstudios.com` (Active on Cloudflare)  
**Backend**: `fsc-enterprise-core.onrender.com` (on Render)  
**Current API Config**: Uses Render URL directly

## ✅ Step 1: Add DNS Record in Cloudflare

1. Go to [Cloudflare Dashboard](https://dash.cloudflare.com)
2. Select `vyrevaultstudios.com` zone
3. Navigate to **DNS** → **Records**
4. Click **"Add record"**

**Configure the record:**
- **Type**: `CNAME`
- **Name**: `api` (or `portal-api`, `backend`, etc.)
- **Target**: `fsc-enterprise-core.onrender.com`
- **Proxy status**: ✅ **Proxied** (orange cloud icon)
- **TTL**: `Auto`

**Result**: `api.vyrevaultstudios.com` → `fsc-enterprise-core.onrender.com` (proxied)

### Alternative Subdomain Names

You can use any subdomain:
- `api.vyrevaultstudios.com` (recommended)
- `portal-api.vyrevaultstudios.com`
- `backend.vyrevaultstudios.com`
- `fsc-api.vyrevaultstudios.com`

## ✅ Step 2: Update Flutter API Config

**File**: `H:\FSC_Portal\client\lib\config\api_config.dart`

Update line 18:

```dart
// Change from:
static const String _newBackendUrl = 'https://fsc-enterprise-core.onrender.com';

// To your Cloudflare subdomain:
static const String _newBackendUrl = 'https://api.vyrevaultstudios.com';
```

**Full updated section:**
```dart
// fsc-enterprise-core URL (new backend, used for /api/portal/* endpoints)
// Using Cloudflare subdomain for branded domain
static const String _newBackendUrl = 'https://api.vyrevaultstudios.com';
```

## ✅ Step 3: Verify DNS Propagation

Wait 1-2 minutes for DNS to propagate, then test:

```bash
# Test DNS resolution
nslookup api.vyrevaultstudios.com

# Test API endpoint
curl https://api.vyrevaultstudios.com/api/portal/operations/map-data
```

**Expected**: Should return JSON data (or authentication error if not logged in, which is fine - means DNS is working).

## ✅ Step 4: Hot Restart Flutter App

After updating `api_config.dart`:

1. **Hot restart** the app (not just hot reload)
   - VS Code: `Ctrl+Shift+F5`
   - Or stop/restart `flutter run`

2. **Test in app:**
   - Navigate to Operations → Map tab
   - Navigate to Operations → List tab
   - Should connect to `api.vyrevaultstudios.com`

## 🔒 SSL/TLS (Automatic)

Cloudflare automatically provides SSL/TLS for proxied subdomains:
- ✅ HTTPS enabled automatically
- ✅ SSL certificate auto-renewed
- ✅ No additional configuration needed

## 🎯 Benefits of Using Cloudflare Subdomain

1. **Branded Domain**: Professional API URL (`api.vyrevaultstudios.com`)
2. **DDoS Protection**: Cloudflare's built-in protection
3. **CDN Caching**: Faster response times (if configured)
4. **SSL/TLS**: Automatic HTTPS
5. **Analytics**: Cloudflare provides API analytics
6. **Flexibility**: Easy to switch backend without changing app config

## 🐛 Troubleshooting

### DNS Not Resolving

**Wait**: DNS can take up to 5 minutes to propagate globally.

**Check in Cloudflare:**
- Verify record is **Proxied** (orange cloud)
- Verify target is correct: `fsc-enterprise-core.onrender.com`

**Test locally:**
```bash
# Windows PowerShell
Resolve-DnsName api.vyrevaultstudios.com

# Should return Cloudflare IPs (not Render IPs)
```

### SSL Certificate Error

**If you see SSL errors:**
- Cloudflare SSL should be automatic
- Check Cloudflare dashboard → SSL/TLS → Overview
- Ensure SSL/TLS encryption mode is "Full" or "Full (strict)"

### API Returns 502/503

**Possible causes:**
1. Render backend is down
2. Cloudflare can't reach Render
3. Render service needs to be restarted

**Fix:**
- Check Render dashboard → Service status
- Verify Render service is running
- Check Render logs for errors

### Still Using Render URL

**If app still connects to Render URL:**
- Verify `api_config.dart` was saved
- **Hot restart** app (not hot reload)
- Check `_useProductionInDebug = true` is set

## 📋 Quick Checklist

- [ ] DNS record added in Cloudflare (`api` → `fsc-enterprise-core.onrender.com`, Proxied)
- [ ] `api_config.dart` updated with Cloudflare subdomain
- [ ] DNS propagated (tested with `curl`)
- [ ] Flutter app hot restarted
- [ ] Tested Map tab → connects to Cloudflare domain
- [ ] Tested List tab → connects to Cloudflare domain

## ✅ After Setup

Your Portal app will now use:
- **API URL**: `https://api.vyrevaultstudios.com`
- **Backend**: Still `fsc-enterprise-core.onrender.com` (but proxied through Cloudflare)
- **SSL**: Automatic via Cloudflare
- **Protection**: Cloudflare DDoS protection active

---

**Ready to set up?** Add the DNS record in Cloudflare, update `api_config.dart`, and hot restart the app! 🚀
