import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
       drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A237E),
        title: const Text(
          'User Information',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFF1A237E),
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),
            const SizedBox(height: 24),
            _InfoTile(label: 'Name', value: 'Ujani De'),
            _InfoTile(label: 'Phone Number', value: '+91 9046409140'),
            _InfoTile(label: 'Designation', value: 'School Inspector'),
            _InfoTile(label: 'Email', value: 'ujani@nic.in'),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _InfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}