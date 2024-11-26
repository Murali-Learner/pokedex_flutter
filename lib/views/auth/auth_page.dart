import 'package:flutter/material.dart';
import 'package:pokedex_app/app_theme.dart';
import 'package:pokedex_app/views/auth/widgets/auth_button.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PokeTheme.backgroundWhite,
      body: Stack(
        children: [
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              height: 300,
              width: 300,
              decoration: PokeTheme.backgroundCircleDecoration(
                color: PokeTheme.secondaryColor.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              height: 200,
              width: 200,
              decoration: PokeTheme.backgroundCircleDecoration(
                color: PokeTheme.lightBlue.withOpacity(0.3),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    padding: const EdgeInsets.all(20),
                    decoration: PokeTheme.circleDecoration,
                    child: Image.asset(
                      'assets/images/pokemon.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Welcome Trainer!',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Your Pokémon journey begins here',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 60),
                  const GoogleAuthButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
