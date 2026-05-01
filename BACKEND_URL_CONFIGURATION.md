# Backend URL Configuration

## Current Setup

The Portal app is configured to work with:
- **Local Development**: `http://localhost:3000` (when running `npm run dev` locally)
- **Production**: Render.com + Cloudflare (requires your Render URL)

## Configuration File

**File**: `client/lib/config/api_config.dart`

This file manages the API base URL for different environments.

### Update Production URL

**IMPORTANT**: You need to update the production URL in `api_config.dart`:

```dart
static const String _productionBaseUrl = 'https://your-render-app.onrender.com';
```

Replace `your-render-app.onrender.com` with your actual Render.com URL.

### How It Works

1. **Debug Mode** (local development):
   - Uses `http://localhost:3000` by default
   - Connects to your local backend running `npm run dev`

2. **Release Mode** (production build):
   - Uses the Render.com production URL
   - Routes through Cloudflare if configured

3. **Override for Testing**:
   - You can force production URL in debug mode:
   ```dart
   ApiConfig.useProductionInDebug(true);
   ```

## Cloudflare Considerations

If your Render.com app is behind Cloudflare:

1. **HTTPS**: Make sure your Render URL uses `https://` (Cloudflare provides SSL)
2. **CORS**: Ensure Cloudflare/Render allows requests from your Portal app origin
3. **Rate Limiting**: Cloudflare may have rate limits (check your Cloudflare dashboard)
4. **Caching**: Cloudflare may cache API responses (consider disabling cache for `/api/*` routes)

## Testing

### Test Local Connection

```bash
# Terminal 1: Start backend
cd c:\Users\jwhit\local-cursor\fsc-enterprise-core
npm run dev

# Terminal 2: Run Portal in debug mode (will use localhost:3000)
cd H:\FSC_Portal\client
flutter run
```

### Test Production Connection

1. Update `_productionBaseUrl` in `api_config.dart` with your Render URL
2. Run Portal in release mode:
   ```bash
   flutter run --release
   ```

Or override in debug:
```dart
// In main.dart or wherever you initialize
ApiConfig.useProductionInDebug(true);
```

## Environment Variables Alternative

If you prefer using environment variables (requires `flutter_dotenv` package):

1. Install: `flutter pub add flutter_dotenv`
2. Create `.env` file:
   ```
   API_BASE_URL=http://localhost:3000
   API_BASE_URL_PROD=https://your-app.onrender.com
   ```
3. Load in `main.dart`:
   ```dart
   await dotenv.load(fileName: ".env");
   ```
4. Use in `ApiConfig`:
   ```dart
   static String get baseUrl => dotenv.env['API_BASE_URL'] ?? _localBaseUrl;
   ```

## Next Steps

1. **Get your Render URL**: Find it in your Render.com dashboard
2. **Update `api_config.dart`**: Replace the placeholder URL
3. **Test connection**: Verify Portal can reach your Render backend
4. **Check Cloudflare**: Ensure CORS and SSL are properly configured

---

**Current Status**: Waiting for Render.com URL to be configured.
