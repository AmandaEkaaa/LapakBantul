import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'register_page.dart';
import '../main_navigation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 1. Kunci Global untuk validasi Form
  final _formKey = GlobalKey<FormState>();
  
  // 2. Controller untuk mengambil teks dari input
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  
  bool _isLoading = false;
  bool _obscure = true;

  // 3. Fungsi Login dengan Validasi Form
  Future<void> login() async {
    // Menjalankan semua validator di TextFormField
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      setState(() => _isLoading = true);

      try {
        final response = await http.post(
          Uri.parse('https://reqres.in/api/login'),
          body: {
            "email": _emailCtrl.text,
            "password": _passCtrl.text,
          },
        );

        if (response.statusCode == 200) {
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainNavigation()),
          );
        } else {
          if (!mounted) return;
          _showError("Email atau Password salah (Gunakan akun ReqRes)");
        }
      } catch (e) {
        _showError("Gagal terhubung ke server");
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        // KONSEP UTAMA: Form membungkus seluruh konten UI
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // HEADER BAGIAN ATAS
              _buildHeader(),

              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Selamat Datang",
                      style: TextStyle(
                        fontSize: 24, 
                        fontWeight: FontWeight.bold, 
                        color: Color(0xFF1B4B7F)
                      ),
                    ),
                    const Text(
                      "Masuk untuk mengakses layanan LaPak Bantul",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 30),

                    // KARTU FORM INPUT
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // INPUT EMAIL
                          TextFormField(
                            controller: _emailCtrl,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              hintText: 'contoh: eve.holt@reqres.in',
                              prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF1B4B7F)),
                            ),
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
                          
                          const SizedBox(height: 20),

                          // INPUT PASSWORD
                          TextFormField(
                            controller: _passCtrl,
                            obscureText: _obscure,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF1B4B7F)),
                              suffixIcon: IconButton(
                                icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                                onPressed: () => setState(() => _obscure = !_obscure),
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

                    const SizedBox(height: 40),

                    // TOMBOL SUBMIT LOGIN
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B4B7F),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                              )
                            : const Text(
                                "MASUK",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // NAVIGASI KE REGISTER
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterPage()),
                          );
                        },
                        child: RichText(
                          text: const TextSpan(
                            text: "Belum punya akun? ",
                            style: TextStyle(color: Colors.grey),
                            children: [
                              TextSpan(
                                text: "Daftar",
                                style: TextStyle(color: Color(0xFF1B4B7F), fontWeight: FontWeight.bold),
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
      width: double.infinity,
      height: 230,
      decoration: const BoxDecoration(
        color: Color(0xFF1B4B7F),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.account_balance_wallet, size: 60, color: Colors.white),
          SizedBox(height: 10),
          Text(
            "LaPak Bantul",
            style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
          ),
          Text("Kabupaten Bantul", style: TextStyle(color: Colors.white70, fontSize: 14)),
        ],
      ),
    );
  }
}