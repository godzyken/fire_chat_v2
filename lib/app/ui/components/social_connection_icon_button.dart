import 'package:flutter/material.dart';

class SocialConnectionIconButton extends StatelessWidget {
  const SocialConnectionIconButton(
      {required this.labelText, this.onPressed, this.img});

  final String? labelText;
  final void Function()? onPressed;
  final Image? img;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          shape: CircleBorder(side: BorderSide.none),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            img!,
          ],
        ));
  }
}
