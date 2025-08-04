import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'role_manager.dart';
import 'settings_page.dart';

class ClientProfilePage extends StatelessWidget {
  const ClientProfilePage({super.key});

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
            // Profile Picture & Name
            CircleAvatar(
              radius: 48,
              backgroundImage: AssetImage('assets/profile_placeholder.png'), // Replace if using real image
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'M Karthikeya',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.verified, color: Colors.blue, size: 20),
              ],
            ),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: () {
                // Handle editable name
              },
              child: const Text(
                'Tap to edit name',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),

            const SizedBox(height: 20),

            // Client Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatCard(label: 'Jobs Hired', value: '35'),
                _StatCard(label: 'Rating from Pros', value: '4.9'),
                _StatCard(icon: Icons.verified_user, label: 'Verified', color: Colors.blue),
              ],
            ),

            const SizedBox(height: 30),

            // Favorite Professionals Section (Optional)
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Favorite Professionals',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            _FavoriteProList(),
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

class _FavoriteProList extends StatelessWidget {
  const _FavoriteProList();

  @override
  Widget build(BuildContext context) {
    // Replace with dynamic list if available
    final favorites = [
      {'name': 'Sanjay', 'category': 'Security'},
      {'name': 'Sabreen', 'category': 'Cleaning'},
      {'name': 'Saket', 'category': 'Private Tutor'},
    ];

    return Column(
      children: favorites
          .map(
            (pro) => ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/profile_placeholder.png'),
              ),
              title: Text(pro['name'] ?? ''),
              subtitle: Text(pro['category'] ?? ''),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to pro’s profile
              },
            ),
          )
          .toList(),
    );
  }
}
