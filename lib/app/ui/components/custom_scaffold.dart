import 'package:fire_chat_v2/app/themes/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    Key? key,
    this.titleText = 'Your Title',
    this.child,
    this.showAppBar = true,
    this.showDrawer = false,
    this.showAppBarActions = false,
    this.enableDarkMode = false,
    this.drawerChild,
    Widget? bottomSheet,
    this.actions,
  })  : _bottomSheet = bottomSheet,
        super(key: key);

  final String titleText;
  final Widget? child;
  final bool showAppBar;
  final bool showAppBarActions;
  final bool showDrawer;
  final bool enableDarkMode;
  final Widget? drawerChild;
  final Widget? _bottomSheet;
  final List<Widget>? actions;

  static TextStyle get light => TextStyle();
  static TextStyle get dark => TextStyle();

  List<Widget>? get _showActions {
    if (showAppBarActions) {
      return actions;
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    //

    return Theme(
      data: enableDarkMode
          ? ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: AppThemes.fontFamily,
        ),
      )
          : AppThemes.darkTheme,
      child: Scaffold(
        appBar: showAppBar
            ? AppBar(
          actions: _showActions,
          title: Text(titleText, style: enableDarkMode ? dark : light),
        )
            : null,
        body: child ?? const Center(child: Text('Hi there')),
        endDrawer: showDrawer ? drawerChild : null,
        bottomSheet: _bottomSheet,
      ),
    );
  }
}