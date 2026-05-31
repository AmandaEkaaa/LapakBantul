import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Tambahan untuk membaca session login
import 'package:lapakbantul/users/users_page.dart'; //[cite: 1]

// Import file sesuai struktur folder proyek
import 'home.dart'; //[cite: 1]
import 'tax/pbb_page.dart'; //[cite: 1]
import 'tax/layanan_keliling.dart'; //[cite: 1]
import 'tax/home_keliling.dart'; //[cite: 1]

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0; //[cite: 1]
  String _loginMethod = '';
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Memuat data user saat halaman pertama kali dibuka
  }

  // Fungsi untuk mengambil data yang disimpan saat proses login tadi
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _loginMethod = prefs.getString('loginMethod') ?? 'reqres';
      _userName = prefs.getString('userName') ?? 'Pengguna LaPak Bantul';
    });
  }

  // Daftar halaman berdasarkan file yang ada[cite: 1]
  final List<Widget> _pages = [
    const HomePage(), //[cite: 1]
    const PBBPage(), //[cite: 1]
    const UsersPage(), //[cite: 1]
    const HomePageScreen(), //[cite: 1]
    const LayananKelilingPage(), //[cite: 1]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menggunakan IndexedStack agar state halaman tidak hilang saat pindah tab[cite: 1]
      body: IndexedStack(
        index: _selectedIndex, //[cite: 1]
        children: _pages, //[cite: 1]
      ),
      
      // Modifikasi Bottom Navigation Bar[cite: 1]
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), //[cite: 1]
              blurRadius: 10, //[cite: 1]
              offset: const Offset(0, -2), //[cite: 1]
            ),
          ],
        ),
        child: ClipRRect(
          // Membuat sudut atas navigasi melengkung[cite: 1]
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), //[cite: 1]
            topRight: Radius.circular(20), //[cite: 1]
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex, //[cite: 1]
            onTap: (index) {
              setState(() {
                _selectedIndex = index; //[cite: 1]
              });
            },
            type: BottomNavigationBarType.fixed, //[cite: 1]
            backgroundColor: Colors.white, //[cite: 1]
            selectedItemColor: const Color(0xFF1B4B7F), // Warna Biru LaPak Bantul[cite: 1]
            unselectedItemColor: Colors.grey.shade400, //[cite: 1]
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12), //[cite: 1]
            unselectedLabelStyle: const TextStyle(fontSize: 12), //[cite: 1]
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), //[cite: 1]
                activeIcon: Icon(Icons.home_rounded), //[cite: 1]
                label: 'Beranda', //[cite: 1]
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.description_outlined), //[cite: 1]
                activeIcon: Icon(Icons.description_rounded), //[cite: 1]
                label: 'PBB', //[cite: 1]
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.payments_outlined), //[cite: 1]
                activeIcon: Icon(Icons.payments_rounded), //[cite: 1]
                label: 'Data Diri', //[cite: 1]
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_on_outlined), //[cite: 1]
                activeIcon: Icon(Icons.location_on_rounded), //[cite: 1]
                label: 'Lokasi', //[cite: 1]
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.commute_outlined), //[cite: 1]
                activeIcon: Icon(Icons.commute_rounded), //[cite: 1]
                label: 'Kendaraan', //[cite: 1]
              ),
            ],
          ),
        ),
      ),
    );
  }
}