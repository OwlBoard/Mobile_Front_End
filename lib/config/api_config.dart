class ApiConfig {
  // Base URLs for services
  static const String baseUrl = 
      String.fromEnvironment('API_GATEWAY_URL', defaultValue: 'http://localhost:8080');
  
  // Endpoints completos (incluyendo el prefijo de la API)
  static const String usersEndpoint = '/api/users';
  static const String commentsEndpoint = '/api/comments';
  static const String canvasEndpoint = '/api/canvas';
  static const String chatEndpoint = '/api/chat';
  
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
