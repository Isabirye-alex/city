import 'package:city/core/app_router.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(MyAdminApp());
}

class MyAdminApp extends StatelessWidget {
  const MyAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeAnimationCurve: Curves.decelerate,
      title: 'Admin Dashboard',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF1C1C2D),
        cardColor: Color(0xFF2A2D3E),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF1C1C2D),
          elevation: 0,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      routerConfig: AppRouter.router,
    );
  }
}
