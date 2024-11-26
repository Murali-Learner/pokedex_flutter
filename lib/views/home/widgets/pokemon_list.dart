import 'package:flutter/material.dart';
import 'package:pokedex_app/notifiers/pokemon_notifier.dart';
import 'package:pokedex_app/utils/shimmer_loading.dart';
import 'package:pokedex_app/views/home/widgets/empty_results_widget.dart';
import 'package:pokedex_app/views/home/widgets/pokemon_card.dart';
import 'package:pokedex_app/views/home/widgets/request_error_widget.dart';
import 'package:provider/provider.dart';

class PokemonList extends StatelessWidget {
  const PokemonList({
    super.key,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Consumer<PokemonNotifier>(builder: (context, provider, _) {
      if (provider.isInitialLoading) {
        return const ShimmerLoading();
      }

      if (provider.pokemons.isEmpty) {
        return const EmptyResultsWidget();
      }

      if (provider.hasError) {
        return RequestErrorWidget(
          message: provider.error,
          onRetry: () => provider.refresh(),
        );
      }

      return Expanded(
        child: GridView.builder(
          padding: const EdgeInsets.only(bottom: 20),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 2 / 2.7,
          ),
          controller: _scrollController,
          itemCount: provider.pokemons.length + (provider.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= provider.pokemons.length) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final pokemon = provider.pokemons.values.toList()[index];
            return PokemonCard(
              pokemon: pokemon,
              index: index,
            );
          },
        ),
      );
    });
  }
}
