import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class Comment {
  @JsonKey(name: '_id')
  final String? mongoId;
  final String? id;
  @JsonKey(name: 'dashboard_id')
  final String dashboardId;
  @JsonKey(name: 'user_id')
  final String userId;
  final String content;
  final List<double> coordinates;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  Comment({
    this.mongoId,
    this.id,
    required this.dashboardId,
    required this.userId,
    required this.content,
    required this.coordinates,
    required this.createdAt,
    required this.updatedAt,
  });

  String get effectiveId => id ?? mongoId ?? '';
  double get x => coordinates.isNotEmpty ? coordinates[0] : 0.0;
  double get y => coordinates.length > 1 ? coordinates[1] : 0.0;

  factory Comment.fromJson(Map<String, dynamic> json) => 
      _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

@JsonSerializable()
class CreateCommentRequest {
  final String content;
  final String coordinates; // formato "x,y"

  CreateCommentRequest({
    required this.content,
    required this.coordinates,
  });

  factory CreateCommentRequest.fromJson(Map<String, dynamic> json) => 
      _$CreateCommentRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateCommentRequestToJson(this);
}

@JsonSerializable()
class UpdateCommentRequest {
  final String content;

  UpdateCommentRequest({
    required this.content,
  });

  factory UpdateCommentRequest.fromJson(Map<String, dynamic> json) => 
      _$UpdateCommentRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateCommentRequestToJson(this);
}
