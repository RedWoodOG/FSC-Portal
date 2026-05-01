import 'package:drift/drift.dart';
import 'app_database.dart';

/// Seed the knowledge base with hierarchical category structure
/// Based on FSC field service equipment and procedures
Future<void> seedKnowledgeCategories(AppDatabase db) async {
  // Check if already seeded
  final existing = await db.getTopLevelCategories();
  if (existing.isNotEmpty) {
    print('Knowledge categories already seeded. Skipping.');
    return;
  }

  print('Seeding knowledge base categories...');

  // ============================================
  // LEVEL 1: EQUIPMENT DOMAINS
  // ============================================

  // Cash Handling Equipment
  final cashHandlingId = await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Cash Handling Equipment',
          slug: 'cash-handling',
          level: 1,
          path: '/cash-handling',
          icon: const Value('account_balance'),
          description: const Value(
              'ATMs, coin sorters, currency counters, and validators'),
          color: const Value('#0056D2'),
          sortOrder: const Value(1),
        ),
      );

  // Security Systems
  final securityId = await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Security Systems',
          slug: 'security',
          level: 1,
          path: '/security',
          icon: const Value('security'),
          description:
              const Value('Surveillance, access control, and alarm systems'),
          color: const Value('#CF6679'),
          sortOrder: const Value(2),
        ),
      );

  // Vault Equipment
  final vaultId = await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Vault Equipment',
          slug: 'vault',
          level: 1,
          path: '/vault',
          icon: const Value('shield'),
          description: const Value('Pneumatic systems, HVAC, and vault doors'),
          color: const Value('#FFC107'),
          sortOrder: const Value(3),
        ),
      );

  // Computing Systems
  // ignore: unused_local_variable
  final computingId = await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Computing Systems',
          slug: 'computing',
          level: 1,
          path: '/computing',
          icon: const Value('computer'),
          description:
              const Value('Workstations, network equipment, and printers'),
          color: const Value('#03DAC6'),
          sortOrder: const Value(4),
        ),
      );

  // ============================================
  // LEVEL 2: EQUIPMENT TYPES (Cash Handling)
  // ============================================

  // ATM / TCR
  final atmId = await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'ATM / TCR',
          slug: 'atm-tcr',
          parentId: Value(cashHandlingId),
          level: 2,
          path: '/cash-handling/atm-tcr',
          icon: const Value('atm'),
          sortOrder: const Value(1),
        ),
      );

  // Coin Sorters
  final coinSorterId = await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Coin Sorters',
          slug: 'coin-sorters',
          parentId: Value(cashHandlingId),
          level: 2,
          path: '/cash-handling/coin-sorters',
          icon: const Value('toll'),
          sortOrder: const Value(2),
        ),
      );

  // Currency Counters
  final currencyCounterId = await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Currency Counters',
          slug: 'currency-counters',
          parentId: Value(cashHandlingId),
          level: 2,
          path: '/cash-handling/currency-counters',
          icon: const Value('attach_money'),
          sortOrder: const Value(3),
        ),
      );

  // Validators
  final validatorId = await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Validators',
          slug: 'validators',
          parentId: Value(cashHandlingId),
          level: 2,
          path: '/cash-handling/validators',
          icon: const Value('verified'),
          sortOrder: const Value(4),
        ),
      );

  // ============================================
  // LEVEL 3: MANUFACTURERS (ATM)
  // ============================================

  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Hyosung',
          slug: 'hyosung',
          parentId: Value(atmId),
          level: 3,
          path: '/cash-handling/atm-tcr/hyosung',
          icon: const Value('business'),
          sortOrder: const Value(1),
        ),
      );

  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'NCR',
          slug: 'ncr',
          parentId: Value(atmId),
          level: 3,
          path: '/cash-handling/atm-tcr/ncr',
          icon: const Value('business'),
          sortOrder: const Value(2),
        ),
      );

  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Diebold Nixdorf',
          slug: 'diebold',
          parentId: Value(atmId),
          level: 3,
          path: '/cash-handling/atm-tcr/diebold',
          icon: const Value('business'),
          sortOrder: const Value(3),
        ),
      );

  // ============================================
  // LEVEL 3: MANUFACTURERS (Coin Sorters)
  // ============================================

  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'JetSort',
          slug: 'jetsort',
          parentId: Value(coinSorterId),
          level: 3,
          path: '/cash-handling/coin-sorters/jetsort',
          icon: const Value('business'),
          sortOrder: const Value(1),
        ),
      );

  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Kisan',
          slug: 'kisan',
          parentId: Value(coinSorterId),
          level: 3,
          path: '/cash-handling/coin-sorters/kisan',
          icon: const Value('business'),
          sortOrder: const Value(2),
        ),
      );

  // ============================================
  // LEVEL 3: MANUFACTURERS (Currency Counters)
  // ============================================

  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Hitachi',
          slug: 'hitachi',
          parentId: Value(currencyCounterId),
          level: 3,
          path: '/cash-handling/currency-counters/hitachi',
          icon: const Value('business'),
          sortOrder: const Value(1),
        ),
      );

  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Glory',
          slug: 'glory',
          parentId: Value(currencyCounterId),
          level: 3,
          path: '/cash-handling/currency-counters/glory',
          icon: const Value('business'),
          sortOrder: const Value(2),
        ),
      );

  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Magner',
          slug: 'magner',
          parentId: Value(currencyCounterId),
          level: 3,
          path: '/cash-handling/currency-counters/magner',
          icon: const Value('business'),
          sortOrder: const Value(3),
        ),
      );

  // ============================================
  // LEVEL 3: MANUFACTURERS (Validators)
  // ============================================

  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Epson',
          slug: 'epson',
          parentId: Value(validatorId),
          level: 3,
          path: '/cash-handling/validators/epson',
          icon: const Value('business'),
          sortOrder: const Value(1),
        ),
      );

  // ============================================
  // LEVEL 2: SECURITY EQUIPMENT TYPES
  // ============================================

  // Surveillance
  final surveillanceId = await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Surveillance',
          slug: 'surveillance',
          parentId: Value(securityId),
          level: 2,
          path: '/security/surveillance',
          icon: const Value('videocam'),
          sortOrder: const Value(1),
        ),
      );

  // Access Control
  final accessControlId = await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Access Control',
          slug: 'access-control',
          parentId: Value(securityId),
          level: 2,
          path: '/security/access-control',
          icon: const Value('lock'),
          sortOrder: const Value(2),
        ),
      );

  // ============================================
  // LEVEL 3: MANUFACTURERS (Surveillance)
  // ============================================

  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'March Networks',
          slug: 'march-networks',
          parentId: Value(surveillanceId),
          level: 3,
          path: '/security/surveillance/march-networks',
          icon: const Value('business'),
          sortOrder: const Value(1),
        ),
      );

  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Dahua',
          slug: 'dahua',
          parentId: Value(surveillanceId),
          level: 3,
          path: '/security/surveillance/dahua',
          icon: const Value('business'),
          sortOrder: const Value(2),
        ),
      );

  // ============================================
  // LEVEL 3: MANUFACTURERS (Access Control)
  // ============================================

  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'La Gard',
          slug: 'la-gard',
          parentId: Value(accessControlId),
          level: 3,
          path: '/security/access-control/la-gard',
          icon: const Value('business'),
          sortOrder: const Value(1),
        ),
      );

  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Kaba',
          slug: 'kaba',
          parentId: Value(accessControlId),
          level: 3,
          path: '/security/access-control/kaba',
          icon: const Value('business'),
          sortOrder: const Value(2),
        ),
      );

  // ============================================
  // LEVEL 2: VAULT EQUIPMENT TYPES
  // ============================================

  // Pneumatic Systems
  final pneumaticId = await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Pneumatic Systems',
          slug: 'pneumatic',
          parentId: Value(vaultId),
          level: 2,
          path: '/vault/pneumatic',
          icon: const Value('settings_input_component'),
          sortOrder: const Value(1),
        ),
      );

  // HVAC Systems
  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'HVAC Systems',
          slug: 'hvac',
          parentId: Value(vaultId),
          level: 2,
          path: '/vault/hvac',
          icon: const Value('ac_unit'),
          sortOrder: const Value(2),
        ),
      );

  // ============================================
  // LEVEL 3: MANUFACTURERS (Pneumatic)
  // ============================================

  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'American Vault',
          slug: 'american-vault',
          parentId: Value(pneumaticId),
          level: 3,
          path: '/vault/pneumatic/american-vault',
          icon: const Value('business'),
          sortOrder: const Value(1),
        ),
      );

  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Bavis',
          slug: 'bavis',
          parentId: Value(pneumaticId),
          level: 3,
          path: '/vault/pneumatic/bavis',
          icon: const Value('business'),
          sortOrder: const Value(2),
        ),
      );

  // ============================================
  // LEVEL 1: SERVICE PROCEDURES
  // ============================================

  // Troubleshooting
  final troubleshootingId = await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Troubleshooting',
          slug: 'troubleshooting',
          level: 1,
          path: '/troubleshooting',
          icon: const Value('build'),
          description:
              const Value('Diagnostic procedures and error resolution'),
          color: const Value('#CF6679'),
          sortOrder: const Value(10),
        ),
      );

  // Maintenance
  final maintenanceId = await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Maintenance',
          slug: 'maintenance',
          level: 1,
          path: '/maintenance',
          icon: const Value('handyman'),
          description:
              const Value('Preventive and corrective maintenance procedures'),
          color: const Value('#03DAC6'),
          sortOrder: const Value(11),
        ),
      );

  // Installation
  final installationId = await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Installation',
          slug: 'installation',
          level: 1,
          path: '/installation',
          icon: const Value('construction'),
          description: const Value('New equipment setup and configuration'),
          color: const Value('#9C27B0'),
          sortOrder: const Value(12),
        ),
      );

  // Reference
  final referenceId = await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Reference',
          slug: 'reference',
          level: 1,
          path: '/reference',
          icon: const Value('library_books'),
          description: const Value(
              'Parts catalogs, specifications, and technical references'),
          color: const Value('#808080'),
          sortOrder: const Value(13),
        ),
      );

  // Safety & Compliance
  final safetyId = await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Safety & Compliance',
          slug: 'safety',
          level: 1,
          path: '/safety',
          icon: const Value('warning'),
          description:
              const Value('Safety procedures and compliance requirements'),
          color: const Value('#FFC107'),
          sortOrder: const Value(14),
        ),
      );

  // ============================================
  // LEVEL 2: PROCEDURE SUBCATEGORIES
  // ============================================

  // Troubleshooting subcategories
  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Diagnostic Procedures',
          slug: 'diagnostics',
          parentId: Value(troubleshootingId),
          level: 2,
          path: '/troubleshooting/diagnostics',
          icon: const Value('search'),
          sortOrder: const Value(1),
        ),
      );

  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Error Code Resolution',
          slug: 'error-codes',
          parentId: Value(troubleshootingId),
          level: 2,
          path: '/troubleshooting/error-codes',
          icon: const Value('error'),
          sortOrder: const Value(2),
        ),
      );

  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Component Testing',
          slug: 'component-testing',
          parentId: Value(troubleshootingId),
          level: 2,
          path: '/troubleshooting/component-testing',
          icon: const Value('science'),
          sortOrder: const Value(3),
        ),
      );

  // Maintenance subcategories
  final preventiveId = await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Preventive Maintenance',
          slug: 'preventive',
          parentId: Value(maintenanceId),
          level: 2,
          path: '/maintenance/preventive',
          icon: const Value('schedule'),
          sortOrder: const Value(1),
        ),
      );

  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Corrective Maintenance',
          slug: 'corrective',
          parentId: Value(maintenanceId),
          level: 2,
          path: '/maintenance/corrective',
          icon: const Value('build_circle'),
          sortOrder: const Value(2),
        ),
      );

  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Calibration',
          slug: 'calibration',
          parentId: Value(maintenanceId),
          level: 2,
          path: '/maintenance/calibration',
          icon: const Value('tune'),
          sortOrder: const Value(3),
        ),
      );

  // Preventive maintenance L3 subcategories
  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Daily Checks',
          slug: 'daily',
          parentId: Value(preventiveId),
          level: 3,
          path: '/maintenance/preventive/daily',
          icon: const Value('today'),
          sortOrder: const Value(1),
        ),
      );

  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Weekly Inspections',
          slug: 'weekly',
          parentId: Value(preventiveId),
          level: 3,
          path: '/maintenance/preventive/weekly',
          icon: const Value('date_range'),
          sortOrder: const Value(2),
        ),
      );

  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Monthly Service',
          slug: 'monthly',
          parentId: Value(preventiveId),
          level: 3,
          path: '/maintenance/preventive/monthly',
          icon: const Value('calendar_month'),
          sortOrder: const Value(3),
        ),
      );

  // Installation subcategories
  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'New Equipment Setup',
          slug: 'new-setup',
          parentId: Value(installationId),
          level: 2,
          path: '/installation/new-setup',
          icon: const Value('add_box'),
          sortOrder: const Value(1),
        ),
      );

  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Component Replacement',
          slug: 'replacement',
          parentId: Value(installationId),
          level: 2,
          path: '/installation/replacement',
          icon: const Value('swap_horiz'),
          sortOrder: const Value(2),
        ),
      );

  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Configuration',
          slug: 'configuration',
          parentId: Value(installationId),
          level: 2,
          path: '/installation/configuration',
          icon: const Value('settings'),
          sortOrder: const Value(3),
        ),
      );

  // Reference subcategories
  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Parts Catalogs',
          slug: 'parts-catalogs',
          parentId: Value(referenceId),
          level: 2,
          path: '/reference/parts-catalogs',
          icon: const Value('inventory_2'),
          sortOrder: const Value(1),
        ),
      );

  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Specifications',
          slug: 'specifications',
          parentId: Value(referenceId),
          level: 2,
          path: '/reference/specifications',
          icon: const Value('description'),
          sortOrder: const Value(2),
        ),
      );

  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Wiring Diagrams',
          slug: 'wiring',
          parentId: Value(referenceId),
          level: 2,
          path: '/reference/wiring',
          icon: const Value('cable'),
          sortOrder: const Value(3),
        ),
      );

  // Safety subcategories
  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'OSHA Compliance',
          slug: 'osha',
          parentId: Value(safetyId),
          level: 2,
          path: '/safety/osha',
          icon: const Value('health_and_safety'),
          sortOrder: const Value(1),
        ),
      );

  await db.into(db.knowledgeCategories).insert(
        KnowledgeCategoriesCompanion.insert(
          name: 'Equipment Safety',
          slug: 'equipment-safety',
          parentId: Value(safetyId),
          level: 2,
          path: '/safety/equipment-safety',
          icon: const Value('shield'),
          sortOrder: const Value(2),
        ),
      );

  print('Knowledge categories seeded successfully!');
}

/// Seed common knowledge base tags
Future<void> seedKnowledgeTags(AppDatabase db) async {
  // Check if already seeded
  final existing = await (db.select(db.knowledgeTags)..limit(1)).get();
  if (existing.isNotEmpty) {
    print('Knowledge tags already seeded. Skipping.');
    return;
  }

  print('Seeding knowledge base tags...');

  final commonTags = [
    // Issue types
    (
      'error-codes',
      'Error Codes',
      '#CF6679',
      'Common error codes and resolutions'
    ),
    (
      'jam-clearing',
      'Jam Clearing',
      '#FFC107',
      'Clearing jams and obstructions'
    ),
    ('calibration', 'Calibration', '#03DAC6', 'Calibration procedures'),
    (
      'firmware-update',
      'Firmware Update',
      '#9C27B0',
      'Firmware and software updates'
    ),

    // Complexity
    (
      'quick-fix',
      'Quick Fix',
      '#03DAC6',
      'Can be resolved in under 10 minutes'
    ),
    (
      'advanced-procedure',
      'Advanced',
      '#CF6679',
      'Requires advanced technical knowledge'
    ),
    (
      'beginner-friendly',
      'Beginner Friendly',
      '#03DAC6',
      'Suitable for new technicians'
    ),

    // Safety
    (
      'safety-critical',
      'Safety Critical',
      '#CF6679',
      'Critical safety considerations'
    ),
    (
      'electrical-hazard',
      'Electrical Hazard',
      '#FFC107',
      'Involves electrical components'
    ),
    ('lockout-tagout', 'Lockout/Tagout', '#CF6679', 'Requires LOTO procedures'),

    // Service context
    (
      'preventive-maintenance',
      'Preventive',
      '#03DAC6',
      'Preventive maintenance task'
    ),
    ('emergency-repair', 'Emergency', '#CF6679', 'Emergency repair procedure'),
    (
      'warranty-service',
      'Warranty Service',
      '#0056D2',
      'Covered under warranty'
    ),

    // Components
    ('card-reader', 'Card Reader', '#0056D2', 'Card reader related'),
    ('cash-dispenser', 'Cash Dispenser', '#0056D2', 'Cash dispenser related'),
    (
      'receipt-printer',
      'Receipt Printer',
      '#0056D2',
      'Receipt printer related'
    ),
    ('power-supply', 'Power Supply', '#FFC107', 'Power supply related'),

    // Documentation type
    ('step-by-step', 'Step-by-Step', '#03DAC6', 'Detailed step-by-step guide'),
    ('reference-only', 'Reference', '#808080', 'Reference material only'),
    (
      'troubleshooting-guide',
      'Troubleshooting',
      '#CF6679',
      'Troubleshooting guide'
    ),
  ];

  for (final (slug, name, color, description) in commonTags) {
    await db.into(db.knowledgeTags).insert(
          KnowledgeTagsCompanion.insert(
            name: name,
            slug: slug,
            color: Value(color),
            description: Value(description),
          ),
        );
  }

  print('Knowledge tags seeded successfully!');
}
