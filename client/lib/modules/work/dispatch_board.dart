import 'package:flutter/material.dart';
import '../../widgets/job_card.dart';

class DispatchBoardScreen extends StatelessWidget {
  const DispatchBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: const [
        JobCard(
          jobId: 'URGENT-001',
          clientName: 'Emergency Call',
          location: 'First National - Main Branch',
          priority: 'Critical',
          status: 'Unassigned',
          scheduledTime: 'NOW',
        ),
        SizedBox(height: 16),
        JobCard(
          jobId: 'INC-002',
          clientName: 'Routine Service',
          location: 'Community Bank',
          priority: 'Medium',
          status: 'Unassigned',
          scheduledTime: 'Next Available',
        ),
        SizedBox(height: 16),
        JobCard(
          jobId: 'INC-003',
          clientName: 'Preventive Maintenance',
          location: 'Multiple Locations',
          priority: 'Low',
          status: 'Unassigned',
          scheduledTime: 'This Week',
        ),
      ],
    );
  }
}
