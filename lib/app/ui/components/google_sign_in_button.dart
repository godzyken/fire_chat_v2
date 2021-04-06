import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  GoogleSignInButton({this.labelText, this.onPressed});

  final String? labelText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          shape: CircleBorder(side: BorderSide.none),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage("assets/img/google_logo.png"), height: 65.0),
          ],
        ));
  }
}
