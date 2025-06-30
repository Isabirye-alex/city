import 'package:city/illustrate/dashboard.dart';
import 'package:city/illustrate/detail.dart';
import 'package:city/illustrate/s_datail.dart' show SettingsLogsPage;
import 'package:city/illustrate/settings.dart';
import 'package:city/illustrate/u_detail.dart';
import 'package:city/illustrate/user_page.dart';
import 'package:city/ui/admin_shell.dart';
import 'package:city/ui/brands.dart';
import 'package:city/ui/categories.dart';
import 'package:city/ui/feedback.dart';
import 'package:city/ui/help.dart';
import 'package:city/ui/logout.dart';
import 'package:city/ui/notifications.dart';
import 'package:city/ui/products.dart';
import 'package:city/ui/subcategories.dart';
import 'package:city/ui/users.dart';
import 'package:city/ui/vendors.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/dashboard',
    routes: [
      ShellRoute(
        builder: (context, state, child) => AdminShell(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => DashboardPage(),
          ),
          GoRoute(path: '/users', builder: (context, state) => UsersPage()),
          GoRoute(
            path: '/settings',
            builder: (context, state) => SettingsPage(),
          ),
          // Add these inside the ShellRoute's routes list
          GoRoute(
            path: '/dashboard/details',
            builder: (context, state) => DashboardDetailsPage(),
          ),
          GoRoute(
            path: '/users/details',
            builder: (context, state) => UserDetailsPage(),
          ),
          GoRoute(
            path: '/settings/logs',
            builder: (context, state) => SettingsLogsPage(),
          ),
          GoRoute(
            path: '/brands',
            builder: (context, state) => Brands(),
          ),
          GoRoute(path: '/categories',
           builder: (context, state) => Categories(),
          ),
          GoRoute(path: '/subcategories',
           builder: (context, state) => Subcategories(),
          ),
          GoRoute(path: '/products',
           builder: (context, state) => Products(),
          ),
          GoRoute(path: '/notifications',
           builder: (context, state) => Notifications(),
          ),
          GoRoute(path: '/vendors',
           builder: (context, state) => Vendors(),
          ),
          GoRoute(path: '/users', 
          
           builder: (context, state) => Users(),
          ),
          GoRoute(path: '/feedback',
           builder: (context, state) => Feedback(),
          ),
          GoRoute(path: '/logout',
           builder: (context, state) => Logout(),
          ),
          GoRoute(path: '/help',
           builder: (context, state) => Help(),
          ),
        ],
      ),
    ],
  );
}
