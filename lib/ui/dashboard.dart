import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Top Header Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Dashboard',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: const [
                  CircleAvatar(
                    radius: 20,
                    // backgroundImage: AssetImage('assets/user.jpg'),
                    child: Icon(Icons.person, size: 24),
                  ),
                  SizedBox(width: 8),
                  Text('Alex', style: TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Products Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Products',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Add New Item'),
                  ),
                  const SizedBox(width: 8),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Stats Cards Row
          Row(
            children: [
              _buildStatCard('All Products', '120'),
              _buildStatCard('Out of Stock', '12'),
              _buildStatCard('Low in Stock', '8'),
              _buildStatCard('Other Stock', '100'),
            ],
          ),
          const SizedBox(height: 24),

          // Data Table and Chart
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Data Table Expanded
              Expanded(
                flex: 3,
                child: DataTable(
                  columnSpacing: 12,
                  columns: const [
                    DataColumn(label: Text('Image')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Subcategory')),
                    DataColumn(label: Text('Category')),
                    DataColumn(label: Text('Price')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: [
                    for (int i = 0; i < 50; i++)
                      DataRow(
                        cells: [
                          DataCell(
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/sample.jpg'),
                            ),
                          ),
                          DataCell(Text('Product $i')),
                          const DataCell(Text('Phones')),
                          const DataCell(Text('Electronics')),
                          const DataCell(Text('\$299')),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.edit, size: 20),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.delete, size: 20),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Graph Placeholder
              Expanded(
                flex: 1,
                child: Container(
                  height: 300,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade300, blurRadius: 6),
                    ],
                  ),
                  child: const Center(child: Text('Product Graph Here')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 6)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
