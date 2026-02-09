import 'package:flutter/material.dart';

class FutoHeader extends StatelessWidget {
  const FutoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Center(
        child: Image.asset(
          'assets/futo_logo.png',
          height: 80, 
          // Use errorBuilder to show a placeholder if asset is missing during dev
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.school, // Placeholder icon
              size: 80,
              color: Color(0xFF008000),
            );
          },
        ),
      ),
    );
  }
}
