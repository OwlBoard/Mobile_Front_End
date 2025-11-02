import 'package:flutter/material.dart';
import '../models/comment_model.dart';
import '../services/comments_api_service.dart';

class CommentProvider with ChangeNotifier {
  final Map<String, List<Comment>> _commentsByDashboard = {};
  bool _isLoading = false;
  String? _error;

  List<Comment> getCommentsForDashboard(String dashboardId) {
    return _commentsByDashboard[dashboardId] ?? [];
  }

  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fetch comments for a dashboard
  Future<void> fetchComments(String dashboardId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final comments = await CommentsApiService.getCommentsByDashboard(dashboardId);
      _commentsByDashboard[dashboardId] = comments;
    } catch (e) {
      print('Error fetching comments: $e');
      _error = e.toString();
      _commentsByDashboard[dashboardId] = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Create a new comment
  Future<Comment?> createComment({
    required String dashboardId,
    required String userId,
    required String content,
    required double x,
    required double y,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final request = CreateCommentRequest(
        content: content,
        coordinates: '$x,$y',
      );

      final comment = await CommentsApiService.createComment(
        dashboardId: dashboardId,
        userId: userId,
        request: request,
      );

      // Add to local cache
      if (!_commentsByDashboard.containsKey(dashboardId)) {
        _commentsByDashboard[dashboardId] = [];
      }
      _commentsByDashboard[dashboardId]!.add(comment);

      _isLoading = false;
      notifyListeners();
      return comment;
    } catch (e) {
      print('Error creating comment: $e');
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  // Update a comment
  Future<bool> updateComment({
    required String commentId,
    required String dashboardId,
    required String content,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final request = UpdateCommentRequest(content: content);
      final updatedComment = await CommentsApiService.updateComment(
        commentId: commentId,
        request: request,
      );

      // Update in local cache
      final comments = _commentsByDashboard[dashboardId];
      if (comments != null) {
        final index = comments.indexWhere((c) => c.effectiveId == commentId);
        if (index != -1) {
          comments[index] = updatedComment;
        }
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error updating comment: $e');
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Delete a comment
  Future<bool> deleteComment({
    required String commentId,
    required String dashboardId,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await CommentsApiService.deleteComment(commentId);

      // Remove from local cache
      final comments = _commentsByDashboard[dashboardId];
      if (comments != null) {
        comments.removeWhere((c) => c.effectiveId == commentId);
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Error deleting comment: $e');
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Clear comments for a dashboard
  void clearDashboardComments(String dashboardId) {
    _commentsByDashboard.remove(dashboardId);
    notifyListeners();
  }

  // Clear all comments
  void clearAllComments() {
    _commentsByDashboard.clear();
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
