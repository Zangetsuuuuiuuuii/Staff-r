import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard_page.dart';
import 'recruiting_page.dart';
import 'chat_list_page.dart'; // ✅ Correct chat list import
import 'my_jobs_page.dart';
import 'client_profile_page.dart';
import 'professional_profile_page.dart';
import 'role_manager.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;
  UserRole? _currentRole;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final role = Provider.of<RoleManager>(context).role;

    if (_currentRole != role) {
      _currentRole = role;
      _selectedIndex = 0;
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RoleManager>(
      builder: (context, roleManager, _) {
        final isClient = roleManager.role == UserRole.client;

        final pages = isClient
            ? [
                const DashboardPage(),
                const RecruitingPage(),
                const ChatListPage(isClient: true), // ✅ Chat list for client
                const ClientProfilePage(),
              ]
            : [
                const DashboardPage(),
                const MyJobsPage(),
                const ChatListPage(isClient: false), // ✅ Chat list for professional
                const ProfessionalProfilePage(),
              ];

        final navItems = isClient
            ? const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard), label: 'Dashboard'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today), label: 'Booking'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat), label: 'Chat'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle), label: 'Profile'),
              ]
            : const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard), label: 'Dashboard'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.work), label: 'My Jobs'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat), label: 'Chat'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle), label: 'Profile'),
              ];

        return Scaffold(
          appBar: AppBar(
            title: Image.asset(
              'assets/staffr_logo.png',
              height: 36,
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
          ),
          body: pages[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onTabTapped,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            items: navItems,
          ),
        );
      },
    );
  }
}
