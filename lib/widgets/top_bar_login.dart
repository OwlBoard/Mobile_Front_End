import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';

class TopBarLogin extends StatelessWidget {
  final String userName;

  const TopBarLogin({super.key, required this.userName});

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
            
            // Menu Button
            PopupMenuButton<String>(
              icon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.account_circle, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    userName,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              color: const Color(0xFF2F3B52),
              onSelected: (value) {
                switch (value) {
                  case 'home':
                    context.go('/');
                    break;
                  case 'dashboards':
                    context.go('/dashboards');
                    break;
                  case 'boards':
                    context.go('/boards');
                    break;
                  case 'profile':
                    final authProvider = Provider.of<AuthProvider>(context, listen: false);
                    if (authProvider.currentUser != null) {
                      context.go('/profile/${authProvider.currentUser!.id}');
                    }
                    break;
                  case 'logout':
                    _handleLogout(context);
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'home',
                  child: ListTile(
                    leading: Icon(Icons.home, color: Colors.white),
                    title: Text('Home', style: TextStyle(color: Colors.white)),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                const PopupMenuItem(
                  value: 'dashboards',
                  child: ListTile(
                    leading: Icon(Icons.dashboard, color: Colors.white),
                    title: Text('Dashboards', style: TextStyle(color: Colors.white)),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                const PopupMenuItem(
                  value: 'boards',
                  child: ListTile(
                    leading: Icon(Icons.view_list, color: Colors.white),
                    title: Text('My Boards', style: TextStyle(color: Colors.white)),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: 'profile',
                  child: ListTile(
                    leading: Icon(Icons.person, color: Colors.white),
                    title: Text('View Profile', style: TextStyle(color: Colors.white)),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: 'logout',
                  child: ListTile(
                    leading: Icon(Icons.logout, color: Colors.white),
                    title: Text('Logout', style: TextStyle(color: Colors.white)),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleLogout(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.logout();
    if (context.mounted) {
      context.go('/');
    }
  }
}
