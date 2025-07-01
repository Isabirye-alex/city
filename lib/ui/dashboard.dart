import 'package:city/widgets/desktop.widget.dart';
import 'package:city/widgets/responsive.widget.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(padding: EdgeInsets.all(12),
      child: AResponsiveWidget(
        Desktop: Desktopwidget(), 
        Tablet: Desktopwidget(),
         Mobile: Desktopwidget())
    );
  }
}