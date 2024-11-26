import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/utils/extensions/context_extension.dart';
import 'package:pokedex_app/views/home/widgets/toggle_fav_button.dart';

class DetailsHeader extends StatelessWidget {
  const DetailsHeader({
    super.key,
    required this.pokemon,
  });
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            context.pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Color(0xff62597e),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                pokemon.name,
                style: context.textTheme.displayLarge!.copyWith(
                  color: context.theme.primaryColor,
                  fontSize: 22,
                ),
              ),
              Text(
                pokemon.id.toString().padLeft(3, '0'),
                style: context.textTheme.labelLarge!.copyWith(
                  color: context.theme.primaryColor.withOpacity(0.5),
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        ToggleFavButton(pokemon: pokemon),
      ],
    );
  }
}
