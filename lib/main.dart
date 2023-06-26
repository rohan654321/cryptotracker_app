import 'package:cryptotracker_app/Constants/Themes.dart';
import 'package:cryptotracker_app/Models/localStorage.dart';
import 'package:cryptotracker_app/Provider/Theme_provider.dart';
import 'package:cryptotracker_app/Provider/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String currentTheme = await LocalStorage.getTheme() ?? "light";

  runApp(MyApp(
    theme: currentTheme,
  ));
}

class MyApp extends StatelessWidget {
  final String theme;
  MyApp({required this.theme});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<MarketProvider>(
            create: (context) => MarketProvider(),
          ),
          ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(theme),
          ),
        ],
        child:
            Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: HomePage(),
          );
        }));
  }
}
