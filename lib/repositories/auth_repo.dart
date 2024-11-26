import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pokedex_app/models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Get Firestore user document reference
  DocumentReference<Map<String, dynamic>> _getUserRef(String uid) {
    return _firestore.collection('users').doc(uid);
  }

  // Stream of auth state changes with UserModel
  Stream<UserModel?> get userStream {
    return _auth.authStateChanges().asyncMap((user) async {
      if (user == null) return null;
      return await getUserById(user.uid);
    });
  }

  // Get current UserModel
  Future<UserModel?> get currentUser async {
    final user = _auth.currentUser;
    if (user == null) return null;
    return await getUserById(user.uid);
  }

  // Get user by ID
  Future<UserModel?> getUserById(String uid) async {
    final doc = await _getUserRef(uid).get();
    if (!doc.exists) return null;
    return UserModel.fromFirestore(doc);
  }

  // Create or update user in Firestore
  Future<void> _updateUserData(UserModel user) async {
    await _getUserRef(user.uid)
        .set(user.toFirestore(), SetOptions(merge: true));
  }

  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user == null) return null;

      // Check if user exists in Firestore
      final userDoc = await _getUserRef(user.uid).get();
      late UserModel userModel;

      if (!userDoc.exists) {
        // Create new user
        userModel = UserModel.fromFirebaseUser(
          user,
          createdAt: DateTime.now(),
        );
      } else {
        // Update existing user
        userModel = UserModel.fromFirestore(userDoc).copyWith(
          lastSignIn: DateTime.now(),
          displayName: user.displayName,
          photoURL: user.photoURL,
        );
      }

      // Update Firestore
      await _updateUserData(userModel);
      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(UserModel user) async {
    await _updateUserData(user);
  }

  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      rethrow;
    }
  }
}
