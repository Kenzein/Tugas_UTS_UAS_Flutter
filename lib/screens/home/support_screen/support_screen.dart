import 'package:flutter/material.dart';
import 'package:money_laundry/widgets/support_tile.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Help & Support"), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "FAQ",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          SupportTile(
            imagePath: 'assets/images/tanya.jpg',
            title: "Cara membuat order?",
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => const AlertDialog(
                  title: Text("Cara membuat order"),
                  content: Text(
                    "Masuk ke menu Order, pilih layanan, lalu tekan simpan.",
                  ),
                ),
              );
            },
          ),

          SupportTile(
            imagePath: 'assets/images/tanya.jpg',
            title: "Cara melihat laporan?",
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => const AlertDialog(
                  title: Text("Laporan"),
                  content: Text(
                    "Masuk ke menu Report untuk melihat laporan transaksi.",
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 20),

          const Text(
            "Report Issue",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          SupportTile(
            imagePath: 'assets/images/bug.jpg',
            title: "Laporkan Bug",
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Fitur report (dummy)")),
              );
            },
          ),

          const SizedBox(height: 20),

          const Text(
            "Contact Developer",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          SupportTile(
            imagePath: 'assets/images/gmail.png',
            title: "Email",
            subtitle: "support@moneylaundry.com",
          ),

          SupportTile(
            imagePath: 'assets/images/wa.jpg',
            title: "WhatsApp",
            subtitle: "+62 812-3456-7890",
          ),
        ],
      ),
    );
  }
}
