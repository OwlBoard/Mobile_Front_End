import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/comment_model.dart';

class CommentsApiService {
  static final String _baseUrl = '${ApiConfig.commentsServiceUrl}${ApiConfig.commentsEndpoint}';

  // Create a new comment
  static Future<Comment> createComment({
    required String dashboardId,
    required String userId,
    required CreateCommentRequest request,
  }) async {
    try {
      final url = '$_baseUrl/dashboards/$dashboardId/users/$userId/comments';
      
      print('Creating comment: dashboardId=$dashboardId, userId=$userId');
      print('Request data: ${request.toJson()}');

      final response = await http.post(
        Uri.parse(url),
        headers: ApiConfig.defaultHeaders,
        body: json.encode(request.toJson()),
      ).timeout(ApiConfig.connectTimeout);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Comment.fromJson(json.decode(response.body));
      } else if (response.statusCode == 422) {
        final error = json.decode(response.body);
        throw Exception('Validation error: ${error['detail']}');
      } else {
        throw Exception('Failed to create comment: ${response.body}');
      }
    } catch (e) {
      print('Error creating comment: $e');
      throw Exception('Error creating comment: $e');
    }
  }

  // Get all comments for a dashboard
  static Future<List<Comment>> getCommentsByDashboard(String dashboardId) async {
    try {
      final url = '$_baseUrl/dashboards/$dashboardId';
      
      print('Fetching comments for dashboard: $dashboardId');

      final response = await http.get(
        Uri.parse(url),
        headers: ApiConfig.defaultHeaders,
      ).timeout(ApiConfig.connectTimeout);

      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print('Comments fetched: ${data.length}');
        return data.map((json) => Comment.fromJson(json)).toList();
      } else if (response.statusCode == 404) {
        // No comments found for dashboard
        print('No comments found for dashboard (404)');
        return [];
      } else {
        throw Exception('Failed to fetch comments: ${response.body}');
      }
    } catch (e) {
      print('Error fetching comments: $e');
      if (e.toString().contains('404')) {
        return [];
      }
      throw Exception('Error fetching comments: $e');
    }
  }

  // Update a comment
  static Future<Comment> updateComment({
    required String commentId,
    required UpdateCommentRequest request,
  }) async {
    try {
      final url = '$_baseUrl/$commentId';
      
      print('Updating comment: $commentId');
      print('Update data: ${request.toJson()}');

      final response = await http.put(
        Uri.parse(url),
        headers: ApiConfig.defaultHeaders,
        body: json.encode(request.toJson()),
      ).timeout(ApiConfig.connectTimeout);

      if (response.statusCode == 200) {
        return Comment.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update comment: ${response.body}');
      }
    } catch (e) {
      print('Error updating comment: $e');
      throw Exception('Error updating comment: $e');
    }
  }

  // Delete a comment
  static Future<void> deleteComment(String commentId) async {
    try {
      final url = '$_baseUrl/$commentId';
      
      print('Deleting comment: $commentId');

      final response = await http.delete(
        Uri.parse(url),
        headers: ApiConfig.defaultHeaders,
      ).timeout(ApiConfig.connectTimeout);

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to delete comment: ${response.body}');
      }
      
      print('Comment deleted successfully');
    } catch (e) {
      print('Error deleting comment: $e');
      throw Exception('Error deleting comment: $e');
    }
  }

  // Get a specific comment by ID
  static Future<Comment> getCommentById(String commentId) async {
    try {
      final url = '$_baseUrl/$commentId';

      final response = await http.get(
        Uri.parse(url),
        headers: ApiConfig.defaultHeaders,
      ).timeout(ApiConfig.connectTimeout);

      if (response.statusCode == 200) {
        return Comment.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to fetch comment: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching comment: $e');
    }
  }
}
