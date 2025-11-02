import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserDashboardsScreen extends StatelessWidget {
  const UserDashboardsScreen({super.key});

  void _showCreateBoardDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Create New Board'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Board Name',
                  hintText: 'Enter board name',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final boardName = nameController.text.trim();
                if (boardName.isNotEmpty) {
                  Navigator.of(dialogContext).pop();
                  // Generate temporary IDs (in real app, these would come from API)
                  final tempBoardId = DateTime.now().millisecondsSinceEpoch.toString();
                  final tempDashboardId = '${tempBoardId}_dashboard';
                  // Navigate to paint screen
                  context.go('/paint/$tempBoardId/$tempDashboardId');
                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Creating board: $boardName'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Dashboards'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateBoardDialog(context),
            tooltip: 'Create New Board',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.dashboard,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            const Text(
              'No Dashboards Yet',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Create your first board to get started',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => _showCreateBoardDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Create Board'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
