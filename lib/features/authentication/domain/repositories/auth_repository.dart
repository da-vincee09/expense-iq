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