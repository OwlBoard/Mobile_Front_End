import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/user_model.dart';
import '../models/board_model.dart';

class UserApiService {
  static final String _baseUrl = '${ApiConfig.baseUrl}${ApiConfig.usersEndpoint}';

  // User Registration
  static Future<AuthResponse> register(RegisterRequest request) async {
    try {
      final body = {
        'email': request.email,
        'password': request.password,
        if (request.fullName != null) 'full_name': request.fullName,
      };

      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: ApiConfig.formHeaders,
        body: body.entries.map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}').join('&'),
      ).timeout(ApiConfig.connectTimeout);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AuthResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Registration failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error during registration: $e');
    }
  }

  // User Login
  static Future<AuthResponse> login(LoginRequest request) async {
    try {
      final body = 'email=${Uri.encodeComponent(request.email)}&password=${Uri.encodeComponent(request.password)}';

      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: ApiConfig.formHeaders,
        body: body,
      ).timeout(ApiConfig.connectTimeout);

      if (response.statusCode == 200) {
        return AuthResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Login failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }

  // Get all users
  static Future<List<User>> getAllUsers() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: ApiConfig.defaultHeaders,
      ).timeout(ApiConfig.connectTimeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch users: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }

  // Get user by ID
  static Future<User> getUserById(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/$userId'),
        headers: ApiConfig.defaultHeaders,
      ).timeout(ApiConfig.connectTimeout);

      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to fetch user: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching user: $e');
    }
  }

  // Update user
  static Future<User> updateUser(int userId, UserUpdateRequest request) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/$userId'),
        headers: ApiConfig.defaultHeaders,
        body: json.encode(request.toJson()),
      ).timeout(ApiConfig.connectTimeout);

      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update user: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error updating user: $e');
    }
  }

  // Delete user
  static Future<void> deleteUser(int userId, {bool hardDelete = false}) async {
    try {
      final uri = hardDelete 
          ? Uri.parse('$_baseUrl/$userId?hard_delete=true')
          : Uri.parse('$_baseUrl/$userId');

      final response = await http.delete(
        uri,
        headers: ApiConfig.defaultHeaders,
      ).timeout(ApiConfig.connectTimeout);

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to delete user: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error deleting user: $e');
    }
  }

  // Get user's dashboards
  static Future<List<Dashboard>> getUserDashboards(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/$userId/dashboards'),
        headers: ApiConfig.defaultHeaders,
      ).timeout(ApiConfig.connectTimeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Dashboard.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch dashboards: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching dashboards: $e');
    }
  }
}
