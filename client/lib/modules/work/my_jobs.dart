import 'package:flutter/material.dart';
import '../../widgets/job_card.dart';

class MyJobsScreen extends StatelessWidget {
  const MyJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: const [
        JobCard(
          jobId: 'J-10293',
          clientName: 'First National Bank',
          location: 'Downtown Branch',
          priority: 'High',
          status: 'Assigned',
          scheduledTime: 'Today, 10:00 AM',
        ),
        SizedBox(height: 16),
        JobCard(
          jobId: 'J-10294',
          clientName: 'Community Credit Union',
          location: 'Branch #4',
          priority: 'Medium',
          status: 'In Progress',
          scheduledTime: 'Today, 2:30 PM',
        ),
        SizedBox(height: 16),
        JobCard(
          jobId: 'J-10295',
          clientName: 'Metro Bank',
          location: 'ATM Lobby',
          priority: 'Low',
          status: 'Pending',
          scheduledTime: 'Tomorrow, 9:00 AM',
        ),
      ],
    );
  }
}
