import 'package:flutter/material.dart';
import 'package:pokedex_app/utils/constants.dart';
import 'package:pokedex_app/utils/extensions/context_extension.dart';
import 'package:pokedex_app/utils/extensions/spacer_extension.dart';
import 'package:pokedex_app/utils/provider_list.dart';
import 'package:pokedex_app/views/auth/auth_page.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: ScreenConfig.height * 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          15.vSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pokédex",
                style: context.textTheme.displayLarge!
                    .copyWith(color: context.theme.primaryColor),
              ),
              IconButton(
                onPressed: () {
                  GetProvider.authNotifier.signOut();
                  GetProvider.favoritesNotifier.resetValues();
                  GetProvider.pokemonNotifier.resetValues();
                  context.hideKeyBoard();
                  Constants.navigatorKey.currentState!.pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const AuthenticationPage(),
                    ),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          20.vSpace,
          Text(
            "Search by a Pokémon by name or using it's National Pokédex number",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: context.theme.primaryColor.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
