import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:layout/layout.dart';
import 'package:melonkemo/core/extensions/widget_extension.dart';
import 'package:melonkemo/pages/home/home_page.dart';
import 'package:melonkemo/pages/login/login_page.dart';
import 'package:melonkemo/pages/me/me_page.dart';
import 'package:melonkemo/pages/me/me_profile_page.dart';
import 'package:melonkemo/pages/core/shared_page.dart';
import 'package:melonkemo/pages/router/login_router.dart';
import 'package:melonkemo/under_construction_page.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'core/components/base_router/base_router_widget.dart';
import 'core/core/core_route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white.withOpacity(0.02),
      systemNavigationBarContrastEnforced: true,
      systemNavigationBarIconBrightness: Brightness.dark));
  runApp(CoreApp());
}

class CoreApp extends BaseRouterWidget {
  CoreApp({super.key});

  @override
  List<RouteBase> get pageRoutes => [
        const MeProfilePage().route("/"),
        const UnderConstructionPage().route("/duplicate"),
        const HomePage().route("/legacy-dev"),
        const MePage().route("/me-dev"),
        const LoginPage().route("/login"),
        const LoginRouter().route("/new_login"),
      ];

  @override
  List<RouteBase> get redirectRoutes => [
        CoreRoute.redirect("/me", to: "/"),
      ];

  @override
  List<RouteBase> get sharedRoutes => [
        SharedPage.route(
            path: "bangkok-beasts-2023",
            url: "https://1drv.ms/f/s!AgXh7wuvRh0Xi801NXxza4n0OoPoog?e=9M320r")
      ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return Layout(
      format: FluidLayoutFormat(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        color: Colors.black,
        theme: ThemeData(
          primaryColor: Colors.blueAccent,
        ),
        builder: (context, child) => BotToastInit()(context, child),
        routerConfig: router,
      ),
    );
  }
}