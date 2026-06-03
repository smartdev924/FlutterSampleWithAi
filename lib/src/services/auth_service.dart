import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'api_service.dart';
import '../models/user.dart';

class AuthService {
  static const _tokenKey = 'auth_token';
  static const _userKey = 'auth_user';

  final ApiService _apiService = ApiService();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  String? _token;
  User? _currentUser;

  bool get isSignedIn => _token != null;
  String? get authToken => _token;
  User? get currentUser => _currentUser;

  Future<bool> restoreSession() async {
    final storedToken = await _storage.read(key: _tokenKey);
    if (storedToken == null || storedToken.isEmpty) {
      return false;
    }

    _token = storedToken;
    final storedUser = await _storage.read(key: _userKey);
    if (storedUser != null && storedUser.isNotEmpty) {
      try {
        final userData = jsonDecode(storedUser) as Map<String, dynamic>;
        _currentUser = User.fromJson(userData);
      } catch (_) {
        _currentUser = null;
      }
    }
    return true;
  }

  Future<void> _persistSession() async {
    if (_token != null) {
      await _storage.write(key: _tokenKey, value: _token);
    }
    if (_currentUser != null) {
      await _storage.write(key: _userKey, value: jsonEncode(_currentUser!.toJson()));
    }
  }

  Future<bool> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw ApiException(400, 'Email and password are required.');
    }

    try {
      final response = await _apiService.post(
        '/auth/login',
        body: jsonEncode({'email': email, 'password': password}),
      );

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      _token = data['accessToken'] as String?;
      if (_token == null) {
        throw ApiException(response.statusCode, 'Authentication token not found in response.');
      }

      _currentUser = _parseUserFromResponse(data, email);
      await _persistSession();
      return true;
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(500, 'Unable to complete login: ${error.toString()}');
    }
  }

  Future<bool> signUp(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw ApiException(400, 'Email and password are required.');
    }

    try {
      final response = await _apiService.post(
        '/auth/signup',
        body: jsonEncode({'email': email, 'password': password}),
      );

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      _token = data['accessToken'] as String?;
      if (_token == null) {
        throw ApiException(response.statusCode, 'Authentication token not found in signup response.');
      }

      _currentUser = _parseUserFromResponse(data, email);
      await _persistSession();
      return true;
    } on ApiException {
      rethrow;
    } catch (error) {
      throw ApiException(500, 'Unable to complete signup: ${error.toString()}');
    }
  }

  User _parseUserFromResponse(Map<String, dynamic> data, String fallbackEmail) {
    if (data.containsKey('user') && data['user'] is Map<String, dynamic>) {
      return User.fromJson(data['user'] as Map<String, dynamic>);
    }

    if (data.containsKey('id') || data.containsKey('email')) {
      return User.fromJson(data);
    }

    return User(id: fallbackEmail, email: fallbackEmail, displayName: fallbackEmail);
  }

  Future<void> logout() async {
    _token = null;
    _currentUser = null;
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _userKey);
  }

  Future<http.Response> fetchProtectedResource(String path) {
    return _apiService.get(path, token: _token);
  }
}
