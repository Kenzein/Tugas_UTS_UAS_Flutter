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
      backgroundColor: const Color(0xFFEFF5FA),
      appBar: AppBar(
        title: const Text("About", style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF6594B1), Color(0xFF4A7AAE)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: const [
                  Text(
                    "Money Laundry",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "V 1.0.0",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  SizedBox(height: 14),
                  Text(
                    "Aplikasi ini membantu pengelolaan laundry agar lebih mudah, cepat, dan efisien.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 15, height: 1.6),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 18,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Tentang Aplikasi",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        SizedBox(height: 14),
                        Text(
                          "Money Laundry adalah aplikasi pengelolaan bisnis laundry yang dibuat untuk membantu pemilik usaha mencatat order, mengelola data pelanggan, dan melihat laporan dengan lebih mudah.",
                          style: TextStyle(color: Color(0xFF64748B), fontSize: 14, height: 1.6),
                        ),
                        SizedBox(height: 14),
                        Text(
                          "Dikembangkan oleh tim yang berfokus pada solusi praktis, tampilan bersih, dan pengalaman pengguna intuitif.",
                          style: TextStyle(color: Color(0xFF64748B), fontSize: 14, height: 1.6),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 18,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Developer Team",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 18),
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          children: const [
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
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "© 2026 Mikriskid",
              style: TextStyle(color: Color(0xFF475569)),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
