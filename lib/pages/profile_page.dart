import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'role_manager.dart';
import 'client_profile_page.dart';
import 'professional_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final role = Provider.of<RoleManager>(context).role;

    return role == UserRole.client
        ? const ClientProfilePage()
        : const ProfessionalProfilePage();
  }
}
