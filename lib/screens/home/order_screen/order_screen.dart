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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = theme.cardColor;
    final textColor = theme.textTheme.bodyMedium?.color ?? (isDark ? Colors.white : Colors.black);
    final secondaryColor = isDark ? Colors.white70 : Colors.grey;
    final orderProvider = context.read<OrderProvider>();
    final serviceProvider = context.watch<ServiceProvider>();
    // final customerProvider = context.watch<CustomerProvider>();
    //
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1F3E5A),
                    Color(0xFF2F5274),
                    Color(0xFF163247),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF163247).withOpacity(0.22),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            "Create Order",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("2026/04/13", style: TextStyle(color: Colors.white70)),
                      Text("Ken-Wash", style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                  const SizedBox(height: 16),
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
                        color: cardColor,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(isDark ? 0.18 : 0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
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
                                  ? secondaryColor
                                  : textColor,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: isDark ? Colors.white70 : Colors.grey.shade700,
                          ),
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
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Pilih layanan",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                      ),
                      ...serviceProvider.services.map((service) {
                        final isSelected = selectedServices.contains(service);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedServices.remove(service);
                                } else {
                                  selectedServices.add(service);
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFFEAF4FF) : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFF86B7E3)
                                      : const Color(0xFFE5EEF5),
                                  width: isSelected ? 1.4 : 1.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF2F5274).withOpacity(0.05),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: isDark ? theme.dividerColor : const Color(0xFFEEF6FF),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.cleaning_services,
                                      color: isDark ? Colors.white70 : const Color(0xFF2F5274),
                                      size: 22,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          service.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: textColor,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Rp ${service.price}",
                                          style: TextStyle(
                                            color: secondaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    isSelected
                                        ? Icons.check_circle
                                        : Icons.circle_outlined,
                                    color: isSelected
                                        ? const Color(0xFF2F5274)
                                        : Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  );
                },
              ),
            ),
            //
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.18 : 0.12),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // TOTAL
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      Text(
                        "Rp ${getTotal()}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F766E),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
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
                            backgroundColor: const Color(0xFF2F5274),
                            foregroundColor: Colors.white,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text("Batalkan"),
                        ),
                      ),

                      const SizedBox(width: 10),

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
                            backgroundColor: const Color(0xFF0F766E),
                            foregroundColor: Colors.white,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(vertical: 12),
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
