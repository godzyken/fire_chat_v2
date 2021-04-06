
import 'package:flutter/material.dart';

class FacebookSignInButton extends StatelessWidget {
  FacebookSignInButton({this.labelText, this.onPressed, this.onLongPressed});

  final String? labelText;
  final void Function()? onPressed;
  final void Function()? onLongPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          shape: CircleBorder(side: BorderSide.none )
        ),
        onPressed: onPressed,
        onLongPress: onLongPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/img/facebook_logo.png"),
                height: 65.0),
          ],
        )
    );
  }
}