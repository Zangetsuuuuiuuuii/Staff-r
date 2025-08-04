import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'role_manager.dart';
import 'login_page.dart';
import 'switch_role_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final roleManager = Provider.of<RoleManager>(context);
    final isClient = roleManager.role == UserRole.client;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      backgroundColor: Colors.grey[100],
      body: ListView(
        children: [
          const SectionTitle(title: 'General'),

          _buildTile(
            icon: Icons.sync_alt,
            title: 'Switch Role',
            context: context,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SwitchRolePage()),
              );
            },
          ),

          if (isClient)
            _buildTile(
              icon: Icons.badge,
              title: 'Apply to be a Professional',
              context: context,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Apply as a Professional'),
                    content: const Text(
                      'Your application has been submitted. Our team will contact you shortly.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),

          const SectionTitle(title: 'Support'),

          _buildTile(
            icon: Icons.help_outline,
            title: 'Help Center',
            context: context,
            onTap: () {
              // Implement Help Center navigation
            },
          ),

          _buildTile(
            icon: Icons.chat_bubble_outline,
            title: 'Contact Support',
            context: context,
            onTap: () {
              // Implement contact support
            },
          ),

          const SectionTitle(title: 'Legal'),

          _buildTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            context: context,
            onTap: () {
              // Show privacy policy
            },
          ),

          _buildTile(
            icon: Icons.description_outlined,
            title: 'Terms of Service',
            context: context,
            onTap: () {
              // Show terms of service
            },
          ),

          const SectionTitle(title: 'App Info'),

          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Version'),
            trailing: const Text('1.0.0'),
          ),

          _buildTile(
            icon: Icons.logout,
            title: 'Sign Out',
            context: context,
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required BuildContext context,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          tileColor: Colors.white,
          leading: Icon(icon, color: Colors.teal),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onTap,
        ),
        const Divider(height: 1, thickness: 0.5),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
      ),
    );
  }
}
