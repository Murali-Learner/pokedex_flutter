import 'package:flutter/material.dart';
import 'package:pokedex_app/models/poke_api_model.dart';
import 'package:pokedex_app/views/details/widgets/stats_tab.dart';

class TypesTab extends StatelessWidget {
  final List<PokemonType> pokemonTypes;

  const TypesTab({super.key, required this.pokemonTypes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // StatRow(
          //   statName: "height",
          //   statValue: "${pokemonType.type.name} meters",
          // ),
          // StatRow(
          //   statName: "weight",
          //   statValue: "${pokemonType.weight} KGs",
          // ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: pokemonTypes.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return StatRow(
                statName: pokemonTypes[index].type.name.toUpperCase(),
                statValue: "SLOT: ${pokemonTypes[index].slot}",
              );
            },
          ),
        ],
      ),
    );
  }
}
