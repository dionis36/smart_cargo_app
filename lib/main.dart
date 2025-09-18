import 'package:flutter/material.dart';
import 'package:retailfleet/screens/mainScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'), // Changed from Locale('en', 'US')
        Locale('sw'), // Changed from Locale('sw', 'TZ')
      ],
      path: 'lib/langs',
      fallbackLocale: const Locale('en'), // Changed from Locale('en', 'US')
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DarFleet Delivery',
      theme: ThemeData(
        primaryColor: const Color(0xFFDB7D00),
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        textTheme: GoogleFonts.openSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: MainScreen(),
      debugShowCheckedModeBanner: false,

      // 🔑 This enables localization
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}