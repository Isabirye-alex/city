import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        _buildHeader(context),
        SizedBox(height: 20),
        _buildProductSummaryCards(),
        SizedBox(height: 20),
        _buildProductTable(),
        SizedBox(height: 20),
        _buildOrderSummary(),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Dashboard", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Row(
          children: [
            SizedBox(
              width: 250,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  filled: true,
                  fillColor: Colors.black26,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(width: 10),
            // CircleAvatar(backgroundImage: AssetImage('assets/avatar.png')), // Replace with your own asset
          ],
        )
      ],
    );
  }

  Widget _buildProductSummaryCards() {
    List<Map<String, dynamic>> cards = [
      {'title': 'All Product', 'count': 18, 'color': Colors.blue},
      {'title': 'Out of Stock', 'count': 3, 'color': Colors.red},
      {'title': 'Limited Stock', 'count': 2, 'color': Colors.orange},
      {'title': 'Other Stock', 'count': 13, 'color': Colors.green},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: cards.map((item) {
        return Expanded(
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.inventory, color: item['color']),
                  SizedBox(height: 10),
                  Text("${item['count']} Product", style: TextStyle(fontWeight: FontWeight.bold)),
                  LinearProgressIndicator(value: item['count'] / 20, color: item['color']),
                  Text(item['title'], style: TextStyle(color: Colors.grey[400])),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProductTable() {
    final products = [
      {'name': 'Samsung A53 Mobile', 'category': 'Electronics', 'sub': 'Mobile', 'price': 15000},
      {'name': 'iPhone 14 Pro', 'category': 'Electronics', 'sub': 'Mobile', 'price': 5000},
      {'name': 'Apple Watch', 'category': 'Electronics', 'sub': 'Gadgets', 'price': 10000},
    ];

    return Card(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: const [
                Expanded(flex: 3, child: Text('Product Name')),
                Expanded(child: Text('Category')),
                Expanded(child: Text('Sub')),
                Expanded(child: Text('Price')),
                SizedBox(width: 50), // Edit icon space
                SizedBox(width: 50), // Delete icon space
              ],
            ),
          ),
          Divider(color: Colors.white24),
          ...products.map((product) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(flex: 3, child: Text(product['name'].toString(), overflow: TextOverflow.ellipsis)),
                  Expanded(child: Text(product['category'].toString())),
                  Expanded(child: Text(product['sub'].toString())),
                  Expanded(child: Text('${product['price']}')),
                  IconButton(onPressed: () {}, icon: Icon(Icons.edit, color: Colors.grey)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.delete, color: Colors.red)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: PieChart(
                PieChartData(sections: [
                  PieChartSectionData(value: 1, color: Colors.blue, title: ''),
                  PieChartSectionData(value: 1, color: Colors.orange, title: ''),
                  PieChartSectionData(value: 1, color: Colors.yellow, title: ''),
                ]),
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Orders Details", style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text("All Orders - 3", style: TextStyle(color: Colors.white70)),
                Text("Pending Orders - 1", style: TextStyle(color: Colors.white70)),
                Text("Processed Orders - 0", style: TextStyle(color: Colors.white70)),
              ],
            )
          ],
        ),
      ),
);
}
}