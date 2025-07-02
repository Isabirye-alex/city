import 'package:city/widgets/reusables/popup.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 400,
      decoration: BoxDecoration(color: Colors.white),
      child: PopUpDialog(
        child: Text(
          'I am the pop up dialog',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
