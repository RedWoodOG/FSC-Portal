import 'package:flutter/material.dart';
import '../../widgets/job_card.dart';

class WorkOrdersScreen extends StatelessWidget {
  const WorkOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: const [
        JobCard(
          jobId: 'WO-88421',
          clientName: 'Secure Storage Inc.',
          location: 'Vault Area B',
          priority: 'High',
          status: 'Open',
          scheduledTime: 'Unscheduled',
        ),
        SizedBox(height: 16),
        JobCard(
          jobId: 'WO-88422',
          clientName: 'Regional Bank Tower',
          location: 'Floor 12',
          priority: 'Medium',
          status: 'Open',
          scheduledTime: 'Unscheduled',
        ),
        SizedBox(height: 16),
        JobCard(
          jobId: 'WO-88423',
          clientName: 'City Credit Union',
          location: 'Drive-Through Lane 2',
          priority: 'Low',
          status: 'Open',
          scheduledTime: 'Unscheduled',
        ),
      ],
    );
  }
}
