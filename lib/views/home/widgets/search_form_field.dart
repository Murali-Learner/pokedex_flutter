import 'package:flutter/material.dart';
import 'package:pokedex_app/utils/constants.dart';
import 'package:pokedex_app/utils/extensions/context_extension.dart';
import 'package:pokedex_app/utils/extensions/spacer_extension.dart';
import 'package:pokedex_app/utils/provider_list.dart';
import 'package:pokedex_app/views/favorites/favorites_page.dart';

class SearchFormField extends StatelessWidget {
  SearchFormField({
    super.key,
  });
  final FocusNode _searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final provider = GetProvider.pokemonNotifier;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextFormField(
            focusNode: _searchFocusNode,
            controller: provider.searchController,
            onChanged: (value) {
              GetProvider.pokemonNotifier.searchPokemons(
                value,
                GetProvider.favoritesNotifier.favorites.values.toList(),
              );
            },
            decoration: InputDecoration(
              suffixIcon: provider.searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        provider.searchController.clear();
                        GetProvider.pokemonNotifier.searchPokemons('', []);
                      },
                    )
                  : null,
              filled: true,
              prefixIcon: const Icon(
                Icons.search,
                size: 30,
              ),
              hintText: "Name or number",
              hintStyle: context.textTheme.bodyMedium!.copyWith(
                color: context.theme.primaryColor.withOpacity(0.6),
                fontWeight: FontWeight.w500,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
              fillColor: context.theme.secondaryHeaderColor,
            ),
          ),
        ),
        10.hSpace,
        Tooltip(
          message: "Favorites",
          child: InkWell(
            onTap: () {
              Constants.navigatorKey.currentContext!
                  .push(navigateTo: const FavoritesPage());
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xff62597e),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.favorite_border,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
