import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/board_provider.dart';
import '../providers/comment_provider.dart';
import '../providers/auth_provider.dart';
import '../models/board_model.dart';

class PaintScreen extends StatefulWidget {
  final String boardId;
  final String dashboardId;

  const PaintScreen({
    super.key,
    required this.boardId,
    required this.dashboardId,
  });

  @override
  State<PaintScreen> createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {
  bool _showToolbar = true;
  bool _commentMode = false;
  List<PathPoint> _currentPoints = [];
  late String _currentDashboardId;

  @override
  void initState() {
    super.initState();
    _currentDashboardId = widget.dashboardId;
    // Lock to landscape orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // Reset to all orientations when leaving
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  Color _parseColor(String hexColor) {
    final hex = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
    final boardProvider = Provider.of<BoardProvider>(context);
    final commentProvider = Provider.of<CommentProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paint Board'),
        backgroundColor: const Color(0xFF2F3B52),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Board saved!')),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Canvas Area
          Positioned.fill(
            child: Container(
              color: Colors.white,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapUp: (details) => _onTapUp(details, boardProvider, commentProvider, authProvider),
                onPanStart: (details) => _onPanStart(details, boardProvider, commentProvider, authProvider),
                onPanUpdate: (details) => _onPanUpdate(details, boardProvider),
                onPanEnd: (details) => _onPanEnd(details, boardProvider),
                child: CustomPaint(
                  size: Size.infinite,
                  painter: CanvasPainter(
                    paths: boardProvider.paths,
                    shapes: boardProvider.shapes,
                    cameraOffset: boardProvider.cameraOffset,
                    zoom: boardProvider.zoom,
                    parseColor: _parseColor,
                    currentPoints: _currentPoints,
                    currentColor: boardProvider.currentColor,
                    currentStrokeWidth: boardProvider.strokeWidth,
                  ),
                ),
              ),
            ),
          ),

          // Top Toolbar (now horizontal)
          if (_showToolbar)
            Positioned(
              left: 16,
              top: 16,
              child: _buildToolbar(boardProvider, commentProvider, authProvider),
            ),

          // Right Properties Panel
          if (_showToolbar)
            Positioned(
              right: 16,
              top: 16,
              child: _buildPropertiesPanel(boardProvider),
            ),

          // Toggle Toolbar Button
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              mini: true,
              onPressed: () => setState(() => _showToolbar = !_showToolbar),
              child: Icon(_showToolbar ? Icons.visibility_off : Icons.visibility),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolbar(BoardProvider provider, CommentProvider commentProvider, AuthProvider authProvider) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildToolButton(Icons.pan_tool, ToolOption.select, provider),
            const SizedBox(width: 4),
            _buildToolButton(Icons.edit, ToolOption.pen, provider),
            const SizedBox(width: 4),
            _buildToolButton(Icons.brush, ToolOption.brush, provider),
            const SizedBox(width: 4),
            _buildToolButton(Icons.show_chart, ToolOption.line, provider),
            const SizedBox(width: 4),
            _buildToolButton(Icons.rectangle_outlined, ToolOption.rectangle, provider),
            const SizedBox(width: 4),
            _buildToolButton(Icons.circle_outlined, ToolOption.circle, provider),
            const SizedBox(width: 4),
            _buildToolButton(Icons.delete_outline, ToolOption.eraser, provider),
            const SizedBox(width: 8),
            Container(width: 1, height: 30, color: Colors.grey[300]),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(
                _commentMode ? Icons.comment : Icons.comment_outlined,
                size: 18,
                color: _commentMode ? Theme.of(context).primaryColor : null,
              ),
              onPressed: () {
                setState(() {
                  _commentMode = !_commentMode;
                  print('Comment mode toggled: $_commentMode'); // Debug
                  if (_commentMode) {
                    provider.setTool(ToolOption.select);
                  }
                });
              },
              tooltip: 'Add Comment',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              style: IconButton.styleFrom(
                backgroundColor: _commentMode ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
              ),
            ),
            const SizedBox(width: 4),
            IconButton(
              icon: const Icon(Icons.clear_all, size: 18),
              onPressed: () => _showClearDialog(provider),
              tooltip: 'Clear All',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolButton(IconData icon, ToolOption tool, BoardProvider provider) {
    final isSelected = provider.currentTool == tool;
    return IconButton(
      icon: Icon(icon, size: 18),
      color: isSelected ? Theme.of(context).primaryColor : null,
      style: IconButton.styleFrom(
        backgroundColor: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
        padding: EdgeInsets.zero,
      ),
      onPressed: () => provider.setTool(tool),
      tooltip: tool.name,
      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
    );
  }

  Widget _buildPropertiesPanel(BoardProvider provider) {
    return Card(
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Properties',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text('Color', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                Colors.black,
                Colors.red,
                Colors.blue,
                Colors.green,
                Colors.yellow,
                Colors.orange,
                Colors.purple,
                Colors.pink,
              ].map((color) => _buildColorButton(color, provider)).toList(),
            ),
            const SizedBox(height: 12),
            Text('Width: ${provider.strokeWidth.toStringAsFixed(1)}', 
                 style: const TextStyle(fontSize: 12)),
            Slider(
              value: provider.strokeWidth,
              min: 1,
              max: 20,
              divisions: 19,
              onChanged: (value) => provider.setStrokeWidth(value),
            ),
            const Divider(),
            const Text('Zoom', style: TextStyle(fontSize: 12)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, size: 16),
                  onPressed: () => provider.setZoom((provider.zoom - 0.1).clamp(0.5, 3.0)),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                ),
                Text('${(provider.zoom * 100).toInt()}%', style: const TextStyle(fontSize: 12)),
                IconButton(
                  icon: const Icon(Icons.add, size: 16),
                  onPressed: () => provider.setZoom((provider.zoom + 0.1).clamp(0.5, 3.0)),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorButton(Color color, BoardProvider provider) {
    final isSelected = provider.currentColor == color;
    return GestureDetector(
      onTap: () => provider.setColor(color),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey,
            width: isSelected ? 3 : 1,
          ),
        ),
      ),
    );
  }

  void _onTapUp(TapUpDetails details, BoardProvider provider, 
                CommentProvider commentProvider, AuthProvider authProvider) {
    if (_commentMode && authProvider.currentUser != null) {
      final x = details.localPosition.dx;
      final y = details.localPosition.dy;
      
      print('Comment mode active - Adding comment at x: $x, y: $y'); // Debug
      _showAddCommentDialog(commentProvider, authProvider, x, y);
      setState(() => _commentMode = false);
    }
  }

  void _onPanStart(DragStartDetails details, BoardProvider provider,
                   CommentProvider commentProvider, AuthProvider authProvider) {
    // If in comment mode, treat this as a tap for comment placement
    if (_commentMode && authProvider.currentUser != null) {
      final x = details.localPosition.dx;
      final y = details.localPosition.dy;
      
      print('Comment mode active (pan) - Adding comment at x: $x, y: $y'); // Debug
      _showAddCommentDialog(commentProvider, authProvider, x, y);
      setState(() => _commentMode = false);
      return;
    }
    
    // Otherwise, start drawing
    if (!_commentMode && 
        (provider.currentTool == ToolOption.pen || 
         provider.currentTool == ToolOption.brush ||
         provider.currentTool == ToolOption.eraser)) {
      setState(() {
        _currentPoints = [
          PathPoint(
            x: details.localPosition.dx,
            y: details.localPosition.dy,
          ),
        ];
      });
    }
  }

  void _onPanUpdate(DragUpdateDetails details, BoardProvider provider) {
    if (!_commentMode && 
        _currentPoints.isNotEmpty && 
        (provider.currentTool == ToolOption.pen || 
         provider.currentTool == ToolOption.brush ||
         provider.currentTool == ToolOption.eraser)) {
      setState(() {
        _currentPoints.add(
          PathPoint(
            x: details.localPosition.dx,
            y: details.localPosition.dy,
          ),
        );
      });
    }
  }

  void _onPanEnd(DragEndDetails details, BoardProvider provider) {
    if (!_commentMode && _currentPoints.isNotEmpty) {
      final path = DrawingPath(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        points: _currentPoints,
        color: provider.currentTool == ToolOption.eraser 
            ? '#FFFFFF' 
            : _colorToHex(provider.currentColor),
        strokeWidth: provider.strokeWidth,
      );
      provider.addPath(path);
      setState(() => _currentPoints = []);
    }
  }

  void _showClearDialog(BoardProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Canvas'),
        content: const Text('Are you sure you want to clear all drawings?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              provider.clearAll();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showAddCommentDialog(CommentProvider commentProvider, AuthProvider authProvider, 
                             double x, double y) {
    print('Opening comment dialog at x: $x, y: $y'); // Debug
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Add Comment'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter your comment...',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.trim().isNotEmpty && authProvider.currentUser != null) {
                print('Creating comment: ${controller.text.trim()} at ($x, $y) for dashboard $_currentDashboardId'); // Debug
                await commentProvider.createComment(
                  dashboardId: _currentDashboardId,
                  userId: authProvider.currentUser!.id.toString(),
                  content: controller.text.trim(),
                  x: x,
                  y: y,
                );
                if (dialogContext.mounted) {
                  Navigator.pop(dialogContext);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Comment added!')),
                  );
                }
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

// Custom Painter for Canvas
class CanvasPainter extends CustomPainter {
  final List<DrawingPath> paths;
  final List<Shape> shapes;
  final Offset cameraOffset;
  final double zoom;
  final Color Function(String) parseColor;
  final List<PathPoint> currentPoints;
  final Color currentColor;
  final double currentStrokeWidth;

  CanvasPainter({
    required this.paths,
    required this.shapes,
    required this.cameraOffset,
    required this.zoom,
    required this.parseColor,
    required this.currentPoints,
    required this.currentColor,
    required this.currentStrokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(cameraOffset.dx, cameraOffset.dy);
    canvas.scale(zoom);

    // Draw paths (pen/brush strokes)
    for (final path in paths) {
      final paint = Paint()
        ..color = parseColor(path.color)
        ..strokeWidth = path.strokeWidth
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      final pathToDraw = Path();
      for (int i = 0; i < path.points.length; i++) {
        final point = path.points[i];
        if (i == 0) {
          pathToDraw.moveTo(point.x, point.y);
        } else {
          pathToDraw.lineTo(point.x, point.y);
        }
      }
      canvas.drawPath(pathToDraw, paint);
    }

    // Draw current drawing in progress (real-time preview)
    if (currentPoints.isNotEmpty) {
      final paint = Paint()
        ..color = currentColor
        ..strokeWidth = currentStrokeWidth
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      final pathToDraw = Path();
      for (int i = 0; i < currentPoints.length; i++) {
        final point = currentPoints[i];
        if (i == 0) {
          pathToDraw.moveTo(point.x, point.y);
        } else {
          pathToDraw.lineTo(point.x, point.y);
        }
      }
      canvas.drawPath(pathToDraw, paint);
    }

    // Draw shapes
    for (final shape in shapes) {
      final paint = Paint()
        ..color = parseColor(shape.color)
        ..strokeWidth = shape.strokeWidth
        ..style = shape.filled ? PaintingStyle.fill : PaintingStyle.stroke;

      switch (shape.type) {
        case 'rectangle':
          canvas.drawRect(
            Rect.fromLTWH(shape.x, shape.y, shape.width, shape.height),
            paint,
          );
          break;
        case 'circle':
          final radius = shape.width / 2;
          canvas.drawCircle(
            Offset(shape.x + radius, shape.y + radius),
            radius,
            paint,
          );
          break;
        case 'line':
          canvas.drawLine(
            Offset(shape.x, shape.y),
            Offset(shape.x + shape.width, shape.y + shape.height),
            paint,
          );
          break;
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CanvasPainter oldDelegate) {
    return paths != oldDelegate.paths ||
        shapes != oldDelegate.shapes ||
        cameraOffset != oldDelegate.cameraOffset ||
        zoom != oldDelegate.zoom ||
        currentPoints != oldDelegate.currentPoints ||
        currentColor != oldDelegate.currentColor ||
        currentStrokeWidth != oldDelegate.currentStrokeWidth;
  }
}
