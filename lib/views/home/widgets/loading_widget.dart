// widgets/loading_screen.dart
import 'package:flutter/material.dart';
import 'package:pokedex_app/utils/extensions/spacer_extension.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          16.vSpace,
          Text(
            'Loading Pokémon...',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
