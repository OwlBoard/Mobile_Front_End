import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/board_screen.dart';
import '../screens/my_boards_screen.dart';
import '../screens/user_profile_screen.dart';
import '../screens/paint_screen.dart';
import '../screens/user_dashboards_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/boards',
        name: 'my-boards',
        builder: (context, state) => const MyBoardsScreen(),
      ),
      GoRoute(
        path: '/board/:id',
        name: 'board',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return BoardScreen(boardId: id);
        },
      ),
      GoRoute(
        path: '/paint/:boardId/:dashboardId',
        name: 'paint',
        builder: (context, state) {
          final boardId = state.pathParameters['boardId']!;
          final dashboardId = state.pathParameters['dashboardId']!;
          return PaintScreen(boardId: boardId, dashboardId: dashboardId);
        },
      ),
      GoRoute(
        path: '/profile/:id',
        name: 'profile',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return UserProfileScreen(userId: id);
        },
      ),
      GoRoute(
        path: '/dashboards',
        name: 'dashboards',
        builder: (context, state) => const UserDashboardsScreen(),
      ),
      GoRoute(
        path: '/dashboards/:id',
        name: 'dashboard-detail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return BoardScreen(boardId: id);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('404 - Page Not Found', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(state.uri.toString()),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}
