import 'dart:convert';
import '../models/user.dart';
import '../models/api_response.dart';
import './api_service.dart';

class AuthService {
  static const String signupEndpoint = '/users';
  static const String loginEndpoint = '/token';

  static Future<ApiResponse<User>> signup(UserCreate user) async {
    try {
      final response = await ApiService.post(signupEndpoint, user.toJson());
      
      if (response.statusCode == 201) {
        final userData = json.decode(response.body);
        final user = User.fromJson(userData);
        return ApiResponse(success: true, message: 'Usuario creado exitosamente', data: user);
      } else {
        final error = json.decode(response.body);
        return ApiResponse(success: false, message: error['detail'] ?? 'Error en el registro');
      }
    } catch (e) {
      return ApiResponse(success: false, message: 'Error de conexión: $e');
    }
  }

  static Future<ApiResponse<String>> login(String email, String password) async {
    try {
      // Usamos el email como device_id temporalmente hasta que implementes autenticación de usuarios
      final response = await ApiService.post(loginEndpoint, {'device_id': email});
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final token = data['access_token'];
        return ApiResponse(success: true, message: 'Login exitoso', data: token);
      } else {
        final error = json.decode(response.body);
        return ApiResponse(success: false, message: error['detail'] ?? 'Error en el login');
      }
    } catch (e) {
      return ApiResponse(success: false, message: 'Error de conexión: $e');
    }
  }

  static Future<ApiResponse<User>> getCurrentUser(String token) async {
    try {
      // Necesitarías implementar un endpoint para obtener el usuario actual
      // Por ahora, devolvemos un usuario vacío
      return ApiResponse(success: false, message: 'Endpoint no implementado');
    } catch (e) {
      return ApiResponse(success: false, message: 'Error de conexión: $e');
    }
  }
}