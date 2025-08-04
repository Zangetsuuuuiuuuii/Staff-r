import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'role_manager.dart';
import 'settings_page.dart';

class ProfessionalProfilePage extends StatelessWidget {
  const ProfessionalProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final roleManager = Provider.of<RoleManager>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Profile picture + Name + Badges
            CircleAvatar(
              radius: 48,
              backgroundImage: AssetImage('assets/profile_placeholder.png'), // Replace with real asset or network
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'K Ruthwick',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.verified, color: Colors.blue, size: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  margin: const EdgeInsets.only(left: 6),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.work, size: 16, color: Colors.deepPurple),
                      SizedBox(width: 4),
                      Text('Professional', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: () {
                // Implement editable name
              },
              child: const Text(
                'Tap to edit name',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),

            const SizedBox(height: 16),

            // Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                const Text('4.8', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(width: 6),
                const Text('(120 Reviews)', style: TextStyle(color: Colors.grey)),
              ],
            ),

            const SizedBox(height: 20),

            // Stats row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatCard(label: 'Jobs Done', value: '89'),
                _StatCard(label: 'Rating', value: '4.8'),
                _StatCard(label: 'Verified', icon: Icons.verified, color: Colors.blue),
              ],
            ),

            const SizedBox(height: 30),

            // Allowed job categories
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Allowed Job Categories',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                _CategoryChip(icon: Icons.security, label: 'Security'),
                _CategoryChip(icon: Icons.cleaning_services, label: 'Cleaning'),
                _CategoryChip(icon: Icons.restaurant, label: 'Cooking'),
                _CategoryChip(icon: Icons.child_friendly, label: 'Babysitting'),
                _CategoryChip(icon: Icons.directions_car, label: 'Driving'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String? value;
  final IconData? icon;
  final Color? color;

  const _StatCard({
    this.label = '',
    this.value,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (value != null)
          Text(
            value!,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        if (icon != null)
          Icon(
            icon,
            color: color ?? Colors.grey,
            size: 24,
          ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _CategoryChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18, color: Colors.deepPurple),
      label: Text(label),
      backgroundColor: Colors.deepPurple.shade50,
      shape: StadiumBorder(
        side: BorderSide(color: Colors.deepPurple.shade100),
      ),
    );
  }
}
