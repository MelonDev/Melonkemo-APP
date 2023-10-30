import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:layout/layout.dart';
import 'package:melonkemo/pages/home/home_page.dart';
import 'package:melonkemo/pages/login/login_page.dart';
import 'package:melonkemo/pages/me/me_page.dart';
import 'package:melonkemo/pages/me/me_profile_page.dart';
import 'package:melonkemo/pages/me/redirect_me_page.dart';
import 'package:melonkemo/pages/router/login_router.dart';
import 'package:melonkemo/under_construction_page.dart';
import 'package:flutter_web_plugins/url_strategy.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white.withOpacity(0.02),
      systemNavigationBarContrastEnforced: true,
      systemNavigationBarIconBrightness: Brightness.dark));
  runApp(CoreApp());
}

class CoreApp extends StatelessWidget {

  CoreApp({super.key});
  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MeProfilePage(),
      ),
      // GoRoute(
      //   path: '/',
      //   builder: (context, state) => const UnderConstructionPage(),
      // ),
      GoRoute(
        path: '/legacy-dev',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/me',
        redirect: (BuildContext context,GoRouterState state) => "/",
        builder: (context, state) => Container(),

        //builder: (context, state) => const RedirectMePage(),
      ),
      GoRoute(
        path: '/me-dev',
        builder: (context, state) => const MePage(),
      ),
      // GoRoute(
      //   path: '/legacy-me',
      //   builder: (context, state) => const MeProfilePage(),
      // ),
      // GoRoute(
      //   path: '/dev',
      //   builder: (context, state) => const MeProfilePage(),
      // ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/new_login',
        builder: (context, state) => const LoginRouter(),
      ),
    ],
  );

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
        builder: (context, child) => BotToastInit()(context,child),
        routerConfig: _router,
      ),
    );
  }
}
