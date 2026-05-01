import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../database/app_database.dart';
import '../../theme/app_theme.dart';
import 'package:intl/intl.dart';
import 'create_work_order_sheet.dart';
import '../../widgets/glass_card.dart';

class WorkView extends StatefulWidget {
  const WorkView({super.key});

  @override
  State<WorkView> createState() => _WorkViewState();
}

class _WorkViewState extends State<WorkView> {
  // Pagination State
  final List<WorkOrderWithDetails> _pagedItems = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 0;
  static const int _pageSize = 20;
  final ScrollController _scrollController = ScrollController();

  String _filterStatus = 'all'; // 'all', 'open', 'on_hold', 'completed'

  @override
  void initState() {
    super.initState();
    _loadData(refresh: true);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoading && _hasMore) {
        _loadData();
      }
    }
  }

  Future<void> _loadData({bool refresh = false}) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      if (refresh) {
        _pagedItems.clear();
        _currentPage = 0;
        _hasMore = true;
      }
    });

    try {
      final db = context.read<AppDatabase>();

      final newItems = await db.getWorkOrdersWithDetailsPaged(
        limit: _pageSize,
        offset: _currentPage * _pageSize,
        status: _filterStatus,
      );

      if (!mounted) return;

      setState(() {
        if (newItems.length < _pageSize) {
          _hasMore = false;
        }
        _pagedItems.addAll(newItems);
        _currentPage++;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      // In production use Logger
      debugPrint('Error loading paged work orders: $e');
    }
  }

  void _updateFilter(String status) {
    if (_filterStatus != status) {
      setState(() {
        _filterStatus = status;
      });
      _loadData(refresh: true);
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return AppColors.primary;
      case 'on_hold':
        return AppColors.warning;
      case 'completed':
        return AppColors.success;
      default:
        return AppColors.textSecondary;
    }
  }

  Color _getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'blue':
        return AppColors.pinRBFCU;
      case 'red':
        return AppColors.pinProsperity;
      case 'yellow':
        return AppColors.pinJefferson;
      default:
        return AppColors.textSecondary;
    }
  }

  String _getPriorityLabel(String? priority) {
    if (priority == null) return '';
    return priority.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Work Orders'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.border)),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Create Work Order',
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const CreateWorkOrderSheet(),
              ).then((_) {
                // Refresh the list after creating a work order
                _loadData(refresh: true);
              });
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppGradients.deepOcean,
        ),
        child: Column(
          children: [
            // Filter chips
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: AppColors.surface,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('All', 'all'),
                    const SizedBox(width: 8),
                    _buildFilterChip('Open', 'open'),
                    const SizedBox(width: 8),
                    _buildFilterChip('On Hold', 'on_hold'),
                    const SizedBox(width: 8),
                    _buildFilterChip('Completed', 'completed'),
                  ],
                ),
              ),
            ),
            // Work orders list
            Expanded(
              child: _pagedItems.isEmpty && !_isLoading
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.work_outline,
                              size: 64, color: Colors.grey[600]),
                          const SizedBox(height: 16),
                          Text(
                            'No work orders found',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: _pagedItems.length + (_isLoading ? 1 : 0),
                      padding: const EdgeInsets.all(16),
                      itemBuilder: (context, index) {
                        if (index == _pagedItems.length) {
                          return const Center(
                              child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(),
                          ));
                        }

                        final item = _pagedItems[index];
                        final workOrder = item.workOrder;
                        final site = item.site;
                        final client = item.client;
                        final equipment = item.equipment;

                        final clientColor =
                            _getColorFromString(client.themeColor);
                        final statusColor = _getStatusColor(workOrder.status);

                        return GlassCard(
                          margin: const EdgeInsets.only(bottom: 12),
                          // Active border for active status
                          activeBorderColor: workOrder.status == 'open'
                              ? AppColors.primary.withValues(alpha: 0.3)
                              : null,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                        color:
                                            statusColor.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: statusColor.withValues(
                                              alpha: 0.3),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: statusColor.withValues(
                                                alpha: 0.1),
                                            blurRadius: 8,
                                            spreadRadius: -2,
                                          )
                                        ]),
                                    child: Text(
                                      workOrder.status.toUpperCase(),
                                      style: TextStyle(
                                          color: statusColor,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              color: statusColor.withValues(
                                                  alpha: 0.5),
                                              blurRadius: 4,
                                            )
                                          ]),
                                    ),
                                  ),
                                  if (workOrder.priority != null) ...[
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: AppColors.warning
                                            .withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            color: AppColors.warning
                                                .withValues(alpha: 0.3)),
                                      ),
                                      child: Text(
                                        _getPriorityLabel(workOrder.priority),
                                        style: const TextStyle(
                                          color: AppColors.warning,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                  const Spacer(),
                                  Text(
                                    'WO-${workOrder.id}',
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              ...[
                                Row(
                                  children: [
                                    Icon(Icons.location_on,
                                        size: 16, color: clientColor),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        site.branchName,
                                        style: const TextStyle(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  client.name,
                                  style: TextStyle(
                                    color: clientColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                              if (workOrder.descriptionOfWork != null &&
                                  workOrder.descriptionOfWork!.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                Text(
                                  workOrder.descriptionOfWork!,
                                  style: const TextStyle(
                                      color: AppColors.textSecondary),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                              if (equipment.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 8,
                                  children: equipment.map((eq) {
                                    return Chip(
                                      label: Text(
                                        '${eq.equipmentType} ${eq.serialNumber ?? ""}',
                                        style: const TextStyle(fontSize: 11),
                                      ),
                                      backgroundColor: AppColors.background,
                                      labelStyle: const TextStyle(
                                          color: AppColors.textSecondary),
                                    );
                                  }).toList(),
                                ),
                              ],
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  if (workOrder.assignedTechnician != null) ...[
                                    Icon(Icons.person,
                                        size: 14,
                                        color: AppColors.textTertiary),
                                    const SizedBox(width: 4),
                                    Text(
                                      workOrder.assignedTechnician!,
                                      style: TextStyle(
                                          color: AppColors.textTertiary,
                                          fontSize: 12),
                                    ),
                                    const SizedBox(width: 16),
                                  ],
                                  Icon(Icons.calendar_today,
                                      size: 14, color: AppColors.textTertiary),
                                  const SizedBox(width: 4),
                                  Text(
                                    DateFormat('MMM d, y')
                                        .format(workOrder.createdAt),
                                    style: TextStyle(
                                        color: AppColors.textTertiary,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ), // Column
                        ); // GlassCard
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _filterStatus == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          _updateFilter(value);
        }
      },
      selectedColor: AppColors.primary,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  // ignore: unused_element
  Future<void> _showWorkOrderDetails(
    BuildContext context,
    WorkOrder workOrder,
    Site? site,
    Client? client,
    List<EquipmentData> equipment,
  ) async {
    final db = context.read<AppDatabase>();

    // Load related data
    final appointments = await db.getAppointmentsByWorkOrder(workOrder.id);
    final workPerformed = await db.getWorkPerformedByWorkOrder(workOrder.id);
    final notes = await db.getNotesByWorkOrder(workOrder.id);

    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: AppColors.surface,
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Work Order WO-${workOrder.id}',
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (site != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              site.branchName,
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                          ],
                        ],
                      ),
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.close, color: AppColors.textPrimary),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const Divider(height: 32),

                // Status & Priority
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildStatusBadge(workOrder.status),
                    if (workOrder.priority != null)
                      _buildPriorityBadge(workOrder.priority!),
                  ],
                ),
                const SizedBox(height: 24),

                // Description
                if (workOrder.descriptionOfWork != null &&
                    workOrder.descriptionOfWork!.isNotEmpty) ...[
                  const Text('Description',
                      style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(workOrder.descriptionOfWork!,
                      style: const TextStyle(color: AppColors.textSecondary)),
                  const SizedBox(height: 24),
                ],

                // Equipment
                if (equipment.isNotEmpty) ...[
                  const Text('Equipment',
                      style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ...equipment.map((eq) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          '${eq.equipmentType} - ${eq.manufacturer ?? ""} ${eq.model ?? ""} (S/N: ${eq.serialNumber ?? "N/A"})',
                          style:
                              const TextStyle(color: AppColors.textSecondary),
                        ),
                      )),
                  const SizedBox(height: 24),
                ],

                // Appointments
                if (appointments.isNotEmpty) ...[
                  const Text('Appointments',
                      style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ...appointments.map((apt) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          '${DateFormat('MMM d, y h:mm a').format(apt.scheduledStart)} - ${apt.technician ?? "Unassigned"}',
                          style:
                              const TextStyle(color: AppColors.textSecondary),
                        ),
                      )),
                  const SizedBox(height: 24),
                ],

                // Work Performed
                if (workPerformed.isNotEmpty) ...[
                  const Text('Work Performed',
                      style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ...workPerformed.map((wp) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    wp.technician,
                                    style: const TextStyle(
                                        color: AppColors.textPrimary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  Text(
                                    DateFormat('MMM d, h:mm a')
                                        .format(wp.startedAt),
                                    style: TextStyle(
                                        color: AppColors.textTertiary,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                              if (wp.workDescription != null &&
                                  wp.workDescription!.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                Text(wp.workDescription!,
                                    style: const TextStyle(
                                        color: AppColors.textSecondary)),
                              ],
                              if (wp.resolution != null &&
                                  wp.resolution!.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                Text('Resolution: ${wp.resolution!}',
                                    style: TextStyle(color: AppColors.success)),
                              ],
                              if (wp.repeatIssue) ...[
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.warning
                                        .withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'REPEAT ISSUE',
                                    style: TextStyle(
                                        color: AppColors.warning,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      )),
                  const SizedBox(height: 24),
                ],

                // Notes
                if (notes.isNotEmpty) ...[
                  const Text('Notes',
                      style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ...notes.map((note) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    note.noteType.toUpperCase(),
                                    style: TextStyle(
                                      color: note.noteType == 'warning'
                                          ? AppColors.error
                                          : AppColors.primary,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    DateFormat('MMM d').format(note.createdAt),
                                    style: TextStyle(
                                        color: AppColors.textTertiary,
                                        fontSize: 11),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(note.noteText,
                                  style: const TextStyle(
                                      color: AppColors.textSecondary)),
                            ],
                          ),
                        ),
                      )),
                ],

                // Internal Notes
                if (workOrder.internalNotes != null &&
                    workOrder.internalNotes!.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  const Text('Internal Notes',
                      style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(workOrder.internalNotes!,
                        style: const TextStyle(color: AppColors.textSecondary)),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final color = _getStatusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color),
      ),
      child: Text(
        status.toUpperCase(),
        style:
            TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildPriorityBadge(String priority) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        priority.toUpperCase(),
        style: const TextStyle(
            color: AppColors.warning,
            fontSize: 12,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
