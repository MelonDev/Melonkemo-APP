import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:layout/layout.dart';

abstract class BaseRouterWidget extends StatelessWidget {
  BaseRouterWidget({super.key}){
    _router = GoRouter(routes: _routes);
  }

  List<RouteBase> get _routes =>
      [...pageRoutes, ...redirectRoutes, ...sharedRoutes];

  List<RouteBase> get pageRoutes;
  List<RouteBase> get redirectRoutes => [];
  List<RouteBase> get sharedRoutes => [];

  late final GoRouter _router;
  TransitionBuilder get builder;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return Layout(
      format: FluidLayoutFormat(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        color: Colors.black,
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        builder: builder,
        routerConfig: _router,
      ),
    );
  }
}