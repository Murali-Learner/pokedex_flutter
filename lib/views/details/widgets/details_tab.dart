import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/views/details/widgets/stats_tab.dart';

class DetailsTab extends StatelessWidget {
  final Pokemon pokemon;

  const DetailsTab({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatRow(
            statName: "height",
            statValue: "${pokemon.height} meters",
          ),
          StatRow(
            statName: "weight",
            statValue: "${pokemon.weight} KGs",
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: pokemon.abilities!.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return StatRow(
                statName: pokemon.abilities![index].ability.name.toUpperCase(),
                statValue:
                    (pokemon.abilities![index].isHidden ? "HIDDEN" : "VISIBLE"),
              );
            },
          ),
        ],
      ),
    );
  }
}
