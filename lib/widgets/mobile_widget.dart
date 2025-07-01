import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MobileWidget extends StatelessWidget {
  const MobileWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header & Icons
          Row(
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
                      hintStyle: TextStyle(color: Colors.black54, fontSize: 12),
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
            ],
          ),

          SizedBox(height: 20),
          Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          SizedBox(height: 20),

          // Cards one per row
          DisplayCards(
            title: 'Total Sales',
            value: '\$7000.00',
            percentageChange: '34%',
            icon: Icons.arrow_upward,
            color: Colors.green,
          ),
          SizedBox(height: 10),
          DisplayCards(
            title: 'Average Order Values',
            value: '\$5600.00',
            percentageChange: '20%',
            icon: Icons.arrow_upward,
            color: Colors.green,
          ),
          SizedBox(height: 10),
          DisplayCards(
            title: 'Total Orders',
            value: '\$6500.90',
            percentageChange: '89%',
            icon: Icons.arrow_upward,
            color: Colors.green,
          ),
          SizedBox(height: 10),
          DisplayCards(
            title: 'Total Visitors',
            value: '\$4100.06',
            percentageChange: '40%',
            icon: Icons.arrow_downward,
            color: Colors.red,
          ),

          SizedBox(height: 20),

          // Weekly Sales chart
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
      width: double.infinity,
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
