import 'package:flutter/material.dart';
import 'package:pokedex_app/app_theme.dart';
import 'package:pokedex_app/models/poke_api_model.dart';
import 'package:pokedex_app/utils/extensions/context_extension.dart';

class StatsTab extends StatelessWidget {
  final List<PokemonStat> pokemonStats;

  const StatsTab({super.key, required this.pokemonStats});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            itemCount: pokemonStats.length,
            itemBuilder: (context, index) {
              return StatRow(
                statName: pokemonStats[index].stat.name,
                statValue: pokemonStats[index].baseStat.toString(),
              );
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ],
      ),
    );
  }
}

class StatRow extends StatelessWidget {
  const StatRow({
    super.key,
    required this.statName,
    required this.statValue,
  });
  final String statName;
  final String statValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            statName.toUpperCase(),
            style: context.textTheme.bodyLarge!.copyWith(
              color: PokeTheme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            statValue.toString(),
            style: context.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
