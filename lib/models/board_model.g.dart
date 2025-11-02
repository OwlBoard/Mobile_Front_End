// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Board _$BoardFromJson(Map<String, dynamic> json) => Board(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      ownerId: (json['owner_id'] as num).toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$BoardToJson(Board instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'owner_id': instance.ownerId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

Dashboard _$DashboardFromJson(Map<String, dynamic> json) => Dashboard(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      ownerId: (json['owner_id'] as num).toInt(),
    );

Map<String, dynamic> _$DashboardToJson(Dashboard instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'owner_id': instance.ownerId,
    };

Shape _$ShapeFromJson(Map<String, dynamic> json) => Shape(
      id: json['id'] as String,
      type: json['type'] as String,
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      color: json['color'] as String,
      strokeWidth: (json['stroke_width'] as num?)?.toDouble() ?? 2.0,
      filled: json['filled'] as bool? ?? false,
    );

Map<String, dynamic> _$ShapeToJson(Shape instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
      'color': instance.color,
      'stroke_width': instance.strokeWidth,
      'filled': instance.filled,
    };

DrawingPath _$DrawingPathFromJson(Map<String, dynamic> json) => DrawingPath(
      id: json['id'] as String,
      points: (json['points'] as List<dynamic>)
          .map((e) => PathPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      color: json['color'] as String,
      strokeWidth: (json['stroke_width'] as num?)?.toDouble() ?? 2.0,
    );

Map<String, dynamic> _$DrawingPathToJson(DrawingPath instance) =>
    <String, dynamic>{
      'id': instance.id,
      'points': instance.points,
      'color': instance.color,
      'stroke_width': instance.strokeWidth,
    };

PathPoint _$PathPointFromJson(Map<String, dynamic> json) => PathPoint(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
    );

Map<String, dynamic> _$PathPointToJson(PathPoint instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
    };

Layer _$LayerFromJson(Map<String, dynamic> json) => Layer(
      id: json['id'] as String,
      name: json['name'] as String,
      visible: json['visible'] as bool? ?? true,
      opacity: (json['opacity'] as num?)?.toDouble() ?? 1.0,
      shapeIds: (json['shapeIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$LayerToJson(Layer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'visible': instance.visible,
      'opacity': instance.opacity,
      'shapeIds': instance.shapeIds,
    };
