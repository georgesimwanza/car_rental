import 'token_storage.dart';

enum SessionStatus { authenticated, unauthenticated }

class SessionManager {
  final TokenStorage _tokenStorage;

  SessionManager({required TokenStorage tokenStorage})
    : _tokenStorage = tokenStorage;

  /// Called at startup — returns current session state
  Future<SessionStatus> checkSession() async {
    final hasToken = await _tokenStorage.hasToken();
    return hasToken
        ? SessionStatus.authenticated
        : SessionStatus.unauthenticated;
  }

  /// Save everything returned by login/register API
  Future<void> saveSession({
    required String token,
    required String refreshToken,
    required String userId,
    required String role,
  }) async {
    await Future.wait([
      _tokenStorage.saveToken(token),
      _tokenStorage.saveRefreshToken(refreshToken),
      _tokenStorage.saveUserId(userId),
      _tokenStorage.saveRole(role),
    ]);
  }

  Future<void> clearSession() async {
    await _tokenStorage.clearAll();
  }
}
