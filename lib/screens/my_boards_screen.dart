import 'package:flutter/material.dart';

class MyBoardsScreen extends StatelessWidget {
  const MyBoardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Boards'),
      ),
      body: const Center(
        child: Text('My Boards Screen\n\nBoard list implementation coming soon...'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Create new board
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
