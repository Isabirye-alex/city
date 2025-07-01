import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Desktopwidget extends StatelessWidget {
  const Desktopwidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.zero,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black54, fontSize: 12),
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                Spacer(),

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alex Smith',
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '7526878@gmail.com',
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(),
            child: Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: DisplayCards(
                  title: 'Total Sales',
                  value: '\$7000.00',
                  percentageChange: '34%',
                  icon: Icons.arrow_upward,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: DisplayCards(
                  title: 'Average Order Values',
                  value: '\$5600.00',
                  percentageChange: '20%',
                  icon: Icons.arrow_upward,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: DisplayCards(
                  title: 'Total Orders',
                  value: '\$6500.90',
                  percentageChange: '89%',
                  icon: Icons.arrow_upward,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
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
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
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
                        height: 400,
                        child: BarChart(
                          BarChartData(
                            titlesData: buildFlTitlesData(),
                            borderData: FlBorderData(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildFlTitlesData() {}
}
// This widget can be used to create a desktop layout for the admin dashboard.

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      value,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(icon, color: Colors.white, size: 16),
                            Text(
                              percentageChange,
                              style: TextStyle(fontSize: 8, color: color),
                            ),
                          ],
                        ),
                        Text(
                          'compared to last month',
                          style: TextStyle(fontSize: 8, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
