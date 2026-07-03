import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:money_laundry/providers/profile_provider.dart';
import 'package:money_laundry/providers/auth_provider.dart';

import 'package:money_laundry/screens/home/sidebar_screen/about.dart';
import 'package:money_laundry/screens/auth/screens/login_screen.dart';
import 'package:money_laundry/screens/home/sidebar_screen/profile_screen.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    final user = profileProvider.user;

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              user?.name ?? "Loading...",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            accountEmail: Text(
              user?.email ?? "",
              style: const TextStyle(color: Colors.white),
            ),

            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/appside.jpg"),
            ),

            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Profile"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfilePage()),
                    );
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text("About"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const About()),
                    );
                  },
                ),

                const ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Settings"),
                ),
              ],
            ),
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
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
    );
  }
}
