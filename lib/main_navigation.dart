import 'package:flutter/material.dart';

// Import file sesuai struktur folder di gambar
import 'home.dart';
import 'tax/pbb_page.dart';
import 'tax/layanan_keliling.dart';
// Asumsi: Halaman Kendaraan dan Usaha menggunakan file yang tersedia di folder tax
// Kamu bisa menyesuaikan class name di bawah jika berbeda
import 'tax/pbb_page2.dart'; 
import 'tax/home_keliling.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // Daftar halaman berdasarkan file yang ada di folder tax
  final List<Widget> _pages = [
    const HomePage(),
    const PBBPage(),
    const PBBResultPage(), // Contoh pengganti halaman pajak lainnya
    const HomePageScreen(),
    const LayananKelilingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menggunakan IndexedStack agar state halaman tidak hilang saat pindah tab
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      
      // Modifikasi Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          // Membuat sudut atas navigasi melengkung
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF1B4B7F), // Warna Biru LaPak Bantul
            unselectedItemColor: Colors.grey.shade400,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            unselectedLabelStyle: const TextStyle(fontSize: 12),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home_rounded),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.description_outlined),
                activeIcon: Icon(Icons.description_rounded),
                label: 'PBB',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.payments_outlined),
                activeIcon: Icon(Icons.payments_rounded),
                label: 'Pajak',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_on_outlined),
                activeIcon: Icon(Icons.location_on_rounded),
                label: 'Lokasi',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.commute_outlined),
                activeIcon: Icon(Icons.commute_rounded),
                label: 'Keliling',
              ),
            ],
          ),
        ),
      ),
    );
  }
}