import 'package:city/illustrate/admin_shell.dart';
import 'package:city/illustrate/dashboard.dart';
import 'package:city/illustrate/detail.dart';
import 'package:city/illustrate/s_datail.dart' show SettingsLogsPage;
import 'package:city/illustrate/settings.dart';
import 'package:city/illustrate/u_detail.dart';
import 'package:city/illustrate/user_page.dart';
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
        ],
      ),
    ],
  );
}
