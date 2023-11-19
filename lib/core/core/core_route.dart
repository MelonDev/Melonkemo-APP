import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:melonkemo/pages/core/shared_page.dart';

class CoreRoute {
  static RouteBase builder(String path, GoRouterWidgetBuilder builder) =>
      GoRoute(
        path: path,
        builder: builder,
      );

  static RouteBase page(String path, Widget page) => GoRoute(
        path: path,
        builder: (context, state) => page,
      );

  static RouteBase redirect(String path, {required String to}) => GoRoute(
        path: path,
        redirect: (context, state) => to,
        builder: (context, state) => Container(),
      );

  static RouteBase url(String path, String url) => GoRoute(
        path: path,
        builder: (context, state) => SharedPage(
          url: url,
        ),
      );
}
