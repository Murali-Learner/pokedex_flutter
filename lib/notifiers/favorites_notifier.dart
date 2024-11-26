import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/services/favorite_service.dart';

import 'auth_notifier.dart';

class FavoritesNotifier extends ChangeNotifier {
  final FavoriteService _favoriteService = FavoriteService();

  final AuthNotifier authNotifier;

  FavoritesNotifier({
    required this.authNotifier,
  }) {
    fetchFavorites();
  }

  Map<int, Pokemon> get favorites => _favorites;

  bool _isPageLoading = false;
  bool _isButtonLoading = false;

  bool get isPageLoading => _isPageLoading;
  bool get isButtonLoading => _isButtonLoading;

  final Map<int, Pokemon> _favorites = {};

  void resetValues() {
    _isPageLoading = false;
    _isButtonLoading = false;
    _favorites.clear();
  }

  Future<void> fetchFavorites() async {
    _isPageLoading = true;
    notifyListeners();
    try {
      final userId = authNotifier.user?.uid;
      if (userId != null) {
        final results = await _favoriteService.fetchFavorites(userId);

        for (Pokemon pokemon in results) {
          _favorites[pokemon.id] = pokemon;
        }
        notifyListeners();
      }
    } finally {
      _isPageLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(Pokemon pokemon) async {
    _isButtonLoading = true;
    notifyListeners();
    try {
      final userId = authNotifier.user?.uid;
      if (userId != null) {
        await _favoriteService.toggleFavorite(userId, pokemon);

        if (pokemon.isFav) {
          _favorites.remove(pokemon.id);
          notifyListeners();
        } else {
          _favorites[pokemon.id] = pokemon;
          notifyListeners();
        }
      }
    } finally {
      _isButtonLoading = false;
      notifyListeners();
    }
  }
}
