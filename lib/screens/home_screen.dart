import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../widgets/top_bar_login.dart';
import '../widgets/top_bar_no_login.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              // Top Bar
              SliverAppBar(
                pinned: true,
                elevation: 0,
                toolbarHeight: 70,
                backgroundColor: const Color(0xFF2F3B52),
                flexibleSpace: authProvider.isLoggedIn
                    ? TopBarLogin(userName: authProvider.currentUser?.fullName ?? 'User')
                    : const TopBarNoLogin(),
              ),
              
              // Hero Section
              SliverToBoxAdapter(
                child: _buildHeroSection(context),
              ),
              
              // Features Section
              SliverToBoxAdapter(
                child: _buildFeaturesSection(context),
              ),
              
              // Quote Section
              SliverToBoxAdapter(
                child: _buildQuoteSection(context),
              ),
              
              // Footer
              SliverToBoxAdapter(
                child: _buildFooter(context),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/images/whiteboard-bg.gif'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            const Color(0xFF0F172A).withOpacity(0.65),
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Owlboard',
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Dibuja, anota y comparte tus ideas en tiempo real.',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Tu pizarra colaborativa para equipos creativos y educativos.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.go('/dashboards'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Create a board'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
      color: const Color(0xFF1E293B),
      child: Column(
        children: [
          const Text(
            '¿Qué puedes hacer con Owlboard?',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 32,
            runSpacing: 32,
            alignment: WrapAlignment.center,
            children: [
              _buildFeatureCard(
                'assets/images/landscape.gif',
                'Dibuja en tiempo real',
                'Colabora con tus compañeros mientras todos editan el mismo lienzo.',
              ),
              _buildFeatureCard(
                'assets/images/horse.png',
                'Comparte fácilmente',
                'Envía enlaces o invita usuarios a tu sesión sin complicaciones.',
              ),
              _buildFeatureCard(
                'assets/images/cat.gif',
                'Expresa tus ideas',
                'Usa el botón de comentarios para expresar tu opinión.',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(String imagePath, String title, String description) {
    return SizedBox(
      width: 300,
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 200,
            height: 200,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 200,
                height: 200,
                color: Colors.grey[800],
                child: const Icon(Icons.image, size: 64, color: Colors.white54),
              );
            },
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF334155), Color(0xFF1E293B)],
        ),
      ),
      child: Column(
        children: [
          const Text(
            '"Las mejores ideas nacen cuando todos trabajan juntos."',
            style: TextStyle(
              fontSize: 24,
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            '— Equipo Owlboard',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF0F172A),
      child: Text(
        '© ${DateTime.now().year} Owlboard — Crea, Colabora y Comparte',
        style: const TextStyle(
          color: Color(0xFF94A3B8),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
