import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminShell extends StatelessWidget {
  final Widget child;
  const AdminShell({super.key, required this.child});

  final destinations = const [
    {'label': 'Dashboard', 'icon': Icons.dashboard, 'route': '/dashboard'},
    {'label': 'Categories', 'icon': Icons.category, 'route': '/categories'},
    {
      'label': 'Subcategories',
      'icon': Icons.subdirectory_arrow_right,
      'route': '/subcategories',
    },
    {'label': 'Products', 'icon': Icons.shopping_cart, 'route': '/products'},
    {'label': 'Brands', 'icon': Icons.branding_watermark, 'route': '/brands'},
    {'label': 'Orders', 'icon': Icons.receipt, 'route': '/orders'},
    {
      'label': 'Notifications',
      'icon': Icons.notifications,
      'route': '/notifications',
    },
    {'label': 'Settings', 'icon': Icons.settings, 'route': '/settings'},
    {'label': 'Reports', 'icon': Icons.bar_chart, 'route': '/reports'},
    {'label': 'Users', 'icon': Icons.person, 'route': '/users'},
    {'label': 'Vendors', 'icon': Icons.store, 'route': '/vendors'},
    {'label': 'Analytics', 'icon': Icons.analytics, 'route': '/analytics'},
    {'label': 'Feedback', 'icon': Icons.feedback, 'route': '/feedback'},
    {'label': 'Help', 'icon': Icons.help, 'route': '/help'},
    {'label': 'Logout', 'icon': Icons.logout, 'route': '/logout'},
    {'label': 'Product', 'icon': Icons.add, 'route': '/dashboard/addproduct'},
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: isWide
          ? null
          : AppBar(
              title: Text("Easy Mall DashBoard"),
              backgroundColor: Colors.black45,
              centerTitle: true,
              actions: [Icon(Icons.account_circle)],
            ),
      drawer: isWide
          ? null
          : Drawer(
              child: ListView(
                children: [
                  DrawerHeader(child: Text("Menu")),
                  for (var item in destinations)
                    ListTile(
                      leading: Icon(item['icon'] as IconData),
                      title: Text(item['label'] as String),
                      onTap: () {
                        context.go(item['route'] as String);
                        Navigator.pop(context); // close drawer
                      },
                    ),
                ],
              ),
            ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                if (isWide)
                  Expanded(
                    flex: 0,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                // color: Colors.black45,
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.manage_accounts,
                                      size: 48,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Menu",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: constraints.maxHeight,
                                ),
                                child: IntrinsicHeight(
                                  child: NavigationRail(
                                    elevation: 20,
                                    minWidth: 140,
                                    backgroundColor: Colors.black45,
                                    selectedIndex: _getIndex(context),
                                    onDestinationSelected: (index) =>
                                        context.go(
                                          destinations[index]['route']
                                              as String,
                                        ),
                                    labelType: NavigationRailLabelType.all,
                                    destinations: [
                                      for (var item in destinations)
                                        NavigationRailDestination(
                                          icon: Icon(
                                            item['icon'] as IconData,
                                            color: Colors.white70,
                                          ),
                                          selectedIcon: Icon(
                                            item['icon'] as IconData,
                                            color: Colors.white,
                                          ),
                                          label: Text(
                                            item['label'] as String,
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int _getIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    // Adjust index to account for logo destination
    return destinations.indexWhere(
          (d) => location.startsWith(d['route'] as String),
        ) +
        0; // +1 to account for logo at index 0
  }
}
