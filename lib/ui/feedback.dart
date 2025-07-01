import 'package:city/core/controllers/dashboard.controller.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Feedback extends StatelessWidget {
  const Feedback({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1000;
    final controller = Get.put(DashBoardController());
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Container(
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
              ),
              Spacer(flex: 1),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(),
                  child: TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text(
                          'Add New Product',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
                child: ABarGraph(controller: controller, isDesktop: isDesktop),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: APieChart(),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            height: 500,
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: ADataTable(),
          ),
        ],
      ),
    );
  }
}

class ADataTable extends StatelessWidget {
  const ADataTable({super.key});

  @override
  Widget build(BuildContext context) {
    final List<DataColumn> columns = [
      DataColumn(label: Text('Image')),
      DataColumn(label: Text('Product Name')),
      DataColumn(label: Text('Product Category')),
      DataColumn(label: Text('Product subcategory')),
      DataColumn(label: Text('Products in Stock')),
      DataColumn(label: Text('Featured Product')),
      DataColumn(label: Text('Price')),
    ];

    final DataTableSource source = ADataTableSource();

    return Container(
      height: 500,
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width:
              1000, // adjust width to fit all columns, or calculate dynamically
          child: PaginatedDataTable2(
            headingTextStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            dataRowHeight: 40,
            sortArrowAlwaysVisible: true,
            sortArrowIcon: Icons.compare_arrows_outlined,
            sortAscending: true,
            showCheckboxColumn: true,
            scrollController: ScrollController(),
            checkboxHorizontalMargin: 4.0,
            showFirstLastButtons: true,
            columns: columns,
            source: source,
          ),
        ),
      ),
    );
  }
}

class ADataTableSource extends DataTableSource {
  final List<Map<String, dynamic>> _data = List.generate(200, (index) {
    final products = [
      {
        'image': 'Not Available',
        'Product Name': 'Laptop',
        'Product Category': 'Electronics',
        'Product subcategory': 'Computers',
        'Products in Stock': 15,
        'Featured Product': 'Yes',
        'Price': '\$1200.00',
      },
      {
        'image': 'Not Available',
        'Product Name': 'Smartphone',
        'Product Category': 'Electronics',
        'Product subcategory': 'Mobile Phones',
        'Products in Stock': 30,
        'Featured Product': 'No',
        'Price': '\$800.00',
      },
      {
        'image': 'Not Available',
        'Product Name': 'Headphones',
        'Product Category': 'Accessories',
        'Product subcategory': 'Audio',
        'Products in Stock': 50,
        'Featured Product': 'Yes',
        'Price': '\$150.00',
      },
    ];
    final product = products[index % products.length];
    // Optionally, make each row unique
    return {
      ...product,
      'Product Name': '${product['Product Name']} #${index + 1}',
      'Products in Stock': (product['Products in Stock'] as int) + index,
      'Price': '\$${(100 + index * 30).toStringAsFixed(2)}',
    };
  });

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) return null;
    final row = _data[index];
    return DataRow(
      cells: [
        DataCell(Text(row['image'].toString())),
        DataCell(Text(row['Product Name'].toString())),
        DataCell(Text(row['Product Category'].toString())),
        DataCell(Text(row['Product subcategory'].toString())),
        DataCell(Text(row['Products in Stock'].toString())),
        DataCell(Text(row['Featured Product'].toString())),
        DataCell(Text(row['Price'].toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}

class APieChart extends StatelessWidget {
  const APieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, double> statusTotals = {};
    for (final order in DashBoardController.orders) {
      statusTotals.update(
        order.status,
        (value) => value + order.totalAmount.toDouble(),
        ifAbsent: () => order.totalAmount.toDouble(),
      );
    }

    // Define colors per status
    final Map<String, Color> statusColors = {
      'Delivered': Colors.green,
      'Pending': Colors.orange,
      'Confirmed': Colors.blue,
      'Cancelled': Colors.red,
      'Other': Colors.grey,
    };

    final List<PieChartSectionData> pieSections = statusTotals.entries.map((
      entry,
    ) {
      final color = statusColors[entry.key] ?? Colors.black;
      return PieChartSectionData(
        color: color,
        value: entry.value,
        title: '${entry.value.toInt()}',
        radius: 50,
        titleStyle: const TextStyle(fontSize: 12, color: Colors.black),
      );
    }).toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: pieSections,
              sectionsSpace: 2,
              centerSpaceRadius: 30,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Legend with totals
        Column(
          children: statusTotals.entries.map((entry) {
            final color = statusColors[entry.key] ?? Colors.black;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Center(
                    child: Container(
                      width: 12,
                      height: 12,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      '${entry.key}: \$${entry.value.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class ABarGraph extends StatelessWidget {
  const ABarGraph({
    super.key,
    required this.controller,
    required this.isDesktop,
  });

  final DashBoardController controller;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
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
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    top: BorderSide.none,
                    right: BorderSide.none,
                    left: BorderSide(color: Colors.black, width: 1),
                    bottom: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: false,
                  verticalInterval: 1,
                  horizontalInterval: 100,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) =>
                      FlLine(color: Colors.grey, strokeWidth: 0.5),
                ),
                barGroups: controller.weeklySales.asMap().entries.map((entry) {
                  int index = entry.key;
                  double value = entry.value;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: value,
                        color: Colors.blue,
                        width: 20,
                        borderRadius: BorderRadius.zero,
                      ),
                    ],
                  );
                }).toList(),
                groupsSpace: 4,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => Colors.white,
                  ),

                  touchCallback: isDesktop
                      ? (event, response) {
                          // if (response != null &&
                          //     response.spot != null) {
                          //   final spot = response.spot!;
                          //   final index = spot.spotIndex;
                          //   final value =
                          //       controller.weeklySales[index];
                          //   print('Touched value: $value');
                          // }
                        }
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

FlTitlesData buildFlTitlesData() {
  return FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 40,
        getTitlesWidget: (value, meta) {
          final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
          final index = value.toInt() % days.length;
          final day = days[index];
          return SideTitleWidget(space: 0, meta: meta, child: Text(day));
        },
      ),
    ),
    leftTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: true, interval: 100, reservedSize: 50),
    ),
    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
  );
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
