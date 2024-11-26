import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/utils/extensions/context_extension.dart';
import 'package:pokedex_app/utils/global_network_image.dart';
import 'package:pokedex_app/utils/provider_list.dart';
import 'package:pokedex_app/views/home/widgets/toggle_fav_button.dart';

import '../../details/details_page.dart';

class PokemonCard extends StatefulWidget {
  final Pokemon pokemon;
  final int index;

  const PokemonCard({
    super.key,
    required this.pokemon,
    required this.index,
  });

  @override
  State<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard> {
  late final Color cardColor;

  @override
  void initState() {
    super.initState();
    cardColor = _generateRandomColor();
  }

  Color _generateRandomColor() {
    final Random random = Random(widget.index);
    return Color.fromARGB(
      255,
      random.nextInt(156) + 100,
      random.nextInt(156) + 100,
      random.nextInt(156) + 100,
    ).withOpacity(0.6);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GetProvider.detailsNotifier.setSelectedImageUrl('');
        context.push(
            navigateTo: PokemonDetailsPage(
          pokemon: widget.pokemon,
          color: cardColor,
        ));
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.7,
                      heightFactor: 0.7,
                      child: GlobalNetworkImage(
                        imageUrl: widget.pokemon.imageUrl,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.pokemon.name.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  widget.pokemon.id.toString().padLeft(3, '0'),
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          Positioned(
            right: 0,
            child: ToggleFavButton(pokemon: widget.pokemon),
          ),
        ],
      ),
    );
  }
}
