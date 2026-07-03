import 'package:flutter/material.dart';
import 'package:money_laundry/providers/customer_provider.dart';
import 'package:money_laundry/providers/order_provider.dart';
import 'package:money_laundry/providers/service_provider.dart';
import 'package:money_laundry/screens/customers/customer_screen.dart';
import 'package:money_laundry/screens/home/home_screen.dart';
import 'package:money_laundry/screens/home/list_order_screen/list_order_screen.dart';
import 'package:money_laundry/models/service.dart';
import 'package:money_laundry/models/customer_model.dart';
import 'package:money_laundry/widgets/empty_state.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ServiceProvider>().fetchServices();
      context.read<CustomerProvider>().listenCustomers();
    });
  }

  List<Service> selectedServices = [];
  CustomerModel? selectedCustomer;

  int getTotal() {
    int total = 0;
    for (var service in selectedServices) {
      total += service.price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.read<OrderProvider>();
    final serviceProvider = context.watch<ServiceProvider>();
    // final customerProvider = context.watch<CustomerProvider>();
    //
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            //
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF6594B1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Create Order",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("2026/04/13", style: TextStyle(color: Colors.white)),
                      Text("Ken-Wash", style: TextStyle(color: Colors.white)),
                    ],
                  ),

                  const SizedBox(height: 15),

                  GestureDetector(
                    onTap: () async {
                      final customer = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CustomerScreen(),
                        ),
                      );

                      if (customer != null) {
                        setState(() {
                          selectedCustomer = customer;
                        });
                      }
                    },
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedCustomer == null
                                ? "Select Customer"
                                : "${selectedCustomer!.name} (${selectedCustomer!.phone})",
                            style: TextStyle(
                              color: selectedCustomer == null
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Builder(
                builder: (_) {
                  if (serviceProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (serviceProvider.error != null) {
                    return Center(child: Text(serviceProvider.error!));
                  }

                  if (serviceProvider.services.isEmpty) {
                    return const EmptyState(
                      icon: Icons.assignment_late,
                      title: 'Tidak ada Layanan',
                      subtitle: 'Silakan refresh halaman',
                    );
                  }

                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: serviceProvider.services.map((service) {
                      final isSelected = selectedServices.contains(service);

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedServices.remove(service);
                            } else {
                              selectedServices.add(service);
                            }
                          });
                        },
                        child: Card(
                          color: isSelected ? Colors.blue[100] : Colors.white,
                          child: ListTile(
                            title: Text(service.name),
                            subtitle: Text("Rp ${service.price}"),
                            trailing: Icon(
                              isSelected
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              color: isSelected
                                  ? const Color(0xFF6594B1)
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            //
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // TOTAL
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Rp ${getTotal()}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      //
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => HomePage()),
                              (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6594B1),
                            foregroundColor: Colors.white,
                            shape: const StadiumBorder(),
                          ),
                          child: const Text("Batalkan"),
                        ),
                      ),

                      const SizedBox(width: 10),

                      //
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (selectedCustomer == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Pilih Customer terlebih dahulu",
                                  ),
                                ),
                              );
                              return;
                            }

                            if (selectedServices.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Pilih minimal satu layanan"),
                                ),
                              );
                              return;
                            }

                            await orderProvider.addOrder(
                              customerName: selectedCustomer!.name,
                              customerPhone: selectedCustomer!.phone,
                              services: selectedServices,
                            );

                            if (!context.mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Order berhasil disimpan"),
                              ),
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ListOrderScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            shape: const StadiumBorder(),
                          ),
                          child: orderProvider.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text("Simpan"),
                        ),
                      ),

                      const SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
