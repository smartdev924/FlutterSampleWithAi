import 'package:http/http.dart' as http;

class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException(this.statusCode, this.message);

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class ApiService {
  static const String baseUrl = 'https://api.example.com';
  final http.Client _client = http.Client();

  Map<String, String> _headers({String? token}) {
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<http.Response> get(String path, {String? token}) async {
    final uri = Uri.parse('$baseUrl$path');
    final response = await _client.get(uri, headers: _headers(token: token));
    _validateResponse(response);
    return response;
  }

  Future<http.Response> post(String path, {String? token, required String body}) async {
    final uri = Uri.parse('$baseUrl$path');
    final response = await _client.post(uri, headers: _headers(token: token), body: body);
    _validateResponse(response);
    return response;
  }

  void _validateResponse(http.Response response) {
    final statusCode = response.statusCode;
    if (statusCode >= 200 && statusCode < 300) {
      return;
    }

    final message = response.body.isNotEmpty ? response.body : response.reasonPhrase ?? 'Unknown error';
    if (statusCode == 400) {
      throw ApiException(statusCode, 'Bad request: $message');
    } else if (statusCode == 401 || statusCode == 403) {
      throw ApiException(statusCode, 'Authorization error: $message');
    } else if (statusCode == 404) {
      throw ApiException(statusCode, 'Resource not found: $message');
    } else if (statusCode >= 500 && statusCode < 600) {
      throw ApiException(statusCode, 'Server error: $message');
    }

    throw ApiException(statusCode, 'HTTP $statusCode: $message');
  }
}
