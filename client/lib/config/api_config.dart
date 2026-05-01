import 'package:flutter/foundation.dart';

/// API Configuration
/// 
/// Dual-backend setup:
/// - flowspace-backend (existing, on Render) - for legacy endpoints (/fsc/*)
/// - fsc-enterprise-core (new, local or Render) - for new endpoints (/api/portal/*)
class ApiConfig {
  // ============================================
  // PRODUCTION URLs (Render.com)
  // ============================================
  
  // flowspace-backend URL (existing backend, used for /fsc/* endpoints)
  // TODO: Update with your actual flowspace-backend Render URL
  static const String _flowspaceBackendUrl = 'https://flowspace-backend.onrender.com';
  
  // fsc-enterprise-core URL (new backend, used for /api/portal/* endpoints)
  // TODO: Switch back to Cloudflare subdomain once DNS fully propagates:
  // static const String _newBackendUrl = 'https://api.vyrevaultstudios.com';
  // Temporarily using Render URL directly until DNS propagation completes
  static const String _newBackendUrl = 'https://fsc-enterprise-core.onrender.com';
  
  // ============================================
  // LOCAL DEVELOPMENT URLs
  // ============================================
  
  // Local flowspace-backend (if running locally)
  static const String _localFlowspaceBackendUrl = 'http://localhost:3001'; // Adjust port if different
  
  // Local fsc-enterprise-core (new backend)
  static const String _localNewBackendUrl = 'http://localhost:3000';
  
  // ============================================
  // URL SELECTION LOGIC
  // ============================================
  
  // Force production URLs even in debug (useful for testing against production)
  // Set to true by default since backend is deployed on Render
  static bool _useProductionInDebug = true;
  static void useProductionInDebug(bool value) {
    _useProductionInDebug = value;
  }
  
  // Get flowspace-backend URL (for legacy /fsc/* endpoints)
  static String get flowspaceBackendUrl {
    if (kDebugMode && !_useProductionInDebug) {
      return _localFlowspaceBackendUrl;
    }
    return _flowspaceBackendUrl;
  }
  
  // Get new backend URL (for /api/portal/* endpoints)
  // Uses production URL by default since backend is deployed on Render
  static String get newBackendUrl {
    if (kDebugMode && !_useProductionInDebug) {
      return _localNewBackendUrl;
    }
    return _newBackendUrl;
  }
  
  // Main base URL (used by legacy endpoints that call /fsc/*)
  // This points to flowspace-backend
  static String get baseUrl => flowspaceBackendUrl;
  
  // Effective base URL (backwards compatibility)
  static String get effectiveBaseUrl => baseUrl;
  
  // API prefix for new Portal endpoints
  static const String portalApiPrefix = '/api/portal';
}
