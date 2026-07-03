import 'package:flutter/material.dart';
import 'package:money_laundry/widgets/member_card.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6594B1),
      appBar: AppBar(
        title: const Text("About"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// Nama App
            const Text(
              "Money Laundry",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 5),

            /// Versi
            const Text("V 1.0.0", style: TextStyle(color: Colors.white70)),

            const SizedBox(height: 10),

            /// Deskripsi
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Aplikasi ini membantu pengelolaan laundry agar lebih mudah, cepat, dan efisien.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),

            const SizedBox(height: 30),

            /// Card Developer
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text(
                    "Developer Team",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [
                      MemberCard(
                        name: "Kenzy Setio",
                        role: "@kenzysetio",
                        imagePath: "assets/images/ken.jpeg",
                      ),
                      MemberCard(
                        name: "Steven Fandich",
                        role: "@stevenfandich",
                        imagePath: "assets/images/steve.jpeg",
                      ),
                      MemberCard(
                        name: "Avinash",
                        role: "@avinash",
                        imagePath: "assets/images/nas.jpeg",
                      ),
                      MemberCard(
                        name: "Valencia",
                        role: "@valencia",
                        imagePath: "assets/images/appside.jpg",
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// Footer
            const Text(
              "© 2026 Mikriskid",
              style: TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// Widget Member (pakai foto)
  Widget buildMember(String name, String role, String imagePath) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// FOTO PROFILE
          ClipOval(
            child: Image.asset(
              imagePath,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),

          Text(role, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
