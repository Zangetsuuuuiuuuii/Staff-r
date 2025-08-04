import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'role_manager.dart';

class SwitchRolePage extends StatelessWidget {
  const SwitchRolePage({super.key});

  @override
  Widget build(BuildContext context) {
    final roleManager = Provider.of<RoleManager>(context);
    final isClient = roleManager.role == UserRole.client;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Switch Role"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Current Role: ${isClient ? "Client" : "Professional"}",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Client"),
                Switch(
                  value: !isClient, // true = professional
                  onChanged: (value) {
                    value
                        ? roleManager.switchToProfessional()
                        : roleManager.switchToClient();
                  },
                ),
                const Text("Professional"),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              icon: const Icon(Icons.arrow_back),
              label: const Text("Back to Settings"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
