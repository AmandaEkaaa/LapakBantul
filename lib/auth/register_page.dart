import 'package:flutter/material.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Controller
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();
  
  bool _obscure = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      // Simulasi loading pendaftaran
      await Future.delayed(const Duration(seconds: 2));
      
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pendaftaran berhasil! Silakan masuk.'),
          backgroundColor: Colors.green,
        ),
      );
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER (Konsisten dengan LoginPage)
            _buildHeader(),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Daftar Akun",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1B4B7F)),
                    ),
                    const Text("Lengkapi data diri untuk pendaftaran",
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const SizedBox(height: 25),

                    // KOTAK INPUT (Style Card Putih)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(color: Colors.grey.shade100),
                      ),
                      child: Column(
                        children: [
                          _buildField(
                            controller: _nameCtrl,
                            label: "Nama Lengkap",
                            icon: Icons.person_outline,
                            validator: (v) => (v == null || v.isEmpty) ? 'Nama wajib diisi' : null,
                          ),
                          const SizedBox(height: 20),
                          _buildField(
                            controller: _emailCtrl,
                            label: "Email",
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            validator: (v) => (v == null || !v.contains('@')) ? 'Email tidak valid' : null,
                          ),
                          const SizedBox(height: 20),
                          _buildField(
                            controller: _phoneCtrl,
                            label: "Nomor Telepon",
                            icon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                            validator: (v) => (v == null || v.length < 10) ? 'Nomor tidak valid' : null,
                          ),
                          const SizedBox(height: 20),
                          _buildField(
                            controller: _passCtrl,
                            label: "Kata Sandi",
                            icon: Icons.lock_outline,
                            isPassword: true,
                            obscure: _obscure,
                            onToggle: () => setState(() => _obscure = !_obscure),
                            validator: (v) => (v == null || v.length < 6) ? 'Minimal 6 karakter' : null,
                          ),
                          const SizedBox(height: 20),
                          _buildField(
                            controller: _confirmPassCtrl,
                            label: "Konfirmasi Kata Sandi",
                            icon: Icons.lock_reset,
                            isPassword: true,
                            obscure: _obscureConfirm,
                            onToggle: () => setState(() => _obscureConfirm = !_obscureConfirm),
                            validator: (v) => v != _passCtrl.text ? 'Kata sandi tidak cocok' : null,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // TOMBOL DAFTAR
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B4B7F),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 2,
                        ),
                        child: _isLoading
                            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                            : const Text("DAFTAR SEKARANG", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // BACK TO LOGIN
                    Center(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: RichText(
                          text: const TextSpan(
                            text: 'Sudah punya akun? ',
                            style: TextStyle(color: Colors.grey),
                            children: [
                              TextSpan(
                                text: 'Masuk',
                                style: TextStyle(color: Color(0xFF1B4B7F), fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: const BoxDecoration(
        color: Color(0xFF1B4B7F),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      ),
      child: Stack(
        children: [
          SafeArea(
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.person_add_outlined, size: 50, color: Colors.white),
                SizedBox(height: 10),
                Text("Registrasi", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    bool? obscure,
    VoidCallback? onToggle,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black54)),
        TextFormField(
          controller: controller,
          obscureText: isPassword ? (obscure ?? true) : false,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: const Color(0xFF1B4B7F), size: 20),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(obscure! ? Icons.visibility_off : Icons.visibility, size: 20),
                    onPressed: onToggle,
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200)),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF1B4B7F))),
            errorStyle: const TextStyle(fontSize: 11),
          ),
        ),
      ],
    );
  }
}