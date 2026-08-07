/// Defines the contract for authentication operations.
///
/// Abstracts authentication logic from the data layer implementation,
/// allowing different authentication providers to be used without
/// changing the application logic.
abstract interface class AuthRepository {
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<void> signIn({
    required String email,
    required String password
  });

  Future<void> signOut();

  bool get isSignedIn;
}