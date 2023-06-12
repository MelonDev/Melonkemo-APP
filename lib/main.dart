import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:melonkemo/pages/login/login_page.dart';
import 'package:melonkemo/under_construction_page.dart';
import 'package:flutter_web_plugins/url_strategy.dart';


void main() {
  usePathUrlStrategy();
  runApp(CoreApp());
}

class CoreApp extends StatelessWidget {
  CoreApp({super.key});

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/uc',
        builder: (context, state) => const UnderConstructionPage(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginPage(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
      ),
      builder: (context, child) => BotToastInit()(context,child),
      routerConfig: _router,
    );
  }
}
