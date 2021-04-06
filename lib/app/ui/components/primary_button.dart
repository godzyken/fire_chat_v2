import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({this.labelText, this.onPressed});

  final String? labelText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.blueAccent,
        elevation: 1,
        padding: EdgeInsets.all(22),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        labelText!.toUpperCase(),
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}