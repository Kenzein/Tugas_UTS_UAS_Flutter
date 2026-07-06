import 'package:flutter/material.dart';
import 'package:money_laundry/screens/home/sidebar_screen/edit_profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:money_laundry/providers/profile_provider.dart';
import 'package:money_laundry/widgets/profile_page_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ProfileProvider>().loadUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();

    if (profile.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (profile.user == null) {
      return const Scaffold(
        body: Center(child: Text("Data user tidak ditemukan")),
      );
    }

    final user = profile.user!;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FC),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2F5274),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1F3E5A),
                    Color(0xFF2F5274),
                    Color(0xFF163247),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 58,
                    backgroundColor: Colors.white.withOpacity(0.24),
                    child: CircleAvatar(
                      radius: 54,
                      backgroundImage: user.photo.isNotEmpty
                          ? NetworkImage(user.photo)
                          : const AssetImage("assets/images/appside.jpg") as ImageProvider,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    user.email,
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -18),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2F5274).withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    buildInfoTile(Icons.person, "Nama", user.name),
                    const Divider(height: 1),
                    buildInfoTile(Icons.email, "Email", user.email),
                    const Divider(height: 1),
                    buildInfoTile(Icons.phone, "Nomor HP", user.phone),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EditProfileScreen(),
                    ),
                  );

                  if (!mounted) return;

                  context.read<ProfileProvider>().loadUser();
                },
                icon: const Icon(Icons.edit),
                label: const Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F5274),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
