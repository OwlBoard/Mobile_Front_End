import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TopBarNoLogin extends StatelessWidget {
  const TopBarNoLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2F3B52),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SafeArea(
        child: Row(
          children: [
            // Logo
            GestureDetector(
              onTap: () => context.go('/'),
              child: const Row(
                children: [
                  Text('🦉', style: TextStyle(fontSize: 24)),
                  SizedBox(width: 8),
                  Text(
                    'Owlboard',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            
            // Navigation Links
            TextButton(
              onPressed: () => context.go('/'),
              child: const Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () => context.go('/login'),
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () => context.go('/register'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2),
                foregroundColor: Colors.white,
              ),
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
