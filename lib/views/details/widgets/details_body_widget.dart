import 'package:flutter/material.dart';
import 'package:pokedex_app/app_theme.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/utils/constants.dart';
import 'package:pokedex_app/utils/extensions/context_extension.dart';
import 'package:pokedex_app/utils/extensions/spacer_extension.dart';
import 'package:pokedex_app/utils/screen_config.dart';
import 'package:pokedex_app/views/details/widgets/details_header_widget.dart';
import 'package:pokedex_app/views/details/widgets/details_tab.dart';
import 'package:pokedex_app/views/details/widgets/forms_tab.dart';
import 'package:pokedex_app/views/details/widgets/pokemon_image.dart';
import 'package:pokedex_app/views/details/widgets/stats_tab.dart';
import 'package:pokedex_app/views/details/widgets/types_tab.dart';

class PokemonDetailsBody extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailsBody(this.pokemon, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: Constants.globalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                25.vSpace,
                DetailsHeader(
                  pokemon: pokemon,
                ),
                25.vSpace,
                PokemonImage(
                  pokemon: pokemon,
                ),
                25.vSpace,
              ],
            ),
            DefaultTabController(
              length: 5,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: TabBar(
                      isScrollable: true,
                      unselectedLabelStyle:
                          context.textTheme.displayLarge!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: PokeTheme.primaryColor.withOpacity(0.5),
                      ),
                      indicatorColor: Colors.transparent,
                      dividerHeight: 0,
                      tabAlignment: TabAlignment.start,
                      labelColor: PokeTheme.primaryColor,
                      labelStyle: context.textTheme.displayLarge!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      labelPadding: EdgeInsets.all(12),
                      padding: EdgeInsets.zero,
                      unselectedLabelColor:
                          PokeTheme.primaryColor.withOpacity(0.5),
                      tabs: const [
                        Tab(text: 'Forms'),
                        Tab(text: 'Detail'),
                        Tab(text: 'Types'),
                        Tab(text: 'Stats'),
                        Tab(text: 'Weakness'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenConfig.height * 0.4,
                    child: TabBarView(
                      children: [
                        FormsTab(formSprites: pokemon.sprites!),
                        DetailsTab(
                          pokemon: pokemon,
                        ),
                        TypesTab(pokemonTypes: pokemon.types ?? []),
                        StatsTab(pokemonStats: pokemon.stats ?? []),
                        const Center(child: Text("Weakness Information")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
