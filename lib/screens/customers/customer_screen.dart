import 'package:flutter/material.dart';
import 'package:money_laundry/providers/customer_provider.dart';
import 'package:money_laundry/screens/customers/add_customer_screen.dart';
import 'package:provider/provider.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<CustomerProvider>().listenCustomers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final customerProvider = context.watch<CustomerProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6594B1),
        title: const Text(
          "Customers",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: customerProvider.customers.isEmpty
          ? const Center(child: Text("Belum ada customer"))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: customerProvider.customers.length,
              itemBuilder: (context, index) {
                final customer = customerProvider.customers[index];

                return Card(
                  child: ListTile(
                    onTap: () {
                      // Mengirim customer kembali ke OrderPage
                      Navigator.pop(context, customer);
                    },

                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFF6594B1),
                      child: Icon(Icons.person, color: Colors.white),
                    ),

                    title: Text(
                      customer.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    subtitle: Text(customer.phone),

                    trailing: PopupMenuButton<String>(
                      onSelected: (value) async {
                        if (value == "delete") {
                          await customerProvider.deleteCustomer(customer.id);
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(value: "delete", child: Text("Delete")),
                      ],
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6594B1),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddCustomerScreen()),
          );
        },
      ),
    );
  }
}
