import 'package:flutter/material.dart';
import 'package:pokedex_app/utils/extensions/context_extension.dart';

class EmptyResultsWidget extends StatelessWidget {
  const EmptyResultsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64.0,
            color: context.theme.primaryColor.withOpacity(0.5),
          ),
          const SizedBox(height: 16.0),
          Text(
            'No pokémon\'s found',
            style: context.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
