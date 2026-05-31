import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Tambahkan import ini
import 'splash/splash_screen1.dart';

void main() async {
  // 1. Memastikan semua widget Flutter siap sebelum Firebase dijalankan
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. Inisialisasi Firebase
  await Firebase.initializeApp();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // 3. Tetap arahkan ke SplashScreen1 agar alur aplikasimu tidak rusak
      home: SplashScreen1(), 
    );
  }
}