import 'package:flutter/material.dart';

/// FSC Portal - Unified Design System
/// Complete theme configuration with all UI specifications from screenshot analysis

// ============================================
// COLOR PALETTE - Complete Reference
// ============================================

class AppPalette {
  // Background Colors
  static const Color deepBlack = Color(0xFF121212); // Main application background
  static const Color darkGrey = Color(0xFF1E1E1E); // Cards, surfaces, selected nav items
  static const Color cardBackground = Color(0xFF1E1E1E); // Card backgrounds
  
  // Primary Brand Colors
  static const Color portalBlue = Color(0xFF0056D2); // Primary brand blue - BUTTONS & ACTIVE STATES
  static const Color portalBlueLight = Color(0xFF1E6FE8); // Lighter blue variant for hover
  
  // Status Colors
  static const Color successGreen = Color(0xFF03DAC6); // Completed, checkmarks
  static const Color warningAmber = Color(0xFFFFC107); // Low priority, warnings
  static const Color alertRed = Color(0xFFCF6679); // Notification badges, errors
  static const Color quietDayGreen = Color(0xFF4CAF50); // "Quiet Day" tag background
  
  // Accent Colors
  static const Color purpleAccent = Color(0xFF9C27B0); // Graph icons, purple accents
  
  // Text Colors
  static const Color textWhite = Color(0xFFFFFFFF); // Primary text, titles, numbers
  static const Color textGrey = Color(0xFFB0B0B0); // Secondary text, subtitles
  static const Color textGreyDark = Color(0xFF808080); // Tertiary text
  
  // Border Colors
  static const Color borderGrey = Color(0xFF2A2A2F); // Subtle borders and dividers
}

// ============================================
// SEMANTIC COLOR MAPPING
// ============================================

class AppColors {
  // Core Colors
  static const Color background = AppPalette.deepBlack; // Main background (#121212)
  static const Color surface = AppPalette.darkGrey; // Cards/surfaces (#1E1E1E)
  static const Color primary = AppPalette.portalBlue; // Primary brand (#0056D2)

  // Status Colors
  static const Color error = AppPalette.alertRed;
  static const Color success = AppPalette.successGreen;
  static const Color warning = AppPalette.warningAmber;

  // Text Colors
  static const Color textPrimary = AppPalette.textWhite;
  static const Color textSecondary = AppPalette.textGrey;

  // Map Pin Colors (Client-specific)
  static const Color pinRBFCU = Colors.blue;
  static const Color pinJefferson = Colors.amber;
  static const Color pinProsperity = Colors.red;
}

// ============================================
// LAYOUT SPECIFICATIONS
// ============================================

class AppLayout {
  // Screen Structure
  static const double sidebarWidth = 240.0; // Left navigation sidebar
  static const double rightSidebarWidth = 280.0; // Right sidebar (Dispatch Insights)
  static const double headerHeight = 64.0; // Top header bar
  
  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingSM = 8.0;
  static const double spacingMD = 16.0;
  static const double spacingLG = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;
  
  // Border Radius
  static const double radiusSM = 4.0; // Tags
  static const double radiusMD = 8.0; // Buttons, navigation items
  static const double radiusLG = 12.0; // Cards
  static const double radiusXL = 16.0; // Large cards
  
  // Card Specifications
  static const double cardElevation = 2.0;
  static const double cardPadding = 16.0;
  static const EdgeInsets cardPaddingAll = EdgeInsets.all(16.0);
  
  // Button Specifications
  static const double buttonHeight = 40.0;
  static const double buttonPaddingH = 16.0;
  static const double buttonPaddingV = 12.0;
  static const double buttonBorderRadius = 8.0;
  
  // Navigation Item Specifications
  static const double navItemHeight = 48.0;
  static const double navItemPaddingH = 16.0;
  static const double navIconSize = 24.0;
  
  // Logo Specifications
  static const double logoSize = 48.0;
  static const EdgeInsets logoPadding = EdgeInsets.only(top: 32.0, bottom: 16.0);
}

// ============================================
// TYPOGRAPHY SPECIFICATIONS
// ============================================

class AppTypography {
  // Font Sizes
  static const double fontSizeXS = 10.0; // Tags, small labels
  static const double fontSizeSM = 12.0; // Timestamps, small text
  static const double fontSizeMD = 14.0; // Body text, subtitles
  static const double fontSizeLG = 16.0; // Card titles, navigation
  static const double fontSizeXL = 18.0; // Section titles, app title
  static const double fontSizeXXL = 20.0; // Section titles
  static const double fontSizeHuge = 24.0; // Large headings
  static const double fontSizeMassive = 32.0; // Card numbers
  
  // Font Weights
  static const FontWeight weightNormal = FontWeight.normal; // 400
  static const FontWeight weightMedium = FontWeight.w500; // 500
  static const FontWeight weightSemiBold = FontWeight.w600; // 600
  static const FontWeight weightBold = FontWeight.bold; // 700
  
  // Text Styles - App Title
  static const TextStyle appTitle = TextStyle(
    fontSize: fontSizeXL,
    fontWeight: weightBold,
    color: AppColors.textPrimary,
  );
  
  // Text Styles - Section Headers
  static const TextStyle sectionTitle = TextStyle(
    fontSize: fontSizeXXL,
    fontWeight: weightBold,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle sectionSubtitle = TextStyle(
    fontSize: fontSizeMD,
    fontWeight: weightNormal,
    color: AppColors.textSecondary,
  );
  
  // Text Styles - Cards
  static const TextStyle cardTitle = TextStyle(
    fontSize: fontSizeLG,
    fontWeight: weightSemiBold,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle cardSubtitle = TextStyle(
    fontSize: fontSizeMD,
    fontWeight: weightNormal,
    color: AppColors.textSecondary,
  );
  
  static const TextStyle cardNumber = TextStyle(
    fontSize: fontSizeMassive,
    fontWeight: weightBold,
    color: AppColors.textPrimary,
  );
  
  // Text Styles - Body
  static const TextStyle bodyText = TextStyle(
    fontSize: fontSizeMD,
    fontWeight: weightNormal,
    color: AppColors.textSecondary,
  );
  
  // Text Styles - Navigation
  static const TextStyle navItemActive = TextStyle(
    fontSize: fontSizeMD,
    fontWeight: weightSemiBold,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle navItemInactive = TextStyle(
    fontSize: fontSizeMD,
    fontWeight: weightNormal,
    color: AppColors.textSecondary,
  );
  
  // Text Styles - Buttons
  static const TextStyle buttonText = TextStyle(
    fontSize: fontSizeMD,
    fontWeight: weightMedium,
    color: AppColors.textPrimary,
  );
  
  // Text Styles - Tags
  static const TextStyle tagText = TextStyle(
    fontSize: fontSizeSM,
    fontWeight: weightMedium,
    color: AppColors.textPrimary,
  );
  
  // Text Styles - Timestamps
  static const TextStyle timestamp = TextStyle(
    fontSize: fontSizeSM,
    fontWeight: weightNormal,
    color: AppColors.textSecondary,
  );
}

// ============================================
// ASSET PATH CONSTANTS
// ============================================

class AppAssets {
  // Logo & Branding
  static const String logo = 'assets/logo.webp'; // Using webp since png doesn't exist
  static const String fscLogo = 'assets/FSC_Logo.svg';
  static const String mapStyle = 'assets/map_style_dark.json';
  
  // Note: watermark.svg doesn't exist - use fscLogo or logo instead
}

// ============================================
// COMPONENT STYLES
// ============================================

class AppComponents {
  // Header Bar
  static BoxDecoration headerBarDecoration = BoxDecoration(
    color: AppColors.background,
    border: Border(
      bottom: BorderSide(
        color: AppPalette.borderGrey,
        width: 1,
      ),
    ),
  );
  
  // Primary Button Style (New Call, Time Entry)
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary, // #0056D2
    foregroundColor: AppColors.textPrimary,
    padding: const EdgeInsets.symmetric(
      horizontal: AppLayout.buttonPaddingH,
      vertical: AppLayout.buttonPaddingV,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppLayout.buttonBorderRadius),
    ),
    elevation: 0,
  );
  
  // Text Button Style (Review, Watch, Submit)
  static ButtonStyle textButtonStyle = TextButton.styleFrom(
    foregroundColor: AppColors.primary, // #0056D2
    padding: const EdgeInsets.symmetric(
      horizontal: AppLayout.spacingSM,
      vertical: AppLayout.spacingXS,
    ),
  );
  
  // Navigation Item - Active
  static BoxDecoration navItemActiveDecoration = BoxDecoration(
    color: AppColors.primary, // #0056D2
    borderRadius: BorderRadius.circular(AppLayout.radiusMD),
  );
  
  // Navigation Item - Inactive
  static BoxDecoration navItemInactiveDecoration = const BoxDecoration(
    color: Colors.transparent,
  );
  
  // Summary Card (Open Calls, Completed Today, This Week)
  static BoxDecoration summaryCardDecoration = BoxDecoration(
    color: AppColors.surface, // #1E1E1E
    borderRadius: BorderRadius.circular(AppLayout.radiusLG),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  );
  
  // Information Card (Weather, Inventory)
  static BoxDecoration infoCardDecoration = BoxDecoration(
    color: AppColors.surface, // #1E1E1E
    borderRadius: BorderRadius.circular(AppLayout.radiusLG),
  );
  
  // Action Card (Recommended Actions)
  static BoxDecoration actionCardDecoration = BoxDecoration(
    color: AppColors.surface, // #1E1E1E
    borderRadius: BorderRadius.circular(AppLayout.radiusLG),
  );
  
  // Entry Card (Completions, Activity)
  static BoxDecoration entryCardDecoration = BoxDecoration(
    color: AppColors.surface, // #1E1E1E
    borderRadius: BorderRadius.circular(AppLayout.radiusLG),
  );
  
  // Tag - Quiet Day
  static BoxDecoration tagQuietDayDecoration = BoxDecoration(
    color: AppPalette.quietDayGreen,
    borderRadius: BorderRadius.circular(AppLayout.radiusSM),
  );
  
  // Tag - Low Priority
  static BoxDecoration tagLowDecoration = BoxDecoration(
    color: AppPalette.warningAmber,
    borderRadius: BorderRadius.circular(AppLayout.radiusSM),
  );
  
  // Tag - Completed
  static BoxDecoration tagCompletedDecoration = BoxDecoration(
    color: AppPalette.successGreen,
    borderRadius: BorderRadius.circular(AppLayout.radiusSM),
  );
  
  // Tag Padding
  static EdgeInsets tagPadding = const EdgeInsets.symmetric(
    horizontal: AppLayout.spacingSM,
    vertical: AppLayout.spacingXS,
  );
  
  // Notification Badge
  static BoxDecoration notificationBadgeDecoration = BoxDecoration(
    color: AppPalette.alertRed,
    shape: BoxShape.circle,
  );
  
  // User Avatar
  static BoxDecoration userAvatarDecoration = BoxDecoration(
    color: AppColors.primary, // #0056D2
    shape: BoxShape.circle,
  );
}

// ============================================
// ICON SPECIFICATIONS
// ============================================

class AppIcons {
  // Icon Sizes
  static const double sizeXS = 16.0; // Small graph icons, badges
  static const double sizeSM = 20.0; // Activity entry icons
  static const double sizeMD = 24.0; // Card icons, navigation icons
  static const double sizeLG = 32.0; // Summary card icons
  static const double sizeXL = 48.0; // Logo
  
  // Icon Colors
  static const Color colorPrimary = AppPalette.portalBlue; // #0056D2
  static const Color colorSuccess = AppPalette.successGreen;
  static const Color colorWarning = AppPalette.warningAmber;
  static const Color colorError = AppPalette.alertRed;
  static const Color colorWhite = AppPalette.textWhite;
  static const Color colorGrey = AppPalette.textGrey;
  static const Color colorPurple = AppPalette.purpleAccent;
}

// ============================================
// SPACING SYSTEM
// ============================================

class AppSpacing {
  // Vertical Spacing
  static const SizedBox v4 = SizedBox(height: 4);
  static const SizedBox v8 = SizedBox(height: 8);
  static const SizedBox v12 = SizedBox(height: 12);
  static const SizedBox v16 = SizedBox(height: 16);
  static const SizedBox v24 = SizedBox(height: 24);
  static const SizedBox v32 = SizedBox(height: 32);
  static const SizedBox v48 = SizedBox(height: 48);
  
  // Horizontal Spacing
  static const SizedBox h4 = SizedBox(width: 4);
  static const SizedBox h8 = SizedBox(width: 8);
  static const SizedBox h12 = SizedBox(width: 12);
  static const SizedBox h16 = SizedBox(width: 16);
  static const SizedBox h24 = SizedBox(width: 24);
  static const SizedBox h32 = SizedBox(width: 32);
}

// ============================================
// THEME CONFIGURATION
// ============================================

class AppTheme {
  /// Dark Theme for Offline Portal
  /// Uses exact colors and specifications from UI screenshot
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      
      // Scaffold & Background
      scaffoldBackgroundColor: AppColors.background, // #121212
      
      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary, // #0056D2
        secondary: AppColors.textSecondary,
        surface: AppColors.surface, // #1E1E1E
        error: AppColors.error,
        onPrimary: AppColors.textPrimary,
        onSecondary: AppColors.textPrimary,
        onSurface: AppColors.textPrimary,
        onError: AppColors.textPrimary,
      ),
      
      // Primary Color
      primaryColor: AppColors.primary, // #0056D2
      
      // Card Theme
      cardColor: AppColors.surface, // #1E1E1E
      cardTheme: CardThemeData(
        color: AppColors.surface, // #1E1E1E
        elevation: AppLayout.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppLayout.radiusLG),
        ),
      ),
      
      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.primary, // #0056D2
        size: AppIcons.sizeMD,
      ),
      
      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface, // #1E1E1E
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: AppColors.primary, // #0056D2
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface, // #1E1E1E
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppLayout.radiusMD),
          borderSide: const BorderSide(
            color: AppColors.textSecondary,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppLayout.radiusMD),
          borderSide: const BorderSide(
            color: AppColors.textSecondary,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppLayout.radiusMD),
          borderSide: const BorderSide(
            color: AppColors.primary, // #0056D2
            width: 2,
          ),
        ),
        labelStyle: const TextStyle(
          color: AppColors.textSecondary,
        ),
        hintStyle: const TextStyle(
          color: AppColors.textSecondary,
        ),
      ),
      
      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: AppComponents.primaryButtonStyle,
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: AppComponents.textButtonStyle,
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary, // #0056D2
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppLayout.radiusMD),
          ),
        ),
      ),
      
      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.textSecondary,
        thickness: 1,
        space: 1,
      ),
      
      // Typography
      textTheme: const TextTheme(
        // Headlines
        displayLarge: TextStyle(
          fontSize: AppTypography.fontSizeMassive,
          fontWeight: AppTypography.weightBold,
          color: AppColors.textPrimary,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontSize: AppTypography.fontSizeHuge,
          fontWeight: AppTypography.weightBold,
          color: AppColors.textPrimary,
          letterSpacing: -0.5,
        ),
        displaySmall: TextStyle(
          fontSize: AppTypography.fontSizeXXL,
          fontWeight: AppTypography.weightBold,
          color: AppColors.textPrimary,
        ),
        headlineLarge: TextStyle(
          fontSize: AppTypography.fontSizeXL,
          fontWeight: AppTypography.weightSemiBold,
          color: AppColors.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: AppTypography.fontSizeXXL,
          fontWeight: AppTypography.weightBold,
          color: AppColors.textPrimary,
        ),
        headlineSmall: TextStyle(
          fontSize: AppTypography.fontSizeLG,
          fontWeight: AppTypography.weightSemiBold,
          color: AppColors.textPrimary,
        ),
        
        // Body Text
        bodyLarge: TextStyle(
          fontSize: AppTypography.fontSizeLG,
          fontWeight: AppTypography.weightNormal,
          color: AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: AppTypography.fontSizeMD,
          fontWeight: AppTypography.weightNormal,
          color: AppColors.textSecondary,
        ),
        bodySmall: TextStyle(
          fontSize: AppTypography.fontSizeSM,
          fontWeight: AppTypography.weightNormal,
          color: AppColors.textSecondary,
        ),
        
        // Labels
        labelLarge: TextStyle(
          fontSize: AppTypography.fontSizeMD,
          fontWeight: AppTypography.weightMedium,
          color: AppColors.textPrimary,
        ),
        labelMedium: TextStyle(
          fontSize: AppTypography.fontSizeSM,
          fontWeight: AppTypography.weightMedium,
          color: AppColors.textSecondary,
        ),
        labelSmall: TextStyle(
          fontSize: AppTypography.fontSizeXS,
          fontWeight: AppTypography.weightMedium,
          color: AppColors.textSecondary,
        ),
      ),
      
      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary, // #0056D2
        foregroundColor: AppColors.textPrimary,
      ),
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface, // #1E1E1E
        selectedItemColor: AppColors.primary, // #0056D2
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
      ),
      
      // Drawer Theme
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.surface, // #1E1E1E
      ),
      
      // Dialog Theme
      dialogTheme: const DialogThemeData(
        backgroundColor: AppColors.surface, // #1E1E1E
        titleTextStyle: TextStyle(
          fontSize: AppTypography.fontSizeXXL,
          fontWeight: AppTypography.weightSemiBold,
          color: AppColors.textPrimary,
        ),
        contentTextStyle: TextStyle(
          fontSize: AppTypography.fontSizeMD,
          color: AppColors.textSecondary,
        ),
      ),
      
      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surface, // #1E1E1E
        contentTextStyle: const TextStyle(
          color: AppColors.textPrimary,
        ),
        actionTextColor: AppColors.primary, // #0056D2
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppLayout.radiusMD),
        ),
      ),
    );
  }
}
