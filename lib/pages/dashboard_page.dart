import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'client_dashboard.dart';
import 'professional_dashboard.dart';
import 'role_manager.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final roleManager = Provider.of<RoleManager>(context);
    final isClient = roleManager.role == UserRole.client;

    return Scaffold(
      appBar: AppBar(
        title: Text(isClient ? "Client View" : "Professional View"),
        actions: [
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            tooltip: "Switch Role",
            onPressed: roleManager.toggleRole,
          ),
        ],
      ),
      body: SafeArea(
        child: isClient
            ? const ClientDashboardPage()
            : const ProfessionalDashboardPage(),
      ),
    );
  }
}
