import 'package:flutter/material.dart';
import 'package:money_laundry/widgets/report_item.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Color(0xFF6594B1),
        title: const Text(
          "Transaction Reports",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Date",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                Row(
                  children: const [
                    Expanded(child: Text("24 Apr 2026")),
                    Text("Until"),
                    Expanded(
                      child: Text("01 May 2026", textAlign: TextAlign.end),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Apply",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Order",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "omset",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  const Divider(),

                  Expanded(
                    child: ListView(
                      children: const [
                        ReportItem("01 May 2026", "23", "Rp. 594,000"),
                        ReportItem("30 Apr 2026", "11", "Rp. 268,000"),
                        ReportItem("29 Apr 2026", "14", "Rp. 400,000"),
                        ReportItem("28 Apr 2026", "11", "Rp. 271,000"),
                        ReportItem("27 Apr 2026", "13", "Rp. 251,000"),
                        ReportItem("26 Apr 2026", "21", "Rp. 544,000"),
                        ReportItem("25 Apr 2026", "16", "Rp. 465,000"),
                        ReportItem("24 Apr 2026", "10", "Rp. 217,000"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Total
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              children: const [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Transaction Date"),
                    Text("24 Apr 2026 - 01 May 2026"),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total"),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [Text("Order 119"), Text("Rp. 3,010,000")],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
