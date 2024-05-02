abstract class AuthService {
  Future<Map<String, dynamic>> signIn(
      {required String email, required String password});

  Future<bool> signUp({
    required String username,
    required String email,
    required String password,
  });

  Future<bool> signOut();
}
