import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:layout/layout.dart';
import 'package:melonkemo/pages/login/login_page.dart';
import 'package:melonkemo/pages/me/me_page.dart';
import 'package:melonkemo/pages/me/me_profile_page.dart';
import 'package:melonkemo/pages/router/login_router.dart';
import 'package:melonkemo/under_construction_page.dart';
import 'package:flutter_web_plugins/url_strategy.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  runApp(CoreApp());
}

class CoreApp extends StatelessWidget {

  CoreApp({super.key});
  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const UnderConstructionPage(),
      ),
      // GoRoute(
      //   path: '/',
      //   builder: (context, state) => const MePage(),
      // ),
      GoRoute(
        path: '/me',
        builder: (context, state) => const MePage(),
      ),
      GoRoute(
        path: '/legacy_me',
        builder: (context, state) => const MeProfilePage(),
      ),
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
