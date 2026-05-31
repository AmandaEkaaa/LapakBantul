import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Fungsi untuk Login dengan Google
  Future<User?> signInWithGoogle() async {
    try {
      // 1. Memicu jendela pop-up pilihan akun Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // Jika user membatalkan pilihan

      // 2. Mengambil detail autentikasi dari akun Google yang dipilih
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // 3. Membuat kredensial baru untuk dikirimkan ke Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. Masuk ke Firebase menggunakan kredensial tersebut
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      
      // Mengembalikan data user yang berhasil login
      return userCredential.user;
    } catch (e) {
      print("Terjadi kesalahan saat Google Sign-In: $e");
      return null;
    }
  }

  // Fungsi untuk Logout
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print("Gagal logout: $e");
    }
  }
}