import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/notifiers/pokemon_details_notifier.dart';
import 'package:pokedex_app/utils/global_network_image.dart';
import 'package:pokedex_app/utils/screen_config.dart';
import 'package:provider/provider.dart';

class PokemonImage extends StatelessWidget {
  const PokemonImage({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Consumer<PokemonDetailsNotifier>(builder: (context, provider, _) {
      return Container(
        height: ScreenConfig.height * 0.5,
        padding: const EdgeInsets.all(50),
        decoration: BoxDecoration(
          color: const Color(0xFFb4d9d6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: provider.selectedImageUrl.isEmpty
            ? GlobalNetworkImage(
                imageUrl: pokemon.imageUrl,
              )
            : Transform.scale(
                scale: 1.0,
                child: GlobalNetworkImage(
                  imageUrl: provider.selectedImageUrl,
                ),
              ),
      );
    });
  }
}
