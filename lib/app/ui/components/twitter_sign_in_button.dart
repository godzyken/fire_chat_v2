
import 'package:flutter/material.dart';

class TwitterSignInButton extends StatelessWidget {
  TwitterSignInButton({this.labelText, this.onPressed});

  final String? labelText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          side: BorderSide(color: Colors.grey, width: 2),
          shape: CircleBorder()
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/img/twitter_logo.png"),
                height: 65.0),
          ],
        )
    );
  }
}