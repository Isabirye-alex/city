import 'package:city/widgets/media/product_uploader.dart';
import 'package:flutter/material.dart';

// This widget is used to show a dialog for user registration.
// It displays a dialog with a specific design and constraints, allowing users to register or perform other
void showRegisterDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withAlpha(70),
    builder: (BuildContext context) {
      return const PopUpDialog(child: ProductUploader());
    },
  );
}

// actions related to user registration.
class PopUpDialog extends StatelessWidget {
  const PopUpDialog({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        backgroundColor: Colors.purpleAccent,
        insetAnimationCurve: Curves.easeInOut,
        insetAnimationDuration: Duration(milliseconds: 100),
        insetPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        shape: RoundedRectangleBorder(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            // maxHeight: 400
            maxHeight: MediaQuery.of(context).size.height * 0.4,
          ),
          child: child,
        ),
      ),
    );
  }
}
