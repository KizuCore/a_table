import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../features/inventory/presentation/inventory_page.dart';
import '../features/inventory/presentation/add_food_page.dart';
import '../features/calendar/presentation/calendar_page.dart';
import 'theme.dart';

class FrigoApp extends StatelessWidget {
  const FrigoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (ctx, st) => const InventoryPage(),
          routes: [
            GoRoute(
              path: 'add',
              builder: (ctx, st) => const AddFoodPage(),
            ),
            GoRoute(
              path: 'calendar',
              builder: (ctx, st) => const CalendarPage(),
            ),
          ],
        ),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'FrigoApp',
      theme: buildTheme(),
      routerConfig: router,

      // 🌍 Localisation Flutter
      supportedLocales: const [
        Locale('fr'),
        Locale('en'),
      ],
      locale: const Locale('fr'), 
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
