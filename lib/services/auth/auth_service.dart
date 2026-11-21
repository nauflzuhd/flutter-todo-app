import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService.internal();

  static final AuthService _instance = AuthService.internal();

  factory AuthService() {
    return _instance;
  }

  //Mengakses firebase authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Memantau perubahan fungsi login
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  //Mendaftarkan akun baru
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print("Error Sign Up : ${e.message}");
      return null;
    }
  }

  //Login dengan akun yang sudah terdaftar
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print("Error Sign In : ${e.message}");
      return null;
    }
  }

  //Logout dari akun
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
