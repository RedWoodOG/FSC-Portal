import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

part 'app_database.g.dart';

// ============================================
// TABLE DEFINITIONS
// ============================================

// Clients table
class Clients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get themeColor => text()(); // 'red', 'blue', 'yellow'
}

// Sites table
class Sites extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get clientId => integer().references(Clients, #id)();
  TextColumn get branchName => text()();
  TextColumn get address => text()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  TextColumn get region => text()();
}

// Starting Points table
class StartingPoints extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
}

// Users table
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().unique()();
  TextColumn get fullName => text()();
  TextColumn get email => text()();
  TextColumn get role => text()(); // 'admin', 'tech'

  // Authentication (hashed, never plaintext)
  TextColumn get passwordHash => text().withDefault(const Constant(''))();
  TextColumn get passwordSalt => text().withDefault(const Constant(''))();
  TextColumn get pin =>
      text().nullable()(); // Optional quick-reentry PIN (hashed)

  DateTimeColumn get dateOfBirth => dateTime().nullable()();
  TextColumn get location => text().nullable()();
  TextColumn get phoneNumber => text().nullable()();
  TextColumn get bio => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// Weather Snapshot table (for offline-first weather display)
class WeatherSnapshot extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get region => text()();
  IntColumn get temperature => integer()();
  TextColumn get condition => text()(); // 'Clear', 'Cloudy', etc.
  DateTimeColumn get fetchedAt => dateTime()();
  TextColumn get source => text()(); // 'api', 'fallback', etc.
  TextColumn get zipCode => text().nullable()(); // Added for auto-update
}

// Traffic Snapshot table (for offline-first traffic display)
class TrafficSnapshot extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get routeLabel => text()();
  IntColumn get etaMinutes => integer()();
  TextColumn get conditionLabel => text()(); // 'Light', 'Moderate', 'Heavy'
  DateTimeColumn get fetchedAt => dateTime()();
  TextColumn get source => text()();
}

// Work Calls table (for KPI cards)
class WorkCalls extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get status => text()(); // 'open', 'completed'
  DateTimeColumn get scheduledAt => dateTime().nullable()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  TextColumn get workOrderNumber => text().nullable()();
}

// Industry Briefing table (for news feed)
class IndustryBriefing extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get source => text()();
  TextColumn get previewImage => text().nullable()();
  DateTimeColumn get publishedAt => dateTime()();
  DateTimeColumn get fetchedAt => dateTime()();
}

// Company Announcements table (for company feed)
class CompanyAnnouncements extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get category => text()(); // 'hr', 'safety', 'fleet'
  TextColumn get title => text()();
  TextColumn get body => text()();
  TextColumn get actionLabel => text().nullable()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get publishedAt => dateTime()();
  BoolColumn get acknowledged => boolean().withDefault(const Constant(false))();
  DateTimeColumn get acknowledgedAt => dateTime().nullable()();
}

// Operations Domain Model - Work Orders
class WorkOrders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get siteId => integer()(); // References Sites
  TextColumn get status => text()(); // 'open', 'on_hold', 'completed'
  TextColumn get priority => text().nullable()();
  TextColumn get descriptionOfWork => text().nullable()();
  TextColumn get internalNotes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get closedAt => dateTime().nullable()();
  TextColumn get createdBy => text().nullable()();
  TextColumn get assignedTechnician => text().nullable()();
}

// Appointments - Scheduled time blocks for work orders
class Appointments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get workOrderId => integer()(); // References WorkOrders
  DateTimeColumn get scheduledStart => dateTime()();
  IntColumn get expectedDurationMinutes => integer().nullable()();
  TextColumn get technician => text().nullable()();
}

// Equipment - Installed equipment at sites with serial numbers
class Equipment extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get siteId => integer()(); // References Sites
  IntColumn get machineProfileId =>
      integer().nullable()(); // FK to MachineProfiles
  TextColumn get equipmentType =>
      text()(); // 'counter', 'atm', 'dvr', 'lock', etc
  TextColumn get manufacturer => text().nullable()();
  TextColumn get model => text().nullable()();
  TextColumn get serialNumber => text().nullable()();
  BoolColumn get underWarranty =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get underServiceContract =>
      boolean().withDefault(const Constant(false))();
  TextColumn get contractReference => text().nullable()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
}

// Work Order Equipment - Junction table for equipment involved in work orders
class WorkOrderEquipment extends Table {
  IntColumn get workOrderId => integer()(); // References WorkOrders
  IntColumn get equipmentId => integer()(); // References Equipment

  @override
  Set<Column> get primaryKey => {workOrderId, equipmentId};
}

// Work Performed - Actual technician work logs (historical record)
class WorkPerformed extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get workOrderId => integer()(); // References WorkOrders
  IntColumn get equipmentId => integer().nullable()(); // References Equipment
  TextColumn get technician => text()();
  DateTimeColumn get startedAt => dateTime()();
  IntColumn get durationMinutes => integer().nullable()();
  TextColumn get workDescription => text().nullable()();
  TextColumn get resolution => text().nullable()();
  BoolColumn get repeatIssue => boolean().withDefault(const Constant(false))();
}

// Parts Used - Parts consumed during work
class PartsUsed extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get workPerformedId => integer()(); // References WorkPerformed
  TextColumn get partNumber => text().nullable()();
  TextColumn get description => text().nullable()();
  IntColumn get quantity => integer().withDefault(const Constant(1))();
}

// Notes - POIs, warnings, internal notes
class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get siteId => integer()(); // References Sites
  IntColumn get workOrderId => integer().nullable()(); // References WorkOrders
  TextColumn get noteType => text()(); // 'poi', 'warning', 'general'
  TextColumn get noteText => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get createdBy => text().nullable()();
}

// Documents - Attachments tied to work orders
class Documents extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get workOrderId =>
      integer().nullable()(); // Made nullable to allow Site docs
  IntColumn get siteId =>
      integer().nullable()(); // [NEW] Link docs to Sites (SAS)
  TextColumn get fileName => text()();
  TextColumn get filePath => text()();
  DateTimeColumn get uploadedAt => dateTime()();
  TextColumn get uploadedBy => text().nullable()();
}

// Knowledge Entries - Enhanced with rich metadata for technical documentation
class KnowledgeEntries extends Table {
  // PRIMARY IDENTIFICATION
  TextColumn get id => text()();

  // CORE CONTENT
  TextColumn get title => text()();
  TextColumn get content => text()();
  TextColumn get summary => text().withDefault(const Constant(''))();

  // TAXONOMY & CLASSIFICATION
  IntColumn get categoryId =>
      integer().nullable()(); // FK to KnowledgeCategories
  IntColumn get machineProfileId =>
      integer().nullable()(); // FK to MachineProfiles
  TextColumn get category =>
      text()(); // Legacy, kept for backward compatibility
  TextColumn get equipmentType => text()();
  TextColumn get equipmentModel => text().nullable()();
  TextColumn get manufacturer => text().nullable()();
  TextColumn get applicableModels => text().nullable()(); // JSON array

  // SERVICE CLASSIFICATION
  TextColumn get serviceType =>
      text().withDefault(const Constant('reference'))();
  TextColumn get difficultyLevel =>
      text().withDefault(const Constant('intermediate'))();
  TextColumn get priorityLevel =>
      text().withDefault(const Constant('standard'))();
  TextColumn get safetyLevel => text().withDefault(const Constant('none'))();
  TextColumn get complianceTags => text().nullable()(); // JSON array

  // PROCEDURE METADATA
  IntColumn get estimatedTimeMinutes => integer().nullable()();
  TextColumn get requiredTools => text().nullable()(); // JSON array
  TextColumn get requiredParts => text().nullable()(); // JSON array
  TextColumn get prerequisites =>
      text().nullable()(); // Comma-separated entry IDs
  TextColumn get specialRequirements => text().nullable()();

  // CONTENT STRUCTURE
  TextColumn get symptoms => text().nullable()();
  IntColumn get solutionsCount => integer().withDefault(const Constant(1))();
  BoolColumn get hasImages => boolean().withDefault(const Constant(false))();
  BoolColumn get hasAttachments =>
      boolean().withDefault(const Constant(false))();

  // AUTHORING & QUALITY CONTROL
  TextColumn get author => text().nullable()();
  TextColumn get authorRole => text().nullable()();
  TextColumn get reviewer => text().nullable()();
  DateTimeColumn get reviewedAt => dateTime().nullable()();
  TextColumn get reviewStatus => text().withDefault(const Constant('draft'))();
  BoolColumn get approvalRequired =>
      boolean().withDefault(const Constant(false))();
  TextColumn get changeNotes => text().nullable()();

  // SOURCE & SYNC
  TextColumn get sourceType => text()();
  TextColumn get sourceFile => text()();
  TextColumn get externalId => text().nullable()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
  TextColumn get syncSource => text().nullable()();

  // VERSION CONTROL
  TextColumn get version => text()();
  TextColumn get status => text()();

  // TIMESTAMPS
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get publishedAt => dateTime().nullable()();
  DateTimeColumn get archivedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Knowledge Categories - Hierarchical taxonomy (3-level max)
class KnowledgeCategories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get slug => text().unique()();

  // HIERARCHY
  IntColumn get parentId =>
      integer().nullable().references(KnowledgeCategories, #id)();
  IntColumn get level => integer()(); // 1, 2, or 3
  TextColumn get path => text()(); // Materialized path: /parent/child

  // DISPLAY
  TextColumn get icon => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get color => text().nullable()();

  // ORDERING & STATUS
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get active => boolean().withDefault(const Constant(true))();

  // METADATA
  IntColumn get articleCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// Knowledge Tags - Flexible tagging system
class KnowledgeTags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  TextColumn get slug => text().unique()();
  TextColumn get color => text().nullable()();
  TextColumn get description => text().nullable()();
  IntColumn get usageCount => integer().withDefault(const Constant(0))();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// Entry Tags - Many-to-many junction for entries and tags
class EntryTags extends Table {
  TextColumn get entryId => text().references(KnowledgeEntries, #id)();
  IntColumn get tagId => integer().references(KnowledgeTags, #id)();
  DateTimeColumn get taggedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {entryId, tagId};
}

// Entry Metadata - Extended metadata and analytics
class EntryMetadata extends Table {
  TextColumn get entryId => text().references(KnowledgeEntries, #id)();

  // USAGE ANALYTICS
  IntColumn get viewCount => integer().withDefault(const Constant(0))();
  IntColumn get helpfulCount => integer().withDefault(const Constant(0))();
  IntColumn get notHelpfulCount => integer().withDefault(const Constant(0))();
  IntColumn get averageTimeSeconds => integer().nullable()();
  DateTimeColumn get lastViewedAt => dateTime().nullable()();

  // SEARCH ANALYTICS
  TextColumn get searchTermsFound => text().withDefault(const Constant('[]'))();
  IntColumn get searchResultClicks =>
      integer().withDefault(const Constant(0))();

  // QUALITY METRICS
  RealColumn get completenessScore => real().nullable()();
  BoolColumn get needsReview => boolean().withDefault(const Constant(false))();
  DateTimeColumn get nextReviewDue => dateTime().nullable()();

  // USER ENGAGEMENT
  IntColumn get uniqueViewers => integer().withDefault(const Constant(0))();
  IntColumn get returnVisitors => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {entryId};
}

// Knowledge Attachments - Images, PDFs, diagrams
class KnowledgeAttachments extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entryId => text().references(KnowledgeEntries, #id)();

  // FILE INFORMATION
  TextColumn get fileName => text()();
  TextColumn get filePath => text()();
  TextColumn get fileType => text()();
  IntColumn get fileSizeBytes => integer()();
  TextColumn get fileHash => text().nullable()();

  // METADATA
  TextColumn get altText => text().nullable()();
  TextColumn get caption => text().nullable()();
  IntColumn get displayOrder => integer().withDefault(const Constant(0))();

  // CATEGORIZATION
  TextColumn get attachmentType =>
      text()(); // diagram, photo, manual, reference
  BoolColumn get isInline => boolean().withDefault(const Constant(true))();

  // TIMESTAMPS
  DateTimeColumn get uploadedAt => dateTime()();
  TextColumn get uploadedBy => text().nullable()();
}

// Knowledge History - Audit trail of changes
class KnowledgeHistory extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entryId => text().references(KnowledgeEntries, #id)();

  // CHANGE TRACKING
  TextColumn get changeType => text()();
  TextColumn get fieldName => text().nullable()();
  TextColumn get oldValue => text().nullable()();
  TextColumn get newValue => text().nullable()();
  TextColumn get changeNotes => text().nullable()();

  // AUTHOR INFO
  TextColumn get changedBy => text()();
  TextColumn get changedByRole => text().nullable()();
  DateTimeColumn get changedAt => dateTime()();

  // VERSION INFO
  TextColumn get versionBefore => text().nullable()();
  TextColumn get versionAfter => text().nullable()();
}

// Knowledge Relations - Related articles
class KnowledgeRelations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get fromEntryId => text().references(KnowledgeEntries, #id)();
  TextColumn get toEntryId => text().references(KnowledgeEntries, #id)();

  // RELATIONSHIP TYPE
  TextColumn get relationType => text()();
  // Values: related, prerequisite, follow_up, supersedes, superseded_by, see_also

  // METADATA
  IntColumn get strength =>
      integer().withDefault(const Constant(50))(); // 0-100
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get createdBy => text().nullable()();
}

// Machine Profiles - Canonical equipment identity (one profile per make/model)
class MachineProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get equipmentType =>
      text()(); // 'counter', 'atm', 'dvr', 'lock', etc.
  TextColumn get manufacturer => text()();
  TextColumn get model => text()();
  TextColumn get aliases =>
      text().nullable()(); // JSON array of alternate names
  TextColumn get searchKeys => text().nullable()(); // Normalized lookup terms
  TextColumn get description => text().nullable()();
  TextColumn get imageAsset => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// Continuing Education Courses
class ContinuingEducationCourses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get provider => text()();
  TextColumn get description => text().nullable()();
  TextColumn get category =>
      text()(); // 'Technical', 'Safety', 'Compliance', 'HR'
  IntColumn get durationHours => integer().nullable()();
  TextColumn get externalUrl => text().nullable()();
}

// User Course Enrollments
class UserCourseEnrollments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer()();
  IntColumn get courseId => integer()();
  DateTimeColumn get enrolledAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  TextColumn get status => text()(); // 'enrolled', 'in_progress', 'completed'
}

// Expenses
class Expenses extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer()();
  DateTimeColumn get expenseDate => dateTime()();
  TextColumn get category =>
      text()(); // 'fuel', 'tolls', 'parking', 'meals', 'parts', 'other'
  RealColumn get amount => real()();
  TextColumn get description => text().nullable()();
  TextColumn get receiptPath => text().nullable()();
  IntColumn get workOrderId => integer().nullable()();
}

// ============================================
// DATABASE CLASS
// ============================================

@DriftDatabase(tables: [
  Clients,
  Sites,
  StartingPoints,
  Users,
  WeatherSnapshot,
  TrafficSnapshot,
  WorkCalls,
  IndustryBriefing,
  CompanyAnnouncements,
  WorkOrders,
  Appointments,
  Equipment,
  WorkOrderEquipment,
  WorkPerformed,
  PartsUsed,
  Notes,
  Documents,
  KnowledgeEntries,
  KnowledgeCategories,
  KnowledgeTags,
  EntryTags,
  EntryMetadata,
  KnowledgeAttachments,
  KnowledgeHistory,
  KnowledgeRelations,
  MachineProfiles,
  ContinuingEducationCourses,
  UserCourseEnrollments,
  Expenses,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 13; // V13: Breaking migration — clean schema

  // Breaking Migration Strategy — drops and recreates all tables
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          await initializeKnowledgeFTS5();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // Breaking migration: drop everything and recreate
          // This is intentional — confirmed as preferred approach for production reset
          await customStatement('PRAGMA foreign_keys = OFF');
          for (final table in allTables) {
            await customStatement(
                'DROP TABLE IF EXISTS "${table.actualTableName}"');
          }
          await customStatement('PRAGMA foreign_keys = ON');
          await m.createAll();
          await initializeKnowledgeFTS5();
        },
      );

  // ============================================
  // CLIENT QUERIES
  // ============================================

  Future<List<Client>> getAllClients() => select(clients).get();

  Future<Client?> getClientById(int id) =>
      (select(clients)..where((c) => c.id.equals(id))).getSingleOrNull();

  // ============================================
  // SITE QUERIES
  // ============================================

  Future<List<Site>> getAllSites() => select(sites).get();

  Future<List<Site>> getSitesByClient(int clientId) =>
      (select(sites)..where((s) => s.clientId.equals(clientId))).get();

  Future<Site?> getSiteById(int id) =>
      (select(sites)..where((s) => s.id.equals(id))).getSingleOrNull();

  Future<List<StartingPoint>> getAllStartingPoints() =>
      select(startingPoints).get();

  // ============================================
  // USER QUERIES
  // ============================================

  Future<List<User>> getAllUsers() => select(users).get();

  Future<User?> getUserById(int id) =>
      (select(users)..where((u) => u.id.equals(id))).getSingleOrNull();

  Future<User?> getUserByUsername(String username) =>
      (select(users)..where((u) => u.username.equals(username)))
          .getSingleOrNull();

  Stream<List<User>> watchAllUsers() =>
      (select(users)..orderBy([(t) => OrderingTerm.asc(t.fullName)])).watch();

  Future<void> updateUser(UsersCompanion user) =>
      (update(users)..where((u) => u.id.equals(user.id.value))).write(user);

  // ============================================
  // WEATHER QUERIES
  // ============================================

  Future<WeatherSnapshotData?> getLatestWeather() => (select(weatherSnapshot)
        ..orderBy([(t) => OrderingTerm.desc(t.fetchedAt)])
        ..limit(1))
      .getSingleOrNull();

  Stream<WeatherSnapshotData?> watchLatestWeather() => (select(weatherSnapshot)
        ..orderBy([(t) => OrderingTerm.desc(t.fetchedAt)])
        ..limit(1))
      .watchSingleOrNull();

  Future<void> insertWeather(WeatherSnapshotCompanion weather) =>
      into(weatherSnapshot).insert(weather, mode: InsertMode.replace);

  // ============================================
  // TRAFFIC QUERIES
  // ============================================

  Future<TrafficSnapshotData?> getLatestTraffic() => (select(trafficSnapshot)
        ..orderBy([(t) => OrderingTerm.desc(t.fetchedAt)])
        ..limit(1))
      .getSingleOrNull();

  Future<void> insertTraffic(TrafficSnapshotCompanion traffic) =>
      into(trafficSnapshot).insert(traffic, mode: InsertMode.replace);

  // ============================================
  // WORK CALLS QUERIES
  // ============================================

  Future<int> getOpenCallsCount() =>
      (select(workCalls)..where((w) => w.status.equals('open')))
          .get()
          .then((calls) => calls.length);

  Future<int> getCompletedCallsCount() {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    return (select(workCalls)
          ..where((w) =>
              w.status.equals('completed') &
              w.completedAt.isBiggerThanValue(startOfDay)))
        .get()
        .then((calls) => calls.length);
  }

  Future<int> getWeeklyCallsCount() {
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    return (select(workCalls)
          ..where((w) =>
              w.status.equals('completed') &
              w.completedAt.isBiggerThanValue(weekAgo)))
        .get()
        .then((calls) => calls.length);
  }

  Stream<int> watchOpenCallsCount() {
    return watchWorkCalls().map((calls) {
      return calls.where((c) => c.status == 'open').length;
    });
  }

  Stream<int> watchCompletedCallsCount() {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    return watchWorkCalls().map((calls) {
      return calls
          .where((c) =>
              c.status == 'completed' &&
              c.completedAt != null &&
              c.completedAt!.isAfter(startOfDay))
          .length;
    });
  }

  Stream<int> watchWeeklyCallsCount() {
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    return watchWorkCalls().map((calls) {
      return calls
          .where((c) =>
              c.status == 'completed' &&
              c.completedAt != null &&
              c.completedAt!.isAfter(weekAgo))
          .length;
    });
  }

  Future<void> insertWorkCall(WorkCallsCompanion workCall) =>
      into(workCalls).insert(workCall);

  Stream<List<WorkCall>> watchWorkCalls() =>
      (select(workCalls)..orderBy([(t) => OrderingTerm.desc(t.scheduledAt)]))
          .watch();

  // ============================================
  // INDUSTRY BRIEFING QUERIES
  // ============================================

  Future<List<IndustryBriefingData>> getLatestIndustryBriefing(
          {int limit = 5}) =>
      (select(industryBriefing)
            ..orderBy([(t) => OrderingTerm.desc(t.publishedAt)])
            ..limit(limit))
          .get();

  Stream<List<IndustryBriefingData>> watchLatestIndustryBriefing(
          {int limit = 5}) =>
      (select(industryBriefing)
            ..orderBy([(t) => OrderingTerm.desc(t.publishedAt)])
            ..limit(limit))
          .watch();

  Future<void> insertIndustryBriefing(IndustryBriefingCompanion briefing) =>
      into(industryBriefing).insert(briefing);

  // ============================================
  // COMPANY ANNOUNCEMENTS QUERIES
  // ============================================

  Stream<List<CompanyAnnouncement>> watchActiveCompanyAnnouncements() =>
      (select(companyAnnouncements)
            ..where((a) => a.active.equals(true))
            ..orderBy([(t) => OrderingTerm.desc(t.publishedAt)]))
          .watch();

  Future<List<CompanyAnnouncement>> getActiveCompanyAnnouncements() =>
      (select(companyAnnouncements)
            ..where((a) => a.active.equals(true))
            ..orderBy([(t) => OrderingTerm.desc(t.publishedAt)]))
          .get();

  Future<void> insertCompanyAnnouncement(
          CompanyAnnouncementsCompanion announcement) =>
      into(companyAnnouncements).insert(announcement);

  Future<void> updateAnnouncementAcknowledged(int id, bool acknowledged) =>
      (update(companyAnnouncements)..where((a) => a.id.equals(id)))
          .write(CompanyAnnouncementsCompanion(
        acknowledged: Value(acknowledged),
        acknowledgedAt: Value(acknowledged ? DateTime.now() : null),
      ));

  // ============================================
  // WORK ORDERS QUERIES
  // ============================================

  Future<List<WorkOrderWithDetails>> getWorkOrdersWithDetails(
      {String? statusFilter}) async {
    final query = select(workOrders)
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);

    if (statusFilter != null && statusFilter != 'all') {
      query.where((w) => w.status.equals(statusFilter));
    }

    final orders = await query.get();
    final results = <WorkOrderWithDetails>[];

    for (final order in orders) {
      final site = await getSiteById(order.siteId);
      if (site == null) continue;

      final client = await getClientById(site.clientId);
      if (client == null) continue;

      final equipment = await getEquipmentByWorkOrder(order.id);

      results.add(WorkOrderWithDetails(
        workOrder: order,
        site: site,
        client: client,
        equipment: equipment,
      ));
    }

    return results;
  }

  Future<void> insertWorkOrder(WorkOrdersCompanion workOrder) =>
      into(workOrders).insert(workOrder);

  Future<WorkOrder?> getWorkOrderById(int id) =>
      (select(workOrders)..where((w) => w.id.equals(id))).getSingleOrNull();

  Future<List<WorkOrder>> getAllWorkOrders() =>
      (select(workOrders)..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .get();

  Future<List<WorkOrder>> getWorkOrdersBySite(int siteId) => (select(workOrders)
        ..where((w) => w.siteId.equals(siteId))
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
      .get();

  Future<List<WorkOrder>> getWorkOrdersPaged({
    required int limit,
    required int offset,
    String? status,
  }) {
    final query = select(workOrders)
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
      ..limit(limit, offset: offset);

    if (status != null && status != 'all') {
      query.where((w) => w.status.equals(status));
    }

    return query.get();
  }

  Future<List<WorkOrderWithDetails>> getWorkOrdersWithDetailsPaged({
    required int limit,
    required int offset,
    String? status,
  }) async {
    final orders = await getWorkOrdersPaged(
      limit: limit,
      offset: offset,
      status: status,
    );

    final results = <WorkOrderWithDetails>[];
    for (final order in orders) {
      final site = await getSiteById(order.siteId);
      if (site == null) continue;

      final client = await getClientById(site.clientId);
      if (client == null) continue;

      final equipment = await getEquipmentByWorkOrder(order.id);

      results.add(WorkOrderWithDetails(
        workOrder: order,
        site: site,
        client: client,
        equipment: equipment,
      ));
    }

    return results;
  }

  Future<List<WorkOrderEquipmentData>> getAllWorkOrderEquipmentLinks() =>
      select(workOrderEquipment).get();

  Future<void> linkEquipmentToWorkOrder(int workOrderId, int equipmentId) =>
      into(workOrderEquipment).insert(WorkOrderEquipmentCompanion.insert(
        workOrderId: workOrderId,
        equipmentId: equipmentId,
      ));

  // ============================================
  // EQUIPMENT QUERIES
  // ============================================

  Future<List<EquipmentData>> getAllEquipment() => select(equipment).get();

  Stream<List<EquipmentData>> watchAllEquipment() =>
      (select(equipment)..orderBy([(t) => OrderingTerm.asc(t.equipmentType)]))
          .watch();

  Future<List<EquipmentData>> getEquipmentBySite(int siteId) =>
      (select(equipment)..where((e) => e.siteId.equals(siteId))).get();

  Future<List<EquipmentData>> getEquipmentByWorkOrder(int workOrderId) async {
    final equipmentIds = await (select(workOrderEquipment)
          ..where((w) => w.workOrderId.equals(workOrderId)))
        .get()
        .then((list) => list.map((e) => e.equipmentId).toList());

    if (equipmentIds.isEmpty) return [];

    return (select(equipment)..where((e) => e.id.isIn(equipmentIds))).get();
  }

  Stream<List<String>> watchDistinctEquipmentTypes() {
    return watchAllEquipment().map((equipment) {
      return equipment.map((e) => e.equipmentType).toSet().toList()..sort();
    });
  }

  Future<EquipmentData?> getEquipmentById(int id) =>
      (select(equipment)..where((e) => e.id.equals(id))).getSingleOrNull();

  Future<EquipmentData?> getEquipmentBySerial(String serialNumber) =>
      (select(equipment)..where((e) => e.serialNumber.equals(serialNumber)))
          .getSingleOrNull();

  // ============================================
  // MACHINE PROFILE QUERIES
  // ============================================

  Future<List<MachineProfile>> getAllMachineProfiles() =>
      (select(machineProfiles)
            ..orderBy([(t) => OrderingTerm.asc(t.equipmentType)]))
          .get();

  Stream<List<MachineProfile>> watchAllMachineProfiles() =>
      (select(machineProfiles)
            ..orderBy([(t) => OrderingTerm.asc(t.equipmentType)]))
          .watch();

  Future<MachineProfile?> getMachineProfileById(int id) =>
      (select(machineProfiles)..where((m) => m.id.equals(id)))
          .getSingleOrNull();

  Future<MachineProfile?> getMachineProfileByTypeAndModel(
          String type, String manufacturer, String model) =>
      (select(machineProfiles)
            ..where((m) =>
                m.equipmentType.equals(type) &
                m.manufacturer.equals(manufacturer) &
                m.model.equals(model)))
          .getSingleOrNull();

  Future<int> insertMachineProfile(MachineProfilesCompanion profile) =>
      into(machineProfiles).insert(profile);

  Future<List<EquipmentData>> getEquipmentByMachineProfile(int profileId) =>
      (select(equipment)..where((e) => e.machineProfileId.equals(profileId)))
          .get();

  Future<List<KnowledgeEntry>> getKnowledgeByMachineProfile(int profileId) =>
      (select(knowledgeEntries)
            ..where((k) => k.machineProfileId.equals(profileId)))
          .get();

  Future<List<WorkPerformedData>> getWorkPerformedByWorkOrder(
          int workOrderId) =>
      (select(workPerformed)
            ..where((w) => w.workOrderId.equals(workOrderId))
            ..orderBy([(t) => OrderingTerm.desc(t.startedAt)]))
          .get();

  Future<List<WorkPerformedData>> getWorkPerformedBySite(int siteId) async {
    final workOrders = await getWorkOrdersBySite(siteId);
    final workOrderIds = workOrders.map((wo) => wo.id).toList();
    if (workOrderIds.isEmpty) return [];

    return (select(workPerformed)
          ..where((w) => w.workOrderId.isIn(workOrderIds))
          ..orderBy([(t) => OrderingTerm.desc(t.startedAt)]))
        .get();
  }

  Future<List<Note>> getNotesByWorkOrder(int workOrderId) => (select(notes)
        ..where((n) => n.workOrderId.equals(workOrderId))
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
      .get();

  // ============================================
  // APPOINTMENTS QUERIES
  // ============================================

  Future<List<Appointment>> getAppointmentsByWorkOrder(int workOrderId) =>
      (select(appointments)
            ..where((a) => a.workOrderId.equals(workOrderId))
            ..orderBy([(t) => OrderingTerm.asc(t.scheduledStart)]))
          .get();

  Future<void> insertAppointment(AppointmentsCompanion appointment) =>
      into(appointments).insert(appointment);

  // ============================================
  // DOCUMENTS QUERIES
  // ============================================

  Future<List<Document>> getDocumentsBySite(int siteId) => (select(documents)
        ..where((d) => d.siteId.equals(siteId))
        ..orderBy([(t) => OrderingTerm.desc(t.uploadedAt)]))
      .get();

  Future<void> insertDocument(DocumentsCompanion document) =>
      into(documents).insert(document);

  // ============================================
  // SITE UPDATE QUERIES
  // ============================================

  Future<void> updateSite(SitesCompanion site) =>
      (update(sites)..where((s) => s.id.equals(site.id.value))).write(site);

  // ============================================
  // KNOWLEDGE ENTRIES QUERIES
  // ============================================

  Future<List<KnowledgeEntry>> getAllKnowledgeEntries() =>
      (select(knowledgeEntries)..orderBy([(t) => OrderingTerm.asc(t.title)]))
          .get();

  Future<List<KnowledgeEntry>> getKnowledgeEntriesByCategory(String category) =>
      (select(knowledgeEntries)
            ..where((k) => k.category.equals(category))
            ..orderBy([(t) => OrderingTerm.asc(t.title)]))
          .get();

  Future<List<String>> getDistinctCategories() async {
    final entries = await getAllKnowledgeEntries();
    return entries.map((e) => e.category).toSet().toList()..sort();
  }

  Stream<List<KnowledgeEntry>> watchAllKnowledgeEntries() =>
      (select(knowledgeEntries)
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .watch();

  Stream<List<String>> watchDistinctCategories() {
    return watchAllKnowledgeEntries().map((entries) {
      return entries.map((e) => e.category).toSet().toList()..sort();
    });
  }

  Stream<List<String>> watchDistinctKnowledgeEquipmentTypes() {
    return watchAllKnowledgeEntries().map((entries) {
      return entries.map((e) => e.equipmentType).toSet().toList()..sort();
    });
  }

  Stream<List<KnowledgeEntry>> watchKnowledgeEntriesByCategory(
          String category) =>
      (select(knowledgeEntries)
            ..where((k) => k.category.equals(category))
            ..orderBy([(t) => OrderingTerm.asc(t.title)]))
          .watch();

  Stream<List<KnowledgeEntry>> watchKnowledgeEntriesByEquipment(
          String equipmentType) =>
      (select(knowledgeEntries)
            ..where((k) => k.equipmentType.equals(equipmentType))
            ..orderBy([(t) => OrderingTerm.asc(t.title)]))
          .watch();

  Future<List<KnowledgeEntry>> searchKnowledge(String keyword) {
    final lowerKeyword = keyword.toLowerCase();
    return (select(knowledgeEntries)
          ..where((k) =>
              k.title.lower().contains(lowerKeyword) |
              k.content.lower().contains(lowerKeyword) |
              k.category.lower().contains(lowerKeyword))
          ..orderBy([(t) => OrderingTerm.asc(t.title)]))
        .get();
  }

  Future<KnowledgeEntry?> getKnowledgeByTitle(String title) =>
      (select(knowledgeEntries)..where((k) => k.title.equals(title)))
          .getSingleOrNull();

  Future<KnowledgeEntry?> getKnowledgeEntryById(String id) =>
      (select(knowledgeEntries)..where((k) => k.id.equals(id)))
          .getSingleOrNull();

  Future<void> insertOrReplaceKnowledge(KnowledgeEntriesCompanion entry) =>
      into(knowledgeEntries).insert(entry, mode: InsertMode.replace);

  Future<void> clearAllKnowledgeEntries() => delete(knowledgeEntries).go();

  // ============================================
  // ENHANCED KNOWLEDGE BASE - FTS5 SEARCH
  // ============================================

  /// Initialize FTS5 virtual table and triggers for knowledge base search
  Future<void> initializeKnowledgeFTS5() async {
    // Create FTS5 virtual table
    await customStatement('''
      CREATE VIRTUAL TABLE IF NOT EXISTS knowledge_fts USING fts5(
        title,
        content,
        summary,
        category,
        equipment_type,
        manufacturer,
        symptoms,
        tags,
        tokenize='porter unicode61 remove_diacritics 1',
        prefix='2 3 4',
        content='knowledge_entries',
        content_rowid='rowid'
      );
    ''');

    // Create triggers to keep FTS5 in sync
    await customStatement('''
      CREATE TRIGGER IF NOT EXISTS knowledge_fts_insert AFTER INSERT ON knowledge_entries
      BEGIN
        INSERT INTO knowledge_fts(
          rowid, title, content, summary, category, 
          equipment_type, manufacturer, symptoms, tags
        )
        VALUES (
          new.rowid,
          new.title,
          new.content,
          COALESCE(new.summary, ''),
          new.category,
          new.equipment_type,
          COALESCE(new.manufacturer, ''),
          COALESCE(new.symptoms, ''),
          ''
        );
      END;
    ''');

    await customStatement('''
      CREATE TRIGGER IF NOT EXISTS knowledge_fts_update AFTER UPDATE ON knowledge_entries
      BEGIN
        UPDATE knowledge_fts 
        SET 
          title = new.title,
          content = new.content,
          summary = COALESCE(new.summary, ''),
          category = new.category,
          equipment_type = new.equipment_type,
          manufacturer = COALESCE(new.manufacturer, ''),
          symptoms = COALESCE(new.symptoms, '')
        WHERE rowid = new.rowid;
      END;
    ''');

    await customStatement('''
      CREATE TRIGGER IF NOT EXISTS knowledge_fts_delete AFTER DELETE ON knowledge_entries
      BEGIN
        DELETE FROM knowledge_fts WHERE rowid = old.rowid;
      END;
    ''');

    // Populate FTS5 from existing data (if any)
    try {
      await customStatement('''
        INSERT INTO knowledge_fts(rowid, title, content, summary, category, equipment_type, manufacturer, symptoms, tags)
        SELECT 
          rowid,
          title,
          content,
          COALESCE(summary, SUBSTR(content, 1, 200), ''),
          category,
          equipment_type,
          COALESCE(manufacturer, ''),
          COALESCE(symptoms, ''),
          ''
        FROM knowledge_entries
        WHERE rowid NOT IN (SELECT rowid FROM knowledge_fts);
      ''');
    } catch (e) {
      // FTS5 might already be populated, ignore error
      print('FTS5 populate info: $e');
    }
  }

  /// Enhanced search using FTS5 with ranking and highlighting
  Future<List<KnowledgeSearchResult>> searchKnowledgeFTS5(
    String query, {
    String? equipmentFilter,
    String? categoryFilter,
    String? difficultyFilter,
    String? safetyFilter,
    int limit = 50,
  }) async {
    if (query.trim().isEmpty) {
      return [];
    }

    // Build FTS5 query with filters
    final StringBuffer whereClause = StringBuffer('kf MATCH ?');
    final List<Variable> vars = [Variable.withString(query)];

    if (equipmentFilter != null && equipmentFilter.isNotEmpty) {
      whereClause.write(' AND ke.equipment_type = ?');
      vars.add(Variable.withString(equipmentFilter));
    }

    if (categoryFilter != null && categoryFilter.isNotEmpty) {
      whereClause.write(' AND ke.category = ?');
      vars.add(Variable.withString(categoryFilter));
    }

    if (difficultyFilter != null && difficultyFilter.isNotEmpty) {
      whereClause.write(' AND ke.difficulty_level = ?');
      vars.add(Variable.withString(difficultyFilter));
    }

    if (safetyFilter != null && safetyFilter.isNotEmpty) {
      whereClause.write(' AND ke.safety_level = ?');
      vars.add(Variable.withString(safetyFilter));
    }

    final results = await customSelect(
      '''
      SELECT 
        ke.id,
        bm25(kf) as relevance_score,
        snippet(kf, 1, '<mark>', '</mark>', '...', 32) as content_snippet,
        highlight(kf, 0, '<mark>', '</mark>') as highlighted_title
      FROM knowledge_entries ke
      JOIN knowledge_fts kf ON ke.rowid = kf.rowid
      WHERE $whereClause
      ORDER BY bm25(kf) ASC
      LIMIT ?
      ''',
      variables: [...vars, Variable.withInt(limit)],
      readsFrom: {knowledgeEntries},
    ).get();

    // Fetch full entries separately
    final searchResults = <KnowledgeSearchResult>[];
    for (final row in results) {
      final entryId = row.read<String>('id');
      final entry = await getKnowledgeEntryById(entryId);

      if (entry != null) {
        searchResults.add(KnowledgeSearchResult(
          entry: entry,
          relevanceScore: row.read<double>('relevance_score'),
          contentSnippet: row.read<String>('content_snippet'),
          highlightedTitle: row.read<String>('highlighted_title'),
        ));
      }
    }

    return searchResults;
  }

  /// Get autocomplete suggestions based on FTS5 prefix matching
  Future<List<String>> getSearchSuggestions(String prefix,
      {int limit = 10}) async {
    if (prefix.length < 2) return [];

    final results = await customSelect(
      '''
      SELECT DISTINCT title
      FROM knowledge_entries ke
      JOIN knowledge_fts kf ON ke.rowid = kf.rowid
      WHERE kf MATCH ?
      ORDER BY bm25(kf) ASC
      LIMIT ?
      ''',
      variables: [
        Variable.withString('$prefix*'),
        Variable.withInt(limit),
      ],
      readsFrom: {knowledgeEntries},
    ).get();

    return results.map((row) => row.read<String>('title')).toList();
  }

  /// Track article view for analytics
  Future<void> trackArticleView(String entryId) async {
    await customStatement('''
      INSERT INTO entry_metadata(entry_id, view_count, last_viewed_at)
      VALUES (?, 1, datetime('now'))
      ON CONFLICT(entry_id) DO UPDATE SET
        view_count = view_count + 1,
        last_viewed_at = datetime('now');
    ''', [Variable.withString(entryId)]);
  }

  /// Record helpful/not helpful feedback
  Future<void> recordArticleFeedback(String entryId, bool isHelpful) async {
    final field = isHelpful ? 'helpful_count' : 'not_helpful_count';
    await customStatement('''
      INSERT INTO entry_metadata(entry_id, $field)
      VALUES (?, 1)
      ON CONFLICT(entry_id) DO UPDATE SET
        $field = $field + 1;
    ''', [Variable.withString(entryId)]);
  }

  /// Get related articles
  Future<List<KnowledgeEntry>> getRelatedArticles(String entryId,
      {int limit = 5}) async {
    final results = await customSelect(
      '''
      SELECT ke.id
      FROM knowledge_entries ke
      JOIN knowledge_relations kr ON ke.id = kr.to_entry_id
      WHERE kr.from_entry_id = ?
        AND kr.relation_type IN ('related', 'see_also', 'follow_up')
      ORDER BY kr.strength DESC
      LIMIT ?
      ''',
      variables: [Variable.withString(entryId), Variable.withInt(limit)],
      readsFrom: {knowledgeEntries, knowledgeRelations},
    ).get();

    // Fetch full entries
    final entries = <KnowledgeEntry>[];
    for (final row in results) {
      final entry = await getKnowledgeEntryById(row.read<String>('id'));
      if (entry != null) entries.add(entry);
    }

    return entries;
  }

  /// Get category hierarchy
  Future<List<KnowledgeCategory>> getTopLevelCategories() {
    return (select(knowledgeCategories)
          ..where((c) =>
              c.parentId.isNull() & c.level.equals(1) & c.active.equals(true))
          ..orderBy([(c) => OrderingTerm.asc(c.sortOrder)]))
        .get();
  }

  Future<List<KnowledgeCategory>> getChildCategories(int parentId) {
    return (select(knowledgeCategories)
          ..where((c) => c.parentId.equals(parentId) & c.active.equals(true))
          ..orderBy([(c) => OrderingTerm.asc(c.sortOrder)]))
        .get();
  }

  /// Get category breadcrumb path
  Future<List<KnowledgeCategory>> getCategoryBreadcrumb(int categoryId) async {
    final breadcrumb = <KnowledgeCategory>[];
    int? currentId = categoryId;

    while (currentId != null) {
      final category = await (select(knowledgeCategories)
            ..where((c) => c.id.equals(currentId!)))
          .getSingleOrNull();

      if (category == null) break;

      breadcrumb.insert(0, category);
      currentId = category.parentId;
    }

    return breadcrumb;
  }

  /// Get tags for an entry
  Future<List<KnowledgeTag>> getEntryTags(String entryId) async {
    final results = await customSelect(
      '''
      SELECT kt.id
      FROM knowledge_tags kt
      JOIN entry_tags et ON kt.id = et.tag_id
      WHERE et.entry_id = ?
      ORDER BY kt.name
      ''',
      variables: [Variable.withString(entryId)],
      readsFrom: {knowledgeTags, entryTags},
    ).get();

    // Fetch full tag objects
    final tags = <KnowledgeTag>[];
    for (final row in results) {
      final tagId = row.read<int>('id');
      final tag = await (select(knowledgeTags)
            ..where((t) => t.id.equals(tagId)))
          .getSingleOrNull();
      if (tag != null) tags.add(tag);
    }

    return tags;
  }

  /// Get attachments for an entry
  Future<List<KnowledgeAttachment>> getEntryAttachments(String entryId) {
    return (select(knowledgeAttachments)
          ..where((a) => a.entryId.equals(entryId))
          ..orderBy([(a) => OrderingTerm.asc(a.displayOrder)]))
        .get();
  }

  /// Get metadata for an entry
  Future<EntryMetadataData?> getEntryMetadata(String entryId) =>
      (select(entryMetadata)..where((m) => m.entryId.equals(entryId)))
          .getSingleOrNull();

  /// Get change history for an entry
  Future<List<KnowledgeHistoryData>> getEntryHistory(String entryId) {
    return (select(knowledgeHistory)
          ..where((h) => h.entryId.equals(entryId))
          ..orderBy([(h) => OrderingTerm.desc(h.changedAt)]))
        .get();
  }

  /// Optimize FTS5 index (run periodically)
  Future<void> optimizeKnowledgeFTS5() async {
    await customStatement(
        "INSERT INTO knowledge_fts(knowledge_fts) VALUES('optimize')");
  }

  // ============================================
  // CONTINUING EDUCATION QUERIES
  // ============================================

  Stream<List<ContinuingEducationCourse>> watchAllCourses() =>
      (select(continuingEducationCourses)
            ..orderBy([(t) => OrderingTerm.asc(t.title)]))
          .watch();

  Stream<List<ContinuingEducationCourse>> watchCoursesByCategory(
          String category) =>
      (select(continuingEducationCourses)
            ..where((c) => c.category.equals(category))
            ..orderBy([(t) => OrderingTerm.asc(t.title)]))
          .watch();

  Future<ContinuingEducationCourse?> getCourseById(int id) =>
      (select(continuingEducationCourses)..where((c) => c.id.equals(id)))
          .getSingleOrNull();

  Stream<List<UserCourseEnrollment>> watchUserEnrollments(int userId) =>
      (select(userCourseEnrollments)
            ..where((e) => e.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.enrolledAt)]))
          .watch();

  Future<UserCourseEnrollment?> getUserEnrollment(int userId, int courseId) =>
      (select(userCourseEnrollments)
            ..where(
                (e) => e.userId.equals(userId) & e.courseId.equals(courseId)))
          .getSingleOrNull();

  Future<void> insertCourse(ContinuingEducationCoursesCompanion course) =>
      into(continuingEducationCourses).insert(course);

  Future<void> insertOrUpdateEnrollment(
          UserCourseEnrollmentsCompanion enrollment) =>
      into(userCourseEnrollments)
          .insert(enrollment, mode: InsertMode.insertOrReplace);

  // ============================================
  // EXPENSES QUERIES (STUB - to be expanded later)
  // ============================================

  Stream<List<Expense>> watchUserExpenses(int userId) => (select(expenses)
        ..where((e) => e.userId.equals(userId))
        ..orderBy([(t) => OrderingTerm.desc(t.expenseDate)]))
      .watch();

  Future<void> insertExpense(ExpensesCompanion expense) =>
      into(expenses).insert(expense);
}

// ============================================
// DATA CLASSES FOR JOINED QUERIES
// ============================================

class WorkOrderWithDetails {
  final WorkOrder workOrder;
  final Site site;
  final Client client;
  final List<EquipmentData> equipment;

  WorkOrderWithDetails({
    required this.workOrder,
    required this.site,
    required this.client,
    this.equipment = const [],
  });
}

// ============================================
// KNOWLEDGE BASE HELPER CLASSES
// ============================================

/// Search result with FTS5 ranking and highlighting
class KnowledgeSearchResult {
  final KnowledgeEntry entry;
  final double relevanceScore; // BM25 score (lower is better)
  final String contentSnippet; // Highlighted snippet with <mark> tags
  final String highlightedTitle; // Title with <mark> tags

  KnowledgeSearchResult({
    required this.entry,
    required this.relevanceScore,
    required this.contentSnippet,
    required this.highlightedTitle,
  });
}

/// Category with its children for hierarchical navigation
class CategoryWithChildren {
  final KnowledgeCategory category;
  final List<KnowledgeCategory> children;
  final int articleCount;

  CategoryWithChildren({
    required this.category,
    required this.children,
    this.articleCount = 0,
  });
}

/// Entry with full metadata and relationships
class EnhancedKnowledgeEntry {
  final KnowledgeEntry entry;
  final EntryMetadataData? metadata;
  final List<KnowledgeTag> tags;
  final List<KnowledgeAttachment> attachments;
  final List<KnowledgeCategory> categoryPath; // Breadcrumb
  final List<KnowledgeEntry> relatedArticles;

  EnhancedKnowledgeEntry({
    required this.entry,
    this.metadata,
    this.tags = const [],
    this.attachments = const [],
    this.categoryPath = const [],
    this.relatedArticles = const [],
  });
}

// ============================================
// DATABASE CONNECTION
// ============================================

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'portal_offline.sqlite'));

    // Setup sqlite3 for Windows
    if (Platform.isWindows) {
      sqlite3.tempDirectory = (await getTemporaryDirectory()).path;
    }

    return NativeDatabase.createInBackground(file);
  });
}
