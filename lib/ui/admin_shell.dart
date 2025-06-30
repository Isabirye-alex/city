import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminShell extends StatelessWidget {
  final Widget child;
  const AdminShell({super.key, required this.child});

  final destinations = const [
    {'label': 'Dashboard', 'icon': Icons.dashboard, 'route': '/dashboard'},
    {'label': 'Categories', 'icon': Icons.category, 'route': '/categories'},
    {'label': 'Subcategories', 'icon': Icons.subdirectory_arrow_right, 'route': '/subcategories'},
    {'label': 'Products', 'icon': Icons.shopping_cart, 'route': '/products'},
    {'label': 'Brands', 'icon': Icons.branding_watermark, 'route': '/brands'},
    {'label': 'Orders', 'icon': Icons.receipt, 'route': '/orders'},
    {'label': 'Notifications', 'icon': Icons.notifications, 'route': '/notifications'},
    {'label': 'Customers', 'icon': Icons.people, 'route': '/customers'},
    {'label': 'Settings', 'icon': Icons.settings, 'route': '/settings'},
    {'label': 'Reports', 'icon': Icons.bar_chart, 'route': '/reports'},
    {'label': 'Users', 'icon': Icons.person, 'route': '/users'},
    {'label': 'Vendors', 'icon': Icons.store, 'route': '/vendors'},
    {'label': 'Analytics', 'icon': Icons.analytics, 'route': '/analytics'},
    {'label': 'Feedback', 'icon': Icons.feedback, 'route': '/feedback'},
    {'label': 'Help', 'icon': Icons.help, 'route': '/help'},
    {'label': 'Logout', 'icon': Icons.logout, 'route': '/logout'},
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
      body: Row(
        children: [
          if (isWide)
            Expanded(
              flex: 0,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: NavigationRail(
                          backgroundColor: Colors.grey,
                          selectedIndex: _getIndex(context),
                          onDestinationSelected: (index) => context.go(
                            destinations[index]['route'] as String,
                          ),
                          labelType: NavigationRailLabelType.all,
                          destinations: [
                            for (var item in destinations)
                              NavigationRailDestination(
                                icon: Icon(item['icon'] as IconData),
                                label: Text(item['label'] as String),
                              ),
                          ],
                        ),
                      ),
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
    );
  }

  int _getIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    return destinations.indexWhere(
      (d) => location.startsWith(d['route'] as String),
    );
  }
}
