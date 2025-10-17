// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
  mongoId: json['_id'] as String?,
  id: json['id'] as String?,
  dashboardId: json['dashboard_id'] as String,
  userId: json['user_id'] as String,
  content: json['content'] as String,
  coordinates: (json['coordinates'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
  '_id': instance.mongoId,
  'id': instance.id,
  'dashboard_id': instance.dashboardId,
  'user_id': instance.userId,
  'content': instance.content,
  'coordinates': instance.coordinates,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};

CreateCommentRequest _$CreateCommentRequestFromJson(
  Map<String, dynamic> json,
) => CreateCommentRequest(
  content: json['content'] as String,
  coordinates: json['coordinates'] as String,
);

Map<String, dynamic> _$CreateCommentRequestToJson(
  CreateCommentRequest instance,
) => <String, dynamic>{
  'content': instance.content,
  'coordinates': instance.coordinates,
};

UpdateCommentRequest _$UpdateCommentRequestFromJson(
  Map<String, dynamic> json,
) => UpdateCommentRequest(content: json['content'] as String);

Map<String, dynamic> _$UpdateCommentRequestToJson(
  UpdateCommentRequest instance,
) => <String, dynamic>{'content': instance.content};
