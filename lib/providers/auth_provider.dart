import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/user_api_service.dart';
import '../services/storage_service.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  String? _token;
  bool _isLoading = false;
  String? _error;

  User? get currentUser => _currentUser;
  String? get token => _token;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _currentUser != null && _token != null;

  // Initialize auth state from storage
  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    try {
      final userData = await StorageService.getAllUserData();
      final userId = userData['userId'];
      final token = userData['token'];

      if (userId != null && token != null) {
        _token = token;
        // Fetch user details
        final user = await UserApiService.getUserById(int.parse(userId));
        _currentUser = user;
      }
    } catch (e) {
      print('Error initializing auth: $e');
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Login
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final request = LoginRequest(email: email, password: password);
      final response = await UserApiService.login(request);

      final userId = response.effectiveUserId;
      final token = response.effectiveToken;
      final userName = response.effectiveName;

      if (userId != null) {
        // Save to storage
        await StorageService.saveUserData(
          userId: userId.toString(),
          userName: userName ?? email,
          token: token,
          email: email,
        );

        _token = token;
        
        // Fetch full user details
        final user = await UserApiService.getUserById(userId);
        _currentUser = user;

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        throw Exception('No user ID in response');
      }
    } catch (e) {
      print('Login error: $e');
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Register
  Future<bool> register(String email, String password, {String? fullName}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final request = RegisterRequest(
        email: email,
        password: password,
        fullName: fullName,
      );
      
      final response = await UserApiService.register(request);

      final userId = response.effectiveUserId;
      
      if (userId != null) {
        // After successful registration, log in
        final loginSuccess = await login(email, password);
        return loginSuccess;
      } else {
        throw Exception('Registration failed');
      }
    } catch (e) {
      print('Registration error: $e');
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    await StorageService.clearUserData();
    _currentUser = null;
    _token = null;
    _error = null;
    notifyListeners();
  }

  // Update user profile
  Future<bool> updateProfile({String? fullName, String? password}) async {
    if (_currentUser == null) return false;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final request = UserUpdateRequest(
        fullName: fullName,
        password: password,
      );

      final updatedUser = await UserApiService.updateUser(_currentUser!.id, request);
      _currentUser = updatedUser;

      // Update storage
      await StorageService.saveUserData(userName: updatedUser.fullName);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print('Update profile error: $e');
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Refresh user data
  Future<void> refreshUser() async {
    if (_currentUser == null) return;

    try {
      final user = await UserApiService.getUserById(_currentUser!.id);
      _currentUser = user;
      notifyListeners();
    } catch (e) {
      print('Error refreshing user: $e');
      _error = e.toString();
      notifyListeners();
    }
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
