import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth asli
import 'package:shared_preferences/shared_preferences.dart'; // Tambahan lokal storage untuk akal-akalan token
import 'package:google_sign_in/google_sign_in.dart'; // Tambahan import package Google Sign In agar clientId bisa terbaca langsung
import '../auth_service.dart'; // Import AuthService pendukung
import 'register_page.dart'; //
import '../main_navigation.dart'; //
import '../service/api_service.dart'; //

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Kunci Global untuk validasi Form
  final _formKey = GlobalKey<FormState>();
  
  // Controller dengan default value resmi ReqRes API
  final _emailCtrl = TextEditingController(text: 'eve.holt@reqres.in'); //
  final _passCtrl = TextEditingController(text: 'cityslicka'); //
  
  bool _isLoading = false;
  bool _isLoadingGoogle = false; // Loading khusus tombol Google 
  bool _obscure = true;

  // Inisialisasi AuthService untuk Google Sign-In asli
  final AuthService _googleAuthService = AuthService(); //

  // Fungsi Login yang memanfaatkan ApiService (ReqRes)
  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      setState(() => _isLoading = true);

      try {
        final token = await ApiService.login(
          _emailCtrl.text.trim(),
          _passCtrl.text.trim(),
        );

        if (token.isNotEmpty) {
          // ─── SIMPAN DATA LOGIN REQRES KE STORAGE LOKAL ───
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('loginMethod', 'reqres');
          await prefs.setString('userToken', token);

          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainNavigation()),
          );
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login Gagal: ${e.toString().replaceAll('Exception:', '')}"),
            backgroundColor: Colors.redAccent,
          ),
        );
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  // Fungsi Login menggunakan Google SSO ASLI (Terhubung ke Firebase)
  Future<void> loginWithGoogle() async {
    setState(() => _isLoadingGoogle = true);
    
    try {
      // ─── PENAMBAHAN KODE UTAMA (WEB CLIENT ID) ───
      // Menginisialisasi proses login langsung menggunakan Web Client ID milikmu agar sinkron dengan Firebase
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: '702115860998-j0gfajue10ijdo8d75e3t1cbgpb6i030.apps.googleusercontent.com',
      );
      
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        
        // Melakukan sign in ke Firebase Authentication
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        User? user = userCredential.user;
      
        if (user != null) {
          // ─── AKALI DATA LOGIN GOOGLE AGAR STRUKTUR TOKEN SAMA SEPERTI REQRES ───
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('loginMethod', 'google');
          await prefs.setString('userName', user.displayName ?? "User Google");
          await prefs.setString('userEmail', user.email ?? "");
          
          // Membuat token tiruan berbasis UID Google user agar dibaca sah oleh MainNavigation
          await prefs.setString('userToken', 'google_sso_token_${user.uid}');

          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainNavigation()),
          );
        }
      } else {
        // Jika user membatalkan pilihan akun google/menutup pop-up
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login dengan Google dibatalkan."),
            backgroundColor: Colors.amber,
          ),
        );
      }
    } catch (e) {
      // Menangkap error jika ada kendala sistem (seperti salah SHA-1 atau internet mati)
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal SSO Google: ${e.toString()}"),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoadingGoogle = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), //
      body: SingleChildScrollView(
        child: Form(
          key: _formKey, //
          child: Column(
            children: [
              _buildHeader(), //

              Padding(
                padding: const EdgeInsets.all(24.0), //
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, //
                  children: [
                    // BANNER NOTIFIKASI INFORMASI AKUN REQRES ASLI
                    Container(
                      width: double.infinity, //
                      margin: const EdgeInsets.only(bottom: 20), //
                      padding: const EdgeInsets.all(14), //
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2F6), //
                        borderRadius: BorderRadius.circular(12), //
                        border: Border.all(color: const Color(0xFF1B4B7F).withOpacity(0.2)), //
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, //
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.info_outline_rounded, color: Color(0xFF1B4B7F), size: 20), //
                              SizedBox(width: 8), //
                              Text(
                                "Petunjuk Akun Resmi ReqRes API",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, 
                                  color: Color(0xFF1B4B7F),
                                  fontSize: 14,
                                ), //
                              ),
                            ],
                          ),
                          const SizedBox(height: 8), //
                          const Text(
                            "• Email: eve.holt@reqres.in\n• Pass:  cityslicka",
                            style: TextStyle(
                              fontSize: 13, 
                              color: Colors.black87, 
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3
                            ), //
                          ),
                        ],
                      ),
                    ),
                    
                    const Text(
                      "Selamat Datang",
                      style: TextStyle(
                        fontSize: 24, 
                        fontWeight: FontWeight.bold, 
                        color: Color(0xFF1B4B7F)
                      ), //
                    ),
                    const Text(
                      "Masuk untuk mengakses layanan LaPak Bantul",
                      style: TextStyle(color: Colors.grey, fontSize: 14), //
                    ),
                    const SizedBox(height: 30), //

                    // KARTU FORM INPUT
                    Container(
                      padding: const EdgeInsets.all(20), //
                      decoration: BoxDecoration(
                        color: Colors.white, //
                        borderRadius: BorderRadius.circular(16), //
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05), //
                            blurRadius: 10, //
                            offset: const Offset(0, 4), //
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // INPUT EMAIL
                          TextFormField(
                            controller: _emailCtrl, //
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              hintText: 'contoh: eve.holt@reqres.in',
                              prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF1B4B7F)),
                            ), //
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!value.contains('@')) {
                                return 'Format email salah';
                              }
                              return null;
                            },
                          ),
                          
                          const SizedBox(height: 20), //

                          // INPUT PASSWORD
                          TextFormField(
                            controller: _passCtrl, //
                            obscureText: _obscure, //
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF1B4B7F)), //
                              suffixIcon: IconButton(
                                icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility), //
                                onPressed: () => setState(() => _obscure = !_obscure), //
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30), //

                    // TOMBOL SUBMIT LOGIN UTAMA
                    SizedBox(
                      width: double.infinity, //
                      height: 55, //
                      child: ElevatedButton(
                        onPressed: (_isLoading || _isLoadingGoogle) ? null : login, //
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B4B7F), //
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), //
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                              ) //
                            : const Text(
                                "MASUK",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                              ), //
                      ),
                    ),

                    const SizedBox(height: 20), //

                    // ─── SEPARATOR / GARIS PEMBATAS ATAU MASUK DENGAN ───
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)), //
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12), //
                          child: Text(
                            "atau masuk dengan",
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ), //
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)), //
                      ],
                    ),

                    const SizedBox(height: 20), //

                    // ─── TOMBOL SSO GOOGLE ASLI ───
                    SizedBox(
                      width: double.infinity, //
                      height: 55, //
                      child: OutlinedButton(
                        onPressed: (_isLoading || _isLoadingGoogle) ? null : loginWithGoogle, //
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white, //
                          side: BorderSide(color: Colors.grey.shade300, width: 1.5), //
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), //
                        ),
                        child: _isLoadingGoogle
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(color: Color(0xFF1B4B7F), strokeWidth: 2),
                              ) //
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center, //
                                children: [
                                  Image.network(
                                    'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_Search_2015_Icon.svg/1200px-Google_Search_2015_Icon.svg.png', //
                                    height: 22, //
                                    width: 22, //
                                    fit: BoxFit.contain, //
                                    errorBuilder: (context, error, stackTrace) => const Icon(
                                      Icons.g_mobiledata_rounded, 
                                      color: Colors.redAccent, 
                                      size: 30
                                    ), //
                                  ),
                                  const SizedBox(width: 12), //
                                  const Text(
                                    "Masuk dengan Google",
                                    style: TextStyle(
                                      color: Colors.black87, 
                                      fontWeight: FontWeight.bold, 
                                      fontSize: 15,
                                    ), //
                                  ),
                                ],
                              ),
                      ),
                    ),

                    const SizedBox(height: 25), //

                    // NAVIGASI KE REGISTER
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterPage()),
                          ); //
                        },
                        child: RichText(
                          text: const TextSpan(
                            text: "Belum punya akun? ",
                            style: TextStyle(color: Colors.grey), //
                            children: [
                              TextSpan(
                                text: "Daftar",
                                style: TextStyle(color: Color(0xFF1B4B7F), fontWeight: FontWeight.bold), //
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Desain Header Biru LaPak Bantul
  Widget _buildHeader() {
    return Container(
      width: double.infinity, //
      height: 230, //
      decoration: const BoxDecoration(
        color: Color(0xFF1B4B7F), //
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50), //
          bottomRight: Radius.circular(50), //
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, //
        children: const [
          Icon(Icons.account_balance_wallet, size: 60, color: Colors.white), //
          SizedBox(height: 10), //
          Text(
            "LaPak Bantul",
            style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold), //
          ),
          Text("Kabupaten Bantul", style: TextStyle(color: Colors.white70, fontSize: 14)), //
        ],
      ),
    );
  }
}