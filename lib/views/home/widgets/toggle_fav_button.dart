import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/notifiers/favorites_notifier.dart';
import 'package:pokedex_app/notifiers/pokemon_notifier.dart';
import 'package:pokedex_app/utils/provider_list.dart';
import 'package:provider/provider.dart';

class ToggleFavButton extends StatefulWidget {
  const ToggleFavButton({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  State<ToggleFavButton> createState() => _ToggleFavButtonState();
}

class _ToggleFavButtonState extends State<ToggleFavButton> {
  bool _isLoading = false;

  Future<void> toggleFav() async {
    setState(() {
      _isLoading = true;
    });
    await GetProvider.favoritesNotifier
        .toggleFavorite(widget.pokemon)
        .whenComplete(() {
      GetProvider.pokemonNotifier.updatePokemon(widget.pokemon);
    });
    setState(() {
      widget.pokemon.isFav = !widget.pokemon.isFav;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<FavoritesNotifier, PokemonNotifier>(
      builder: (context, favProvider, pokeProvider, _) {
        return IconButton(
          onPressed: _isLoading
              ? null
              : () async {
                  await toggleFav();
                },
          icon: _isLoading
              ? const Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                    ),
                  ),
                )
              : Icon(
                  widget.pokemon.isFav ? Icons.favorite : Icons.favorite_border,
                  color: widget.pokemon.isFav ? Colors.red : null,
                ),
        );
      },
    );
  }
}
