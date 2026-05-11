import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/storage/token_storage.dart';
import 'core/storage/session_manager.dart';
import 'core/router/app_router.dart';
import 'features/auth/services/auth_service.dart';
import 'features/auth/controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final tokenStorage = TokenStorage();
  final sessionManager = SessionManager(tokenStorage: tokenStorage);
  final authService =
      AuthService(); // no constructor params — uses http directly
  final authController = AuthController(
    authService: authService,
    sessionManager: sessionManager,
  );

  // Restore session before first frame (checks secure storage for a saved token)
  await sessionManager.checkSession();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider.value(value: authController)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Car Rental',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      routerConfig: AppRouter.router(context),
    );
  }
}
