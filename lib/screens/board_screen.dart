import 'package:flutter/material.dart';

class BoardScreen extends StatelessWidget {
  final String boardId;

  const BoardScreen({super.key, required this.boardId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Board $boardId'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // TODO: Implement save
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement share
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Board Screen - ID: $boardId\n\nCanvas implementation coming soon...'),
      ),
    );
  }
}
