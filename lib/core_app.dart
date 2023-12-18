import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:melonkemo/core/extensions/widget_extension.dart';
import 'package:melonkemo/pages/home/home_page.dart';
import 'package:melonkemo/pages/login/login_page.dart';
import 'package:melonkemo/pages/me/me_page.dart';
import 'package:melonkemo/pages/me/me_profile_page.dart';
import 'package:melonkemo/pages/core/shared_page.dart';
import 'package:melonkemo/pages/router/login_router.dart';
import 'package:melonkemo/pages/infrastructure/under_construction_page.dart';
import 'core/components/base_router/base_router_widget.dart';
import 'core/core/core_route.dart';

class CoreApp extends BaseRouterWidget {
  CoreApp({super.key});

  @override
  List<RouteBase> get pageRoutes => [
    const MeProfilePage().route('/'),
    const UnderConstructionPage().route('/duplicate'),
    const HomePage().route('/legacy-dev'),
    const MePage().route('/me-dev'),
    const LoginPage().route('/login'),
    const LoginRouter().route('/new_login'),
  ];

  @override
  List<RouteBase> get redirectRoutes => [
    CoreRoute.redirect('/me', to: '/'),
  ];

  @override
  List<RouteBase> get sharedRoutes => [
    SharedPage.route(
        path: 'bangkok-beasts-2023',
        url: 'https://1drv.ms/f/s!AgXh7wuvRh0Xi801NXxza4n0OoPoog?e=9M320r'),
    SharedPage.route(
        path: 'christmas-16122023',
        url: 'https://1drv.ms/f/s!AgXh7wuvRh0Xi814Ft8Dd_8swMTJkw?e=DfbLMH')
  ];

  @override
  TransitionBuilder get builder =>
          (context, child) => BotToastInit()(context, child);
}
