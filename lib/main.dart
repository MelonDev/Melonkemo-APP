import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'core_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white.withOpacity(0.02),
      systemNavigationBarContrastEnforced: true,
      systemNavigationBarIconBrightness: Brightness.dark));
  runApp(CoreApp());
}