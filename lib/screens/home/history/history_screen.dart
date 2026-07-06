import 'package:flutter/material.dart';
import 'package:money_laundry/providers/history_provider.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<HistoryProvider>().loadHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HistoryProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Order History")),

      body: provider.histories.isEmpty
          ? const Center(child: Text("Belum ada riwayat"))
          : ListView.builder(
              itemCount: provider.histories.length,
              itemBuilder: (context, index) {
                final order = provider.histories[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(order.customerName),
                    subtitle: Text("${order.services.length} layanan"),
                    trailing: Text("Rp ${order.total}"),
                  ),
                );
              },
            ),
    );
  }
}
