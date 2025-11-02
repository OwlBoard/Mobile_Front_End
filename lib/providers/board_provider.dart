import 'package:flutter/material.dart';
import '../models/board_model.dart';

class BoardProvider with ChangeNotifier {
  List<Board> _boards = [];
  Board? _currentBoard;
  bool _isLoading = false;
  String? _error;

  // Drawing state
  ToolOption _currentTool = ToolOption.select;
  Color _currentColor = Colors.black;
  double _strokeWidth = 2.0;
  final List<Shape> _shapes = [];
  final List<DrawingPath> _paths = [];
  final List<Layer> _layers = [
    Layer(id: '1', name: 'Layer 1', visible: true, opacity: 1.0),
  ];
  int _currentLayerIndex = 0;

  // Camera state
  Offset _cameraOffset = Offset.zero;
  double _zoom = 1.0;

  // Getters
  List<Board> get boards => _boards;
  Board? get currentBoard => _currentBoard;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  ToolOption get currentTool => _currentTool;
  Color get currentColor => _currentColor;
  double get strokeWidth => _strokeWidth;
  List<Shape> get shapes => _shapes;
  List<DrawingPath> get paths => _paths;
  List<Layer> get layers => _layers;
  Layer get currentLayer => _layers[_currentLayerIndex];
  Offset get cameraOffset => _cameraOffset;
  double get zoom => _zoom;

  // Set current tool
  void setTool(ToolOption tool) {
    _currentTool = tool;
    notifyListeners();
  }

  // Set current color
  void setColor(Color color) {
    _currentColor = color;
    notifyListeners();
  }

  // Set stroke width
  void setStrokeWidth(double width) {
    _strokeWidth = width;
    notifyListeners();
  }

  // Add shape
  void addShape(Shape shape) {
    _shapes.add(shape);
    notifyListeners();
  }

  // Remove shape
  void removeShape(String shapeId) {
    _shapes.removeWhere((s) => s.id == shapeId);
    notifyListeners();
  }

  // Add path
  void addPath(DrawingPath path) {
    _paths.add(path);
    notifyListeners();
  }

  // Remove path
  void removePath(String pathId) {
    _paths.removeWhere((p) => p.id == pathId);
    notifyListeners();
  }

  // Clear all drawings
  void clearAll() {
    _shapes.clear();
    _paths.clear();
    notifyListeners();
  }

  // Camera controls
  void setCameraOffset(Offset offset) {
    _cameraOffset = offset;
    notifyListeners();
  }

  void setZoom(double zoom) {
    _zoom = zoom.clamp(0.1, 5.0);
    notifyListeners();
  }

  void resetCamera() {
    _cameraOffset = Offset.zero;
    _zoom = 1.0;
    notifyListeners();
  }

  // Layer management
  void addLayer(String name) {
    final newLayer = Layer(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      visible: true,
      opacity: 1.0,
    );
    _layers.add(newLayer);
    _currentLayerIndex = _layers.length - 1;
    notifyListeners();
  }

  void removeLayer(int index) {
    if (_layers.length > 1 && index >= 0 && index < _layers.length) {
      _layers.removeAt(index);
      if (_currentLayerIndex >= _layers.length) {
        _currentLayerIndex = _layers.length - 1;
      }
      notifyListeners();
    }
  }

  void setCurrentLayer(int index) {
    if (index >= 0 && index < _layers.length) {
      _currentLayerIndex = index;
      notifyListeners();
    }
  }

  void toggleLayerVisibility(int index) {
    if (index >= 0 && index < _layers.length) {
      final layer = _layers[index];
      _layers[index] = Layer(
        id: layer.id,
        name: layer.name,
        visible: !layer.visible,
        opacity: layer.opacity,
        shapeIds: layer.shapeIds,
      );
      notifyListeners();
    }
  }

  // Board management
  void setBoards(List<Board> boards) {
    _boards = boards;
    notifyListeners();
  }

  void setCurrentBoard(Board? board) {
    _currentBoard = board;
    notifyListeners();
  }

  void addBoard(Board board) {
    _boards.add(board);
    notifyListeners();
  }

  void removeBoard(String boardId) {
    _boards.removeWhere((b) => b.id == boardId);
    if (_currentBoard?.id == boardId) {
      _currentBoard = null;
    }
    notifyListeners();
  }

  // Error handling
  void setError(String? error) {
    _error = error;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Loading state
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
