import 'package:flutter/material.dart';
import 'package:pokedex_app/notifiers/pokemon_notifier.dart';
import 'package:pokedex_app/utils/constants.dart';
import 'package:pokedex_app/utils/extensions/context_extension.dart';
import 'package:pokedex_app/utils/extensions/spacer_extension.dart';
import 'package:pokedex_app/utils/provider_list.dart';
import 'package:pokedex_app/views/home/widgets/header_widget.dart';
import 'package:pokedex_app/views/home/widgets/pokemon_list.dart';
import 'package:pokedex_app/views/home/widgets/search_form_field.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.hideKeyBoard();
      // GetProvider.favoritesNotifier.fetchFavorites();
      GetProvider.pokemonNotifier.fetchPokemons();
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      GetProvider.pokemonNotifier.fetchPokemons();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            GetProvider.pokemonNotifier.refresh();
          },
          child: Consumer<PokemonNotifier>(
            builder: (context, provider, _) {
              return Padding(
                padding: Constants.globalPadding,
                child: Column(
                  children: [
                    const HeaderWidget(),
                    30.vSpace,
                    SearchFormField(),
                    15.vSpace,
                    PokemonList(scrollController: _scrollController),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
