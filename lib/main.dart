import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:car_rental/features/auth/provider/auth_provider.dart';
//import 'providers/car_provider.dart';
import 'package:car_rental/core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase using the auto-generated firebase_options.dart
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const CarRentalApp());
}

class CarRentalApp extends StatelessWidget {
  const CarRentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        //ChangeNotifierProvider(create: (_) => CarProvider()),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            title: 'Car Rental',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF1A73E8),
                brightness: Brightness.light,
              ),
              useMaterial3: true,
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            routerConfig: AppRouter.router(context),
          );
        },
      ),
    );
  }
}
