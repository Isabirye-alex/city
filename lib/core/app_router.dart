import 'package:city/ui/admin_shell.dart';
import 'package:city/ui/analytics.dart';
import 'package:city/ui/brands.dart';
import 'package:city/ui/categories.dart';
import 'package:city/ui/dashboard.dart';
import 'package:city/ui/feedback.dart';
import 'package:city/ui/help.dart';
import 'package:city/ui/logout.dart';
import 'package:city/ui/notifications.dart';
import 'package:city/ui/orders.dart';
import 'package:city/ui/products.dart';
import 'package:city/ui/reports.dart';
import 'package:city/ui/settings.dart';
import 'package:city/ui/subcategories.dart';
import 'package:city/ui/users.dart';
import 'package:city/ui/vendors.dart';
import 'package:city/widgets/media/media_uploader.dart';
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
            routes: [
              GoRoute(
                path: 'addproduct',
                builder: (contex, state) => MediaUploader(),
              ),
            ],
          ),
          GoRoute(path: '/brands', builder: (context, state) => Brands()),
          GoRoute(
            path: '/categories',
            builder: (context, state) => Categories(),
          ),
          GoRoute(
            path: '/subcategories',
            builder: (context, state) => Subcategories(),
          ),
          GoRoute(path: '/orders', builder: (context, state) => Orders()),
          GoRoute(path: '/products', builder: (context, state) => Products()),
          GoRoute(
            path: '/notifications',
            builder: (context, state) => Notifications(),
          ),
          GoRoute(path: '/vendors', builder: (context, state) => Vendors()),
          GoRoute(path: '/users', builder: (context, state) => Users()),
          GoRoute(path: '/feedback', builder: (context, state) => Feedback()),
          GoRoute(path: '/logout', builder: (context, state) => Logout()),
          GoRoute(path: '/help', builder: (context, state) => Help()),
          GoRoute(path: '/analytics', builder: (context, state) => Analytics()),
          GoRoute(path: '/reports', builder: (context, state) => Reports()),
          GoRoute(path: '/settings', builder: (context, state) => Settings()),

          //Mini routes
        ],
      ),
    ],
  );
}
