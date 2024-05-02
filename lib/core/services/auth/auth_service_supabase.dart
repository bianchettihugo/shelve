import 'package:shelve/core/services/auth/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServiceSupabase extends AuthService {
  @override
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    final supabase = Supabase.instance.client;
    final result = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    return {
      'id': result.user?.id,
      'user': result.user?.userMetadata?['username'],
      'email': email,
    };
  }

  @override
  Future<bool> signOut() async {
    final supabase = Supabase.instance.client;
    await supabase.auth.signOut();
    return true;
  }

  @override
  Future<bool> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    final supabase = Supabase.instance.client;
    await supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'username': username,
      },
    );

    return true;
  }
}
