import 'package:pokedex_app/notifiers/auth_notifier.dart';
import 'package:pokedex_app/notifiers/favorites_notifier.dart';
import 'package:pokedex_app/notifiers/pokemon_details_notifier.dart';
import 'package:pokedex_app/notifiers/pokemon_notifier.dart';
import 'package:pokedex_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> getProviders() {
  return [
    ChangeNotifierProvider(
      create: (_) => AuthNotifier(),
    ),
    ChangeNotifierProvider(
      create: (context) {
        final authNotifier = context.read<AuthNotifier>();
        return PokemonNotifier(
          authNotifier: authNotifier,
        );
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        final authNotifier = context.read<AuthNotifier>();
        return FavoritesNotifier(
          authNotifier: authNotifier,
        );
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return PokemonDetailsNotifier();
      },
    ),
  ];
}

class GetProvider {
  static AuthNotifier get authNotifier {
    return Provider.of<AuthNotifier>(
      Constants.navigatorKey.currentContext!,
      listen: false,
    );
  }

  static PokemonNotifier get pokemonNotifier {
    return Provider.of<PokemonNotifier>(
      Constants.navigatorKey.currentContext!,
      listen: false,
    );
  }

  static FavoritesNotifier get favoritesNotifier {
    return Provider.of<FavoritesNotifier>(
      Constants.navigatorKey.currentContext!,
      listen: false,
    );
  }

  static PokemonDetailsNotifier get detailsNotifier {
    return Provider.of<PokemonDetailsNotifier>(
      Constants.navigatorKey.currentContext!,
      listen: false,
    );
  }
}
