import 'package:flutter/material.dart';
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
      backgroundColor: const Color(0xFF6594B1),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF6594B1),
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25),

            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 56,
                  backgroundImage: user.photo.isNotEmpty
                      ? NetworkImage(user.photo)
                      : const AssetImage("assets/images/appside.jpg")
                            as ImageProvider,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              user.name,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              user.email,
              style: const TextStyle(fontSize: 17, color: Colors.white70),
            ),

            const SizedBox(height: 35),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),

              child: Column(
                children: [
                  buildInfoTile(Icons.person, "Nama", user.name),

                  const Divider(),

                  buildInfoTile(Icons.email, "Email", user.email),

                  const Divider(),

                  buildInfoTile(Icons.phone, "Nomor HP", user.phone),
                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  // kita isi pada tahap berikutnya
                },
                icon: const Icon(Icons.edit),
                label: const Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF6594B1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
