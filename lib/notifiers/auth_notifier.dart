import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/models/user_model.dart';
import 'package:pokedex_app/services/auth_service.dart';
import 'package:pokedex_app/services/hive_service.dart';
import 'package:pokedex_app/utils/constants.dart';
import 'package:pokedex_app/utils/toast_utils.dart';
import 'package:pokedex_app/views/home/home_page.dart';

class AuthNotifier extends ChangeNotifier {
  final AuthService _authService = AuthService();
  StreamSubscription<UserModel?>? _userSubscription;

  bool _isLoading = false;
  String? _error;
  UserModel? _user;

  AuthNotifier() {
    _initialize();
  }

  bool get isLoading => _isLoading;
  String? get error => _error;
  UserModel? get user => _user;
  bool get isLoggedIn => _user != null;

  void _initialize() {
    _userSubscription = _authService.userStream.listen(
      (user) {
        _user = user;
        notifyListeners();
      },
      onError: (error) {
        _error = error.toString();
        notifyListeners();
      },
    );
  }

  Future<void> signInWithGoogle() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final result = await _authService.signInWithGoogle();

      if (result.success) {
        _user = result.user;
        await HiveService.saveUser(_user!);
        Constants.navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
          builder: (context) => const HomePage(),
        ));
      } else {
        _error = result.error;
        ToastUtils.showErrorToast(_error!);
      }
    } catch (e) {
      _error = 'An unexpected error occurred';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUser({
    String? displayName,
    List<Pokemon>? favorites,
  }) async {
    if (_user == null) return;

    try {
      _isLoading = true;
      notifyListeners();

      final updatedUser = _user!.copyWith(
        displayName: displayName,
        favorites: favorites,
      );

      final result = await _authService.updateUser(updatedUser);

      if (!result.success) {
        _error = result.error;
        ToastUtils.showErrorToast(_error!);
      }
      await HiveService.saveUser(result.user!);
    } catch (e) {
      _error = 'Failed to update user data';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final result = await _authService.signOut();

      if (!result.success) {
        _error = result.error;
        ToastUtils.showErrorToast(_error!);
      }
      await HiveService.clearDB();
    } catch (e) {
      _error = 'Failed to sign out';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _userSubscription?.cancel();

    super.dispose();
  }
}
