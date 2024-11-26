import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/notifiers/pokemon_details_notifier.dart';
import 'package:pokedex_app/utils/provider_list.dart';
import 'package:pokedex_app/views/details/widgets/details_body_widget.dart';
import 'package:pokedex_app/views/home/widgets/loading_widget.dart';
import 'package:pokedex_app/views/home/widgets/request_error_widget.dart';
import 'package:provider/provider.dart';

class PokemonDetailsPage extends StatefulWidget {
  const PokemonDetailsPage(
      {super.key, required this.pokemon, required this.color});
  final Pokemon pokemon;
  final Color color;

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GetProvider.detailsNotifier.fetchPokemon(widget.pokemon.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("pokemon ${widget.pokemon.isFav}");

    return Scaffold(
      body: SafeArea(
        child: Consumer<PokemonDetailsNotifier>(
          builder: (context, provider, _) {
            if (provider.hasError) {
              return RequestErrorWidget(
                  message: provider.errorMessage,
                  onRetry: () {
                    GetProvider.detailsNotifier
                        .fetchPokemon(widget.pokemon.name);
                  });
            }
            if (provider.detailsLoading || provider.pokemon == null) {
              return const LoadingWidget();
            } else {
              final pokemonModel =
                  provider.pokemon!.copyWith(isFav: widget.pokemon.isFav);
              return PokemonDetailsBody(pokemonModel);
            }
          },
        ),
      ),
    );
  }
}
