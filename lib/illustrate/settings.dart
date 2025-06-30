import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        Text(
          "Store Configuration",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        ListTile(
          leading: Icon(Icons.store),
          title: Text("Store Info"),
          subtitle: Text("Edit business name, address, logo..."),
        ),
        ListTile(
          leading: Icon(Icons.payment),
          title: Text("Payment Methods"),
          subtitle: Text("Manage cards, M-Pesa, PayPal..."),
        ),
        ListTile(
          leading: Icon(Icons.local_shipping),
          title: Text("Shipping Settings"),
          subtitle: Text("Courier services and regions"),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => context.go('/settings/logs'),
          child: Text("View System Logs"),
        ),
      ],
    );
  }
}
