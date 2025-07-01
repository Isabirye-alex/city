// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class AResponsiveWidget extends StatelessWidget {
  const AResponsiveWidget({
    super.key,
    required this.Desktop,
    required this.Tablet,
    required this.Mobile,
  });
  final Widget Desktop;
  final Widget Tablet;
  final Widget Mobile;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => constraints.maxWidth >= 1000
          ? Desktop
          : constraints.maxWidth >= 300
          ? Tablet
          : Mobile,
    );
  }
}
