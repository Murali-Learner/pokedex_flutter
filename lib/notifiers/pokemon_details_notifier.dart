import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/services/pokemon_service.dart';

class PokemonDetailsNotifier extends ChangeNotifier {
  Pokemon? _pokemon;
  bool _hasError = false;
  String _errorMessage = '';
  bool _detailsLoading = false;
  String _selectedImageUrl = '';

  String get selectedImageUrl => _selectedImageUrl;
  bool get detailsLoading => _detailsLoading;
  Pokemon? get pokemon => _pokemon;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  final PokemonService pokemonService = PokemonService();

  void setSelectedImageUrl(String index) {
    _selectedImageUrl = index;
    notifyListeners();
  }

  Future<void> fetchPokemon(String query) async {
    try {
      _detailsLoading = true;
      notifyListeners();
      Pokemon? pokemon = await pokemonService.getPokemonByNameOrNumber(query);

      if (pokemon != null) {
        _pokemon = pokemon;
        notifyListeners();
      } else {
        _hasError = true;
        _errorMessage = "No Pokemon available";
        notifyListeners();
      }
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _detailsLoading = false;
      notifyListeners();
    }
  }

  // Future<PokemonFormModel> getPokemonFormSprites(String query) async {
  //   try {
  //     PokemonFormModel? pokemonFromSprites =
  //         await pokemonService.getPokemonForm(query);

  //     return pokemonFromSprites;
  //   } catch (e) {
  //     _errorMessage = e.toString();
  //     notifyListeners();
  //     throw Exception('No Pokemon Form Sprites available');
  //   } finally {}
  // }

  String getSpriteByIndex(PokemonSprites sprites, int index) {
    switch (index) {
      case 0:
        return sprites.frontDefault ?? '';
      case 1:
        return sprites.frontShiny ?? '';
      case 2:
        return sprites.backDefault ?? '';
      case 3:
        return sprites.backShiny ?? '';
      default:
        return '';
    }
  }
}
