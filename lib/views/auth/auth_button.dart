import 'package:flutter/material.dart';
import 'package:pokedex_app/notifiers/auth_notifier.dart';
import 'package:provider/provider.dart';

class GoogleAuthButton extends StatelessWidget {
  const GoogleAuthButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authNotifier = context.watch<AuthNotifier>();
    return GestureDetector(
      onTap: () async {
        // Constants.navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
        //   builder: (context) => const HomePage(),
        // ));
        await authNotifier.signInWithGoogle();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: authNotifier.isLoading
            ? const EdgeInsets.all(16.0)
            : const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
        decoration: BoxDecoration(
          color: Colors.white,
          // shape: authNotifier.isLoading ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: BorderRadius.circular(authNotifier.isLoading ? 30 : 20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: authNotifier.isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/google.png',
                    height: 24,
                    width: 24,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Continue with Google',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
