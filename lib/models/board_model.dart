import 'package:json_annotation/json_annotation.dart';

part 'board_model.g.dart';

// Tool options enum
enum ToolOption {
  select,
  pen,
  brush,
  line,
  rectangle,
  circle,
  ellipse,
  polygon,
  eraser,
  pan,
  comment,
}

@JsonSerializable()
class Board {
  final String id;
  final String title;
  final String? description;
  @JsonKey(name: 'owner_id')
  final int ownerId;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  Board({
    required this.id,
    required this.title,
    this.description,
    required this.ownerId,
    this.createdAt,
    this.updatedAt,
  });

  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);
  Map<String, dynamic> toJson() => _$BoardToJson(this);
}

@JsonSerializable()
class Dashboard {
  final int id;
  final String title;
  final String? description;
  @JsonKey(name: 'owner_id')
  final int ownerId;

  Dashboard({
    required this.id,
    required this.title,
    this.description,
    required this.ownerId,
  });

  factory Dashboard.fromJson(Map<String, dynamic> json) => 
      _$DashboardFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardToJson(this);
}

// Shape models for drawing
@JsonSerializable()
class Shape {
  final String id;
  final String type; // 'rectangle', 'circle', 'line', etc.
  final double x;
  final double y;
  final double width;
  final double height;
  final String color;
  @JsonKey(name: 'stroke_width')
  final double strokeWidth;
  final bool filled;

  Shape({
    required this.id,
    required this.type,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.color,
    this.strokeWidth = 2.0,
    this.filled = false,
  });

  factory Shape.fromJson(Map<String, dynamic> json) => _$ShapeFromJson(json);
  Map<String, dynamic> toJson() => _$ShapeToJson(this);
}

@JsonSerializable()
class DrawingPath {
  final String id;
  final List<PathPoint> points;
  final String color;
  @JsonKey(name: 'stroke_width')
  final double strokeWidth;

  DrawingPath({
    required this.id,
    required this.points,
    required this.color,
    this.strokeWidth = 2.0,
  });

  factory DrawingPath.fromJson(Map<String, dynamic> json) => 
      _$DrawingPathFromJson(json);
  Map<String, dynamic> toJson() => _$DrawingPathToJson(this);
}

@JsonSerializable()
class PathPoint {
  final double x;
  final double y;

  PathPoint({
    required this.x,
    required this.y,
  });

  factory PathPoint.fromJson(Map<String, dynamic> json) => 
      _$PathPointFromJson(json);
  Map<String, dynamic> toJson() => _$PathPointToJson(this);
}

// Layer model
@JsonSerializable()
class Layer {
  final String id;
  final String name;
  final bool visible;
  final double opacity;
  final List<String> shapeIds;

  Layer({
    required this.id,
    required this.name,
    this.visible = true,
    this.opacity = 1.0,
    this.shapeIds = const [],
  });

  factory Layer.fromJson(Map<String, dynamic> json) => _$LayerFromJson(json);
  Map<String, dynamic> toJson() => _$LayerToJson(this);
}
