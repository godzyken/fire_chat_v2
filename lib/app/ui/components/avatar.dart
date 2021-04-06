

import 'package:fire_chat_v2/app/data/model/models.dart';
import 'package:fire_chat_v2/app/ui/components/components.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  Avatar(
    this.user,
  );

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    if ((user?.photoUrl == '') || (user?.photoUrl == null)) {
      return LogoGraphicHeader();
    }
    return Hero(
      tag: 'User Avatar Image',
      child: CircleAvatar(
          foregroundColor: Colors.blue,
          backgroundColor: Colors.white,
          radius: 70.0,
          child: ClipOval(
            child: Image.network(
              user!.photoUrl!,
              fit: BoxFit.cover,
              width: 120.0,
              height: 120.0,
            ),
          )),
    );
  }
}