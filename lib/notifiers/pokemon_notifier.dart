import 'package:flutter/material.dart';
import 'package:pokedex_app/models/poke_api_model.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/notifiers/auth_notifier.dart';
import 'package:pokedex_app/services/favorite_service.dart';
import 'package:pokedex_app/services/hive_service.dart';
import 'package:pokedex_app/services/pokemon_service.dart';
import 'package:pokedex_app/utils/toast_utils.dart';

class PokemonNotifier with ChangeNotifier {
  final PokemonService pokemonService = PokemonService();
  final FavoriteService favoriteService = FavoriteService();
  final AuthNotifier authNotifier;

  PokemonNotifier({
    required this.authNotifier,
  });

  final TextEditingController searchController = TextEditingController();
  final Map<int, Pokemon> _pokemons = {};
  Map<int, Pokemon> _searchResults = {};
  bool _isInitialLoading = false;
  bool _isPaginationLoading = false;
  bool _hasError = false;
  String _error = '';
  bool _hasMore = true;
  int _currentOffset = 0;
  String _searchQuery = '';
  static const int _limit = 20;

  Map<int, Pokemon> get pokemons =>
      _searchQuery.isEmpty ? _pokemons : _searchResults;
  bool get isInitialLoading => _isInitialLoading;
  bool get isPaginationLoading => _isPaginationLoading;
  bool get hasError => _hasError;
  String get error => _error;
  bool get hasMore => _searchQuery.isEmpty ? _hasMore : false;

  Future<List<Pokemon>> getFirebasePokemonsList() async {
    final List<Pokemon> firebasePokemonList =
        await favoriteService.fetchFavorites(HiveService.currentUser!.uid);
    return firebasePokemonList;
  }

  void updatePokemon(Pokemon updatedPokemon) {
    if (pokemons.containsKey(updatedPokemon.id)) {
      updatedPokemon = updatedPokemon.copyWith(isFav: !updatedPokemon.isFav);
      pokemons[updatedPokemon.id] = updatedPokemon;
      notifyListeners();
    }
  }

  Future<void> fetchPokemons() async {
    if (_shouldPreventFetching()) return;

    _prepareForFetching();

    try {
      final fetchedPokemons = await _fetchAndProcessPokemonList();
      _updatePokemonState(fetchedPokemons);
    } catch (e) {
      _handleFetchingError(e);
    } finally {
      _finalizeFetching();
    }
  }

  bool _shouldPreventFetching() {
    return _isPaginationLoading || !_hasMore || _searchQuery.isNotEmpty;
  }

  void _prepareForFetching() {
    _isInitialLoading = _pokemons.isEmpty;
    _isPaginationLoading = !_isInitialLoading;
    _hasError = false;
    notifyListeners();
  }

  Future<List<Pokemon>> _fetchAndProcessPokemonList() async {
    final PokemonListModel response = await pokemonService.getPokemonList(
      offset: _currentOffset,
      limit: _limit,
    );

    final List<Pokemon> firebasePokemonList = await getFirebasePokemonsList();

    return _mergePokemonLists(response.results, firebasePokemonList);
  }

  List<Pokemon> _mergePokemonLists(
      List<Pokemon> apiPokemonList, List<Pokemon> firebasePokemonList) {
    return apiPokemonList.map((apiPokemon) {
      final favoritePokemon = firebasePokemonList.firstWhere(
          (favPokemon) => favPokemon.id == apiPokemon.id,
          orElse: () => apiPokemon);

      return favoritePokemon.id == apiPokemon.id ? favoritePokemon : apiPokemon;
    }).toList();
  }

  void _updatePokemonState(List<Pokemon> pokemonsList) {
    for (Pokemon pokemon in pokemonsList) {
      _logFavoritePokemon(pokemon);
      _pokemons[pokemon.id] = pokemon;
    }

    _hasMore = pokemonsList.length == _limit;
    _currentOffset += _limit;
    notifyListeners();
  }

  void _logFavoritePokemon(Pokemon pokemon) {
    if (pokemon.isFav) {
      debugPrint("Favorite Pokemon: ${pokemon.toJson()}");
    }
  }

  void _handleFetchingError(Object e) {
    _hasError = true;
    _error = e.toString();
    ToastUtils.showErrorToast(_error);
  }

  void _finalizeFetching() {
    _isInitialLoading = false;
    _isPaginationLoading = false;
    notifyListeners();
  }

  Future<void> searchPokemons(
      String query, List<Pokemon> favPokemonsList) async {
    _initializeSearch(query);

    if (_searchQuery.isEmpty) {
      _clearSearchResults();
      return;
    }

    try {
      _prepareForSearch();
      _performLocalSearch();

      if (_searchResults.isEmpty) {
        await _performRemoteSearch(favPokemonsList);
      }
    } catch (e) {
      _handleSearchError(e);
    } finally {
      _finalizeSearch();
    }
  }

  void _initializeSearch(String query) {
    _searchQuery = query.trim().toLowerCase();
  }

  void _clearSearchResults() {
    _searchResults = {};
    notifyListeners();
  }

  void _prepareForSearch() {
    _isInitialLoading = true;
    _hasError = false;
    notifyListeners();
  }

  void _performLocalSearch() {
    _searchResults = Map<int, Pokemon>.fromEntries(
      _pokemons.entries.where(
        (entry) =>
            entry.value.name.toLowerCase().contains(_searchQuery) ||
            entry.value.id.toString() == _searchQuery,
      ),
    );
  }

  Future<void> _performRemoteSearch(List<Pokemon> favPokemonsList) async {
    debugPrint("No results found in local search, querying service...");

    try {
      Pokemon? pokemon =
          await pokemonService.getPokemonByNameOrNumber(_searchQuery);

      if (pokemon != null) {
        _addRemoteSearchResult(pokemon, favPokemonsList);
      }
    } catch (e) {
      _handleRemoteSearchError(e);
    }
  }

  void _addRemoteSearchResult(Pokemon pokemon, List<Pokemon> favPokemonsList) {
    debugPrint("Pokemon fetched: ${pokemon.toJson()}");
    final Pokemon favPokemon = favPokemonsList.firstWhere(
      (element) => element.id == pokemon.id,
      orElse: () => pokemon,
    );
    _searchResults[pokemon.id] = favPokemon;
  }

  void _handleRemoteSearchError(Object e) {
    _searchResults = {};
    _error = e.toString().contains('404') ? 'No Pokémon found' : e.toString();
  }

  void _handleSearchError(Object e) {
    _hasError = true;
    _error = e.toString();
    ToastUtils.showErrorToast(_error);
    _searchResults = {};
  }

  void _finalizeSearch() {
    _isInitialLoading = false;
    notifyListeners();
  }

  void refresh() {
    _pokemons.clear();
    _searchResults.clear();
    _currentOffset = 0;
    _hasMore = true;
    _hasError = false;
    _searchQuery = '';
    searchController.clear();
    fetchPokemons();
  }

  void resetValues() {
    _pokemons.clear();
    _searchResults.clear();
    _currentOffset = 0;
    _hasMore = true;
    _hasError = false;
    _searchQuery = '';
    searchController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
