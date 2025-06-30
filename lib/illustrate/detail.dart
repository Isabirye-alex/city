import 'package:flutter/material.dart';

class DashboardDetailsPage extends StatelessWidget {
  const DashboardDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        Text(
          "Sales Performance Overview",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Text(
          "This section provides detailed insights into monthly sales, top-selling products, regional sales distribution, and customer engagement.",
        ),
        SizedBox(height: 40),
        Placeholder(
          fallbackHeight: 200,
          fallbackWidth: double.infinity,
        ), // Simulate a chart
        SizedBox(height: 20),
        Placeholder(fallbackHeight: 100),
      ],
    );
  }
}
