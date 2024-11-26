import 'package:flutter/material.dart';
import 'package:pokedex_app/app_theme.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/notifiers/favorites_notifier.dart';
import 'package:pokedex_app/utils/extensions/context_extension.dart';
import 'package:pokedex_app/utils/extensions/spacer_extension.dart';
import 'package:pokedex_app/utils/provider_list.dart';
import 'package:pokedex_app/views/home/widgets/pokemon_card.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  FavoritesPageState createState() => FavoritesPageState();
}

class FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GetProvider.favoritesNotifier.fetchFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<FavoritesNotifier>(
          builder: (context, provider, child) {
            final isLoading = provider.isPageLoading;
            final favoritePokemon = provider.favorites;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                15.vSpace,
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xff62597e),
                      ),
                    ),
                    Text(
                      "Favorites",
                      style: context.textTheme.displayLarge!
                          .copyWith(color: context.theme.primaryColor),
                    ),
                  ],
                ),
                20.vSpace,
                Expanded(
                  child: isLoading
                      ? _buildLoadingIndicator()
                      : favoritePokemon.isEmpty
                          ? _buildEmptyState(context)
                          : _buildFavoritesList(
                              context, favoritePokemon.values.toList()),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: PokeTheme.accentBlue,
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.favorite_border,
            color: PokeTheme.secondaryColor,
            size: 80,
          ),
          20.vSpace,
          Text(
            "No Favorites Yet!",
            style: context.textTheme.displayLarge!
                .copyWith(color: PokeTheme.textGrey),
          ),
          10.vSpace,
          Text(
            "Add some Pokémon to your favorites to see them here.",
            style: context.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList(
      BuildContext context, List<Pokemon> favoritePokemon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: favoritePokemon.length,
        itemBuilder: (context, index) {
          final pokemon = favoritePokemon[index];
          return PokemonCard(pokemon: pokemon, index: index);
        },
      ),
    );
  }
}
