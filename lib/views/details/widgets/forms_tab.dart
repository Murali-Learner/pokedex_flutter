import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon_model.dart';
import 'package:pokedex_app/notifiers/pokemon_details_notifier.dart';
import 'package:pokedex_app/utils/extensions/spacer_extension.dart';
import 'package:pokedex_app/utils/global_network_image.dart';
import 'package:pokedex_app/utils/provider_list.dart';
import 'package:provider/provider.dart';

class FormsTab extends StatelessWidget {
  // const FormsTab({super.key});

  const FormsTab({super.key, required this.formSprites});
  final PokemonSprites formSprites;

  @override
  Widget build(BuildContext context) {
    return Consumer<PokemonDetailsNotifier>(builder: (context, provider, _) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
              child: ListView.separated(
                itemCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (BuildContext context, int index) {
                  return 5.hSpace;
                },
                itemBuilder: (BuildContext context, int index) {
                  return FormSpriteWidget(
                    index: index,
                    imageUrl: provider.getSpriteByIndex(formSprites, index),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}

class FormSpriteWidget extends StatelessWidget {
  const FormSpriteWidget({
    super.key,
    required this.imageUrl,
    required this.index,
  });

  final String imageUrl;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<PokemonDetailsNotifier>(
      builder: (context, provider, _) {
        return GestureDetector(
          onTap: () {
            GetProvider.detailsNotifier.setSelectedImageUrl(imageUrl);
          },
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Transform.scale(
                  scale: 1.0,
                  child: GlobalNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.contain,
                    // height: 100,
                    // width: 80,
                  ),
                ),
              ),
              if (provider.selectedImageUrl != imageUrl)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
