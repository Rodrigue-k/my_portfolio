import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_portfolio/calculator/calculator_page.dart';
import 'package:my_portfolio/calculator/theme/calculator_dark_theme.dart';
import 'package:my_portfolio/calculator/theme/calculator_light_theme.dart';
import 'package:my_portfolio/home/home_page.dart';
import 'package:my_portfolio/ofline_map/offline_map.dart';
import 'package:my_portfolio/search/search.dart';


void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = ref.watch(activeModeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isActive ? calculatorDarkTheme : calculatorLightTheme,
      title: 'My Portfolio',
      initialRoute: '/search',
      routes: {
        '/': (context) => const HomePage(),
        '/calculator': (context) => const CalculatorPage(),
        '/offline_map': (context) => const OfflineMapPage(),
        '/search': (context) => const SearchPageEssai(),
      },
    );
  }
}
