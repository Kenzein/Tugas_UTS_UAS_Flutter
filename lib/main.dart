import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

import 'providers/auth_provider.dart';
import 'providers/order_provider.dart';
import 'providers/report_provider.dart';
import 'providers/profile_provider.dart';

import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => OrderProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => ReportProvider(),
        ),

        // Provider Baru
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(),
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Money Laundry',
        home: const SplashScreen(),
      ),
    );
  }
}