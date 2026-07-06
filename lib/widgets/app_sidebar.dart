import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:money_laundry/providers/profile_provider.dart';
import 'package:money_laundry/providers/auth_provider.dart';

import 'package:money_laundry/screens/home/sidebar_screen/about.dart';
import 'package:money_laundry/screens/auth/screens/login_screen.dart';
import 'package:money_laundry/screens/home/sidebar_screen/profile_screen.dart';
import 'package:money_laundry/screens/home/sidebar_screen/settings_screen.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profileProvider = context.watch<ProfileProvider>();
    final user = profileProvider.user;

    return Drawer(
      child: Container(
        color: theme.scaffoldBackgroundColor,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2F5274), Color(0xFF436A95)],
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.white,
                          backgroundImage: const AssetImage("assets/images/appside.jpg"),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user?.name ?? "Loading...",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                user?.email ?? "",
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        'Menu navigasi cepat untuk profil, about, dan settings.',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _SidebarTile(
                    icon: Icons.person,
                    label: 'Profile',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ProfilePage()),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  _SidebarTile(
                    icon: Icons.info,
                    label: 'About',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const About()),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  _SidebarTile(
                    icon: Icons.settings,
                    label: 'Settings',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SettingsScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  const Divider(height: 0),
                  const SizedBox(height: 16),
                  _SidebarTile(
                    icon: Icons.logout,
                    label: 'Logout',
                    iconColor: Colors.red,
                    textColor: Colors.red,
                    onTap: () async {
                      await context.read<AuthProvider>().logout();
                      if (!context.mounted) return;
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => LoginPage()),
                        (route) => false,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SidebarTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;

  const _SidebarTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final defaultTextColor = textColor ?? (isDark ? Colors.white : const Color(0xFF1F2937));
    final defaultIconColor = iconColor ?? (isDark ? Colors.white : const Color(0xFF2F5274));
    final tileColor = theme.cardColor;

    return Material(
      color: tileColor,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Row(
            children: [
              Icon(icon, color: defaultIconColor),
              const SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: defaultTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
