import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  String? _token;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  String? get token => _token;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<bool> signup(String email, String username, String fullName, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final response = await AuthService.signup(
      UserCreate(
        email: email,
        username: username,
        fullName: fullName,
        password: password,
      ),
    );

    _isLoading = false;

    if (response.success) {
      _user = response.data;
      notifyListeners();
      return true;
    } else {
      _error = response.message;
      notifyListeners();
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final response = await AuthService.login(email, password);

    _isLoading = false;

    if (response.success) {
      _token = response.data;
      // Aquí deberías obtener la información del usuario
      notifyListeners();
      return true;
    } else {
      _error = response.message;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _user = null;
    _token = null;
    _error = null;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}