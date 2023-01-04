
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class SplashUi extends StatefulWidget {
  @override
  _SplashUiState createState() => _SplashUiState();
}

class _SplashUiState extends State<SplashUi> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
