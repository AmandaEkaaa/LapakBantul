import 'package:flutter/material.dart';
import 'splash_screen2.dart';
import '../auth/login_page.dart';

class SplashScreen1 extends StatelessWidget {
  const SplashScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Tombol Lewati di pojok kanan atas
            Padding(
              padding: const EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => const LoginPage())),
                  child: const Text('Lewati', style: TextStyle(color: Colors.grey)),
                ),
              ),
            ),
            
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.handshake_rounded, size: 120, color: Color(0xFF1B4B7F)),
                    const SizedBox(height: 50),
                    const Text(
                      'Selamat Datang',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1B4B7F)),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Layanan publik digital Kabupaten Bantul\nkini lebih dekat dengan Anda.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Section
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  // Indicator (Page 1 active)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDot(isActive: true),
                      _buildDot(isActive: false),
                      _buildDot(isActive: false),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Button Next
                  _buildButton(
                    text: 'Lanjut',
                    onPressed: () => Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => const SplashScreen2())),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF1B4B7F) : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildButton({required String text, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1B4B7F),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}