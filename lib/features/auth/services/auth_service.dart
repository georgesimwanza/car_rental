import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:car_rental/features/auth/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ── Stream of auth state changes ──────────────────────────────────────────
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // ── Current Firebase user ─────────────────────────────────────────────────
  User? get currentUser => _auth.currentUser;

  // ── Register a new user ───────────────────────────────────────────────────
  Future<UserModel?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user!;

      // Update display name in Firebase Auth
      await user.updateDisplayName(name);

      // Save extra profile info to Firestore
      final userModel = UserModel(
        uid: user.uid,
        name: name,
        email: email,
        role: 'customer',
        createdAt: DateTime.now(),
      );

      await _firestore.collection('users').doc(user.uid).set(userModel.toMap());

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<UserModel?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return await _getUserFromFirestore(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // ── Sign out ──────────────────────────────────────────────────────────────
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // ── Fetch UserModel from Firestore ────────────────────────────────────────
  Future<UserModel?> _getUserFromFirestore(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) return UserModel.fromDoc(doc);
    return null;
  }

  // ── Get current user profile ──────────────────────────────────────────────
  Future<UserModel?> getCurrentUserProfile() async {
    if (currentUser == null) return null;
    return _getUserFromFirestore(currentUser!.uid);
  }

  // ── Password reset ────────────────────────────────────────────────────────
  Future<void> sendPasswordReset(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'An account with this email already exists.';
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }
}
