import 'package:expense_iq/features/authentication/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository{

  final SupabaseClient supabase;

  AuthRepositoryImpl({required this.supabase});

  @override
  Future<void> signUp({
    required String name, 
    required String email, 
    required String password
  }) async {
    try{
      await supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          "name": name,
        }
      );
    } catch (e) {
      if (e is AuthException) {
        throw Exception(e.message);
      }

      throw Exception("Something went wrong");
    }
  }

  @override
  Future<void> signIn({
    required String email, 
    required String password
  }) async {
    try {
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      if (e is AuthException) {
        throw Exception(e.message);
      }

      throw Exception("Something went wrong");
    }
  }

  @override
  Future<void> signOut() async{
    await supabase.auth.signOut();
  }

  @override
  bool get isSignedIn {
    return supabase.auth.currentSession != null;
  }
}