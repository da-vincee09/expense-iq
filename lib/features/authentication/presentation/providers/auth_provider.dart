import 'package:expense_iq/features/authentication/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier{

  final AuthRepository authRepository;

  AuthProvider({required this.authRepository});

  bool _isLoading = false;

  bool get isLoading => _isLoading;


  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  bool get isSignedIn => authRepository.isSignedIn;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {

    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await authRepository.signIn(
        email: email, 
        password: password
      );
    } catch (e) {
      _errorMessage = e.toString().replaceFirst("Exception: ", "");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await authRepository.signUp(
        name: name, 
        email: email, 
        password: password
      );

    } catch (e) {
      _errorMessage = e.toString().replaceFirst("Exception: ", "");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await authRepository.signOut();
    notifyListeners();
  }


}