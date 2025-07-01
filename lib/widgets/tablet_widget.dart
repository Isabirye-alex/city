import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TabletWidget extends StatelessWidget {
  const TabletWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            // Top Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search, color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.notifications, color: Colors.black),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.settings, color: Colors.black),
                  onPressed: () {},
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.account_circle, color: Colors.black),
                ),
              ],
            ),

            SizedBox(height: 20),
            // Header
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            SizedBox(height: 20),

            // Cards in 2x2 Grid
            Wrap(
              runSpacing: 10,
              spacing: 10,
              children: [
                SizedBox(
                  width: size.width / 2 - 20,
                  child: DisplayCards(
                    title: 'Total Sales',
                    value: '\$7000.00',
                    percentageChange: '34%',
                    icon: Icons.arrow_upward,
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  width: size.width / 2 - 20,
                  child: DisplayCards(
                    title: 'Average Order Values',
                    value: '\$5600.00',
                    percentageChange: '20%',
                    icon: Icons.arrow_upward,
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  width: size.width / 2 - 20,
                  child: DisplayCards(
                    title: 'Total Orders',
                    value: '\$6500.90',
                    percentageChange: '89%',
                    icon: Icons.arrow_upward,
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  width: size.width / 2 - 20,
                  child: DisplayCards(
                    title: 'Total Visitors',
                    value: '\$4100.06',
                    percentageChange: '40%',
                    icon: Icons.arrow_downward,
                    color: Colors.red,
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            // Weekly Sales Graph
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  Text(
                    'Weekly Sales',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 300,
                    child: BarChart(
                      BarChartData(
                        titlesData: buildFlTitlesData(),
                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  FlTitlesData buildFlTitlesData() {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
            if (value.toInt() >= 0 && value.toInt() < days.length) {
              return Text(days[value.toInt()], style: TextStyle(fontSize: 10));
            }
            return Text('');
          },
          reservedSize: 28,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: true, reservedSize: 28),
      ),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }
}

// Reuse DisplayCards from your original code
class DisplayCards extends StatelessWidget {
  const DisplayCards({
    super.key,
    required this.title,
    required this.value,
    required this.percentageChange,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final String percentageChange;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 14, color: Colors.black)),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value, style: TextStyle(fontSize: 14, color: Colors.black)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(icon, color: color, size: 14),
                      SizedBox(width: 4),
                      Text(
                        percentageChange,
                        style: TextStyle(fontSize: 10, color: color),
                      ),
                    ],
                  ),
                  Text(
                    'Compared to last month',
                    style: TextStyle(fontSize: 8, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
