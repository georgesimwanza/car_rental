import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_rental/features/auth/controllers/auth_controller.dart';
import 'package:car_rental/features/auth/view/login_view.dart';
// adjust to your home screen path

/// The entry widget of the app. Listens to AuthController and
/// renders either the authenticated or unauthenticated tree.
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isChecking = true;

  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    // SessionManager.checkSession() is called in main.dart before runApp,
    // so by the time we get here the AuthController already knows the state.
    // This small delay just ensures the first frame has painted.
    await Future.microtask(() {});
    if (mounted) setState(() => _isChecking = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isChecking) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Consumer<AuthController>(
      builder: (context, auth, _) {
        if (auth.isAuthenticated) {
          //return const HomeView();
        }
        return const LoginView();
      },
    );
  }
}
