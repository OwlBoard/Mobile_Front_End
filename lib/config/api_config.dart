class ApiConfig {
  // Base URLs for services
  static const String userServiceUrl = 
      String.fromEnvironment('USER_SERVICE_URL', defaultValue: 'http://localhost:5000');
  
  static const String commentsServiceUrl = 
      String.fromEnvironment('COMMENTS_SERVICE_URL', defaultValue: 'http://localhost:8001');
  
  // API Endpoints
  static const String usersEndpoint = '/users';
  static const String commentsEndpoint = '/comments';
  
  // Timeout durations
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);
  
  // Headers
  static Map<String, String> get defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  static Map<String, String> get formHeaders => {
    'Content-Type': 'application/x-www-form-urlencoded',
  };
}
