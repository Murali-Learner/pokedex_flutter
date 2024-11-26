import 'package:flutter/material.dart';
import 'package:pokedex_app/utils/constants.dart';
import 'package:pokedex_app/utils/extensions/context_extension.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  final int shimmerLength;
  const ShimmerLoading({super.key, this.shimmerLength = 8});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 2 / 2.7,
        ),
        itemCount: shimmerLength,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: context.theme.primaryColor.withOpacity(0.8),
            highlightColor: ColorConstants.highlight,
            child: Container(
              decoration: BoxDecoration(
                color: ColorConstants.darkGrey,
                borderRadius: BorderRadius.circular(16),
              ),
            ),

            // ListTile(
            //   leading: CircleAvatar(
            //     backgroundColor: ColorConstants.darkGrey,
            //     radius: 30,
            //   ),
            //   title: Container(
            //     color: ColorConstants.darkGrey,
            //     height: 20,
            //     width: double.infinity,
            //   ),
            //   subtitle: Container(
            //     color: ColorConstants.darkGrey,
            //     height: 14,
            //     width: double.infinity,
            //     margin: EdgeInsets.only(top: 8),
            //   ),
            // ),
          );
        },
      ),
    );
  }
}
