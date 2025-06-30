import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        Text(
          "Customer Management",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        ListTile(
          leading: CircleAvatar(child: Icon(Icons.person)),
          title: Text("John Doe"),
          subtitle: Text("Active customer - 5 orders"),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
        ),
        ListTile(
          leading: CircleAvatar(child: Icon(Icons.person)),
          title: Text("Jane Smith"),
          subtitle: Text("VIP customer - 21 orders"),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => context.go('/users/details'),
          child: Text("View User Details"),
        ),
      ],
    );
  }
}
