import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:car_rental/features/auth/view/login_view.dart';
import 'package:car_rental/features/auth/view/register_view.dart';
import 'package:car_rental/features/product/view/home_view.dart';
import 'package:car_rental/features/auth/provider/auth_provider.dart'; // update path if different

class AppRouter {
  static GoRouter router(BuildContext context) {
    return GoRouter(
      initialLocation: '/login',
      redirect: (context, state) {
        final auth = Provider.of<AuthProvider>(context, listen: false);
        final isLoggedIn = auth.isLoggedIn;
        final isAuthRoute =
            state.matchedLocation == '/login' ||
            state.matchedLocation == '/register';

        if (!isLoggedIn && !isAuthRoute) return '/login';
        if (isLoggedIn && isAuthRoute) return '/cars';
        return null;
      },
      routes: [
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginView(),
        ),
        GoRoute(
          path: '/register',
          name: 'register',
          builder: (context, state) => const RegisterView(),
        ),

        GoRoute(
          path: '/cars',
          name: 'car-list',
          builder: (context, state) => const HomeView(),
        ),
      ],
      errorBuilder: (context, state) =>
          Scaffold(body: Center(child: Text('Page not found: ${state.error}'))),
    );
    /*GoRoute(
          path: '/cars/:id',
          name: 'car-detail',
          builder: (context, state) {
            final carId = state.pathParameters['id']!;
            return CarDetailScreen(carId: carId);
          },
        ),
        GoRoute(
          path: '/cars/add',
          name: 'add-car',
          builder: (context, state) => const AddCarScreen(),
        ),
      ],
     */
  }
}
