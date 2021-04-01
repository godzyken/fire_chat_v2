import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cha_t_nel_controller.dart';

class ChaTNelView extends GetView<ChaTNelController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChaTNelView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ChaTNelView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
