import 'package:flutter/material.dart';
import 'package:pokedex_app/services/hive_service.dart';
import 'package:pokedex_app/utils/screen_config.dart';
import 'package:pokedex_app/views/auth/auth_page.dart';
import 'package:pokedex_app/views/home/home_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) ScreenConfig.initiaLize(context);
  }

  @override
  Widget build(BuildContext context) {
    if (HiveService.currentUser != null) {
      return const HomePage();
    } else {
      return const AuthenticationPage();
    }
  }
}
