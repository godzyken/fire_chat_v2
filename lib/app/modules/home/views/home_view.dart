import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/bgmenu.jpg'))),
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: Get.height / 2.7,
                  child: Image.asset(
                    'assets/images/brvav.png',
                  ),
                ),
                // CustomContainerMenu('AGENTES', () => controller.agente()),
                // CustomContainerMenu('ARMAS', () => controller.armas()),
                // CustomContainerMenu('MAPAS', () => controller.mapas()),
                // CustomContainerMenu('TORNEIOS', () => controller.torneios()),
                // CustomContainerMenu(
                //     'PUBLICAÇÕES', () => controller.publicacoes()),
                Container(
                    margin: EdgeInsets.only(bottom: 16.0),
                    width: 300,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                    ),
                    child: TextButton(
                      onPressed: () => Get.toNamed('/auth'),
                      child: Center(
                          child: Text(
                            'X1 - estamos trabalhando nisso',
                            style: TextStyle(color: Colors.grey),
                          )),
                    ))
              ],
            )),
      ));
  }
}
