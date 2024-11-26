import 'dart:math';

import 'package:flutter/material.dart';

Color generateRandomLightColor() {
  final Random random = Random();

  // Generate RGB values in a range that ensures the color is light.
  int red = random.nextInt(156) + 100; // Range: 100–255
  int green = random.nextInt(156) + 100; // Range: 100–255
  int blue = random.nextInt(156) + 100; // Range: 100–255

  return Color.fromARGB(255, red, green, blue)
      .withOpacity(0.2); // Opaque color.
}
