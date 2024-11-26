import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokedex_app/models/user_model.dart';
import 'package:pokedex_app/repositories/auth_repo.dart';

class AuthResult {
  final bool success;
  final String? error;
  final UserModel? user;

  AuthResult({
    required this.success,
    this.error,
    this.user,
  });

  @override
  String toString() {
    return 'AuthResult(success: $success, error: $error, user: $user)';
  }
}

class AuthService {
  final AuthRepository _repository;

  AuthService({AuthRepository? repository})
      : _repository = repository ?? AuthRepository();

  Stream<UserModel?> get userStream => _repository.userStream;

  Future<UserModel?> get currentUser => _repository.currentUser;

  Future<AuthResult> signInWithGoogle() async {
    try {
      final user = await _repository.signInWithGoogle();

      if (user == null) {
        return AuthResult(
          success: false,
          error: 'Sign in aborted by user',
        );
      }

      return AuthResult(
        success: true,
        user: user,
      );
    } on FirebaseAuthException catch (e) {
      return AuthResult(
        success: false,
        error: _getFirebaseAuthErrorMessage(e.code),
      );
    } catch (e) {
      return AuthResult(
        success: false,
        error: 'An unexpected error occurred',
      );
    }
  }

  Future<AuthResult> updateUser(UserModel user) async {
    try {
      await _repository.updateUser(user);
      return AuthResult(success: true, user: user);
    } catch (e) {
      return AuthResult(
        success: false,
        error: 'Failed to update user data',
      );
    }
  }

  Future<AuthResult> signOut() async {
    try {
      await _repository.signOut();
      return AuthResult(success: true);
    } catch (e) {
      return AuthResult(
        success: false,
        error: 'Failed to sign out',
      );
    }
  }

  String _getFirebaseAuthErrorMessage(String code) {
    switch (code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'This email address is already in use.';
      case 'operation-not-allowed':
        return 'This sign-in method is not allowed.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with a different credential.';
      case 'invalid-credential':
        return 'The provided credential is invalid.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'requires-recent-login':
        return 'Please log in again to perform this operation.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different user.';
      case 'invalid-verification-code':
        return 'The verification code is invalid.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid.';
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }
}
