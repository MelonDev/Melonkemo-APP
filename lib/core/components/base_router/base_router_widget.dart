import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

abstract class BaseRouterWidget extends StatelessWidget {
  BaseRouterWidget({super.key}){
    router = GoRouter(routes: _routes);
  }

  List<RouteBase> get _routes =>
      [...pageRoutes, ...redirectRoutes, ...sharedRoutes];

  List<RouteBase> get pageRoutes;
  List<RouteBase> get redirectRoutes => [];
  List<RouteBase> get sharedRoutes => [];

  late final GoRouter router;
}