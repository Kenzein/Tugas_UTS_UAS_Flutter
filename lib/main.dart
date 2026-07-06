import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:money_laundry/providers/customer_provider.dart';
import 'package:money_laundry/providers/history_provider.dart';
import 'package:money_laundry/providers/service_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'providers/order_provider.dart';
import 'providers/report_provider.dart';
import 'providers/profile_provider.dart';
import 'providers/theme_provider.dart';

import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),

        ChangeNotifierProvider(create: (_) => OrderProvider()),

        ChangeNotifierProvider(create: (_) => ReportProvider()),

        ChangeNotifierProvider(create: (_) => ProfileProvider()),

        ChangeNotifierProvider(create: (_) => ServiceProvider()),
        ChangeNotifierProvider(create: (_) => CustomerProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Money Laundry',
            themeMode: themeProvider.themeMode,
            theme: ThemeData(
              brightness: Brightness.light,
              scaffoldBackgroundColor: const Color(0xFFF6F9FC),
              primaryColor: const Color(0xFF2F5274),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF2F5274),
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              cardColor: Colors.white,
              iconTheme: const IconThemeData(color: Color(0xFF2F5274)),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: const Color(0xFF0E1726),
              primaryColor: const Color(0xFF4F6D9E),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF121B2F),
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              cardColor: const Color(0xFF152438),
              iconTheme: const IconThemeData(color: Color(0xFF96A6C8)),
              textTheme: ThemeData.dark().textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
