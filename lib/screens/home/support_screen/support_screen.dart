import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_laundry/widgets/support_tile.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SupportScreen extends StatefulWidget {
  final bool showQrisOnOpen;

  const SupportScreen({super.key, this.showQrisOnOpen = false});

  static const String _qrisPayload =
      '000201010212021600065802BR5925Kenzi Laundry - Support6013Jakarta Selatan62070503***6304ABCD';

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.showQrisOnOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _showQrisSheet(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor = theme.scaffoldBackgroundColor;
    final cardColor = theme.cardColor;
    final titleColor = isDark ? Colors.white : const Color(0xFF1F2937);
    final subtitleColor = isDark ? Colors.white70 : const Color(0xFF64748B);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Help & Support",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2F5274),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _QrisSupportCard(
            payload: SupportScreen._qrisPayload,
            isDark: isDark,
            onOpen: () => _showQrisSheet(context),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF2F5274).withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.support_agent,
                  color: Color(0xFF2F5274),
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Ada yang bisa kami bantu?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: titleColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            "FAQ",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
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
            "About",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF2F5274).withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Color(0xFF2F5274),
                      size: 22,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Tentang Pengembang",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "Money Laundry dikembangkan oleh tim yang fokus pada solusi digital sederhana, cepat, dan nyaman untuk mengelola bisnis laundry.",
                  style: TextStyle(
                    fontSize: 14,
                    color: subtitleColor,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Tim kami terdiri dari pengembang yang berkomitmen menghadirkan fitur yang praktis, desain yang modern, dan pengalaman pengguna yang mudah dipahami.",
                  style: TextStyle(
                    fontSize: 14,
                    color: subtitleColor,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Developer Team • UI/UX • Backend • Support",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF2F5274),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
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

  static void _showQrisSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;

        return SafeArea(
          child: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Support via QRIS',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? Colors.white
                              : const Color(0xFF1F2937),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFE5EEF5)),
                    ),
                    child: QrImageView(
                      data: SupportScreen._qrisPayload,
                      version: QrVersions.auto,
                      size: 240,
                      gapless: false,
                      backgroundColor: Colors.white,
                      eyeStyle: const QrEyeStyle(
                        eyeShape: QrEyeShape.square,
                        color: Color(0xFF1F2937),
                      ),
                      dataModuleStyle: const QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Scan QRIS ini melalui aplikasi pembayaran. Jika scan gagal, salin kode QRIS lalu tempel di aplikasi yang mendukung input kode.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.45,
                    color: isDark ? Colors.white70 : const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () async {
                    await Clipboard.setData(
                      const ClipboardData(text: SupportScreen._qrisPayload),
                    );
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Kode QRIS disalin')),
                    );
                  },
                  icon: const Icon(Icons.copy),
                  label: const Text('Salin Kode QRIS'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _QrisSupportCard extends StatelessWidget {
  final String payload;
  final bool isDark;
  final VoidCallback onOpen;

  const _QrisSupportCard({
    required this.payload,
    required this.isDark,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E3A5A) : const Color(0xFFE7F0FF),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: QrImageView(
              data: payload,
              version: QrVersions.auto,
              size: 72,
              gapless: false,
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Support Kami',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Scan QRIS untuk memberi dukungan kepada tim.',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.35,
                    color: isDark ? Colors.white70 : const Color(0xFF52606D),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            height: 44,
            child: ElevatedButton(
              onPressed: onOpen,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6594B1),
                padding: const EdgeInsets.symmetric(horizontal: 22),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              child: const Text(
                'Buka',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
