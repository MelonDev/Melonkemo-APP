import 'package:flutter/material.dart';
import 'package:layout/layout.dart';
import 'package:melonkemo/pages/login/login_mobile_page.dart';
import 'package:melonkemo/pages/login/login_tablet_page.dart';

class LoginRouter extends StatelessWidget {
  const LoginRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      xs: (context) => const LoginMobilePage(),
      md: (context) => const LoginTabletPage(),
    );
  }
}
