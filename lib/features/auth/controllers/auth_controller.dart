import 'package:flutter/foundation.dart';
import 'package:car_rental/features/auth/models/user_model.dart';
import 'package:car_rental/features/auth/services/auth_service.dart';
import 'package:car_rental/core/storage/session_manager.dart';

enum AuthStatus { idle, loading, authenticated, unauthenticated, error }

class AuthController extends ChangeNotifier {
  final AuthService _authService;
  final SessionManager _sessionManager;

  AuthController({
    required AuthService authService,
    required SessionManager sessionManager,
  }) : _authService = authService,
       _sessionManager = sessionManager;

  AuthStatus _status = AuthStatus.unauthenticated;
  UserModel? _user;
  String? _errorMessage;

  AuthStatus get status => _status;
  UserModel? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == AuthStatus.loading;
  bool get isAuthenticated => _status == AuthStatus.authenticated;

  Future<bool> login({required String email, required String password}) async {
    _setLoading();
    try {
      _user = await _authService.login(email, password);

      await _sessionManager.saveSession(
        token: _user!.token ?? '',
        refreshToken: _user!.refreshToken ?? '',
        userId: _user!.id,
        role: _user!.role ?? '',
      );

      _status = AuthStatus.authenticated;
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  Future<bool> register({
    required String username,
    required String email,
    required String password,
    required String role,
    required String address,
    required String phoneNumber,
  }) async {
    _setLoading();
    try {
      _user = await _authService.register(
        username: username,
        email: email,
        token: '', // backend generates this; pass empty or remove from API call
        password: password,
        role: role,
        address: address,
        phoneNumber: phoneNumber,
      );

      await _sessionManager.saveSession(
        token: _user!.token ?? '',
        refreshToken: _user!.refreshToken ?? '',
        userId: _user!.id,
        role: _user!.role ?? '',
      );

      _status = AuthStatus.authenticated;
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  Future<void> logout() async {
    _setLoading();
    await _sessionManager.clearSession();
    _user = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void _setLoading() {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();
  }

  void _setError(String message) {
    _status = AuthStatus.error;
    _errorMessage = message;
    notifyListeners();
  }
}
