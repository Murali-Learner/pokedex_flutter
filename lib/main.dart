import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/app.dart';
import 'package:pokedex_app/app_theme.dart';
import 'package:pokedex_app/services/hive_service.dart';
import 'package:pokedex_app/utils/constants.dart';
import 'package:pokedex_app/utils/provider_list.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await HiveService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: getProviders(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokédex',
        navigatorKey: Constants.navigatorKey,
        theme: PokeTheme.theme,
        home: const App(),
      ),
    );
  }
}
