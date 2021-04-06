import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RedirectMiddleware extends GetMiddleware {
  @override
  RouteSettings redirect(String? route, {Object? args}) =>
      RouteSettings(name: '/auth');
}
