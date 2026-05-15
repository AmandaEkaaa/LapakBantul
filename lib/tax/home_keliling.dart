import 'package:flutter/material.dart';
import 'package:lapakbantul/tax/layanan_keliling.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildContent(context),
          ],
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1B4B7F), Color(0xFF2361A1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'LaPak Bantul',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Pusat layanan pajak terpadu',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.yellow[600],
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/image/lapak.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= CONTENT =================
  Widget _buildContent(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMainCard(context),
            const SizedBox(height: 25),
            _buildInformasiPajak(),
          ],
        ),
      ),
    );
  }

  // ================= MAIN CARD =================
  Widget _buildMainCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildGrid(context),
          const SizedBox(height: 20),
          _buildLayananKelilingButton(context),
        ],
      ),
    );
  }

  // ================= GRID =================
  Widget _buildGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildBPHTBCard(context, 'BPHTB'),
            const SizedBox(width: 15),
            _buildBPHTBCard(context, 'BPHTB'),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            _buildBPHTBCard(context, 'BPHTB'),
            const SizedBox(width: 15),
            _buildBPHTBCard(context, 'BPHTB'),
          ],
        ),
      ],
    );
  }

  // ================= BUTTON LAYANAN KELILING =================
  Widget _buildLayananKelilingButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LayananKelilingPage(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1B4B7F),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 2,
      ),
      child: Row(
        children: const [
          Icon(Icons.local_shipping_outlined, color: Colors.white, size: 32),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Layanan Keliling',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Lihat jadwal layanan keliling',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
        ],
      ),
    );
  }

  // ================= CARD BPHTB =================
  Widget _buildBPHTBCard(BuildContext context, String title) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          print('$title tapped');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF4F7FA),
          foregroundColor: const Color(0xFF1B4B7F),
          padding: const EdgeInsets.symmetric(vertical: 24),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          side: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        child: Column(
          children: [
            const Icon(Icons.description_outlined, size: 36, color: Color(0xFF1B4B7F)),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF1B4B7F),
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= INFORMASI =================
  Widget _buildInformasiPajak() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informasi Pajak',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B4B7F),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/image/info.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}