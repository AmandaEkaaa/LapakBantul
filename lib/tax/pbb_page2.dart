import 'package:flutter/material.dart';
import 'detail_sppt_page.dart'; // Pastikan file ini ada di folder yang sama

class PBBResultPage extends StatelessWidget {
  const PBBResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          "Daftar Tunggakan PBB",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "Riwayat Tagihan Pajak",
            style: TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.bold, 
              color: Color(0xFF1B4B7F),
            ),
          ),
          const SizedBox(height: 16),
          
          // DAFTAR TAGIHAN (Contoh Data)
          const SPPTCard(
            tahun: "SPPT 2023",
            alamat: "Kec. Bantul, Kab. Bantul",
            status: "BELUM LUNAS",
            isLunas: false,
            nominal: "Rp 250.000",
          ),
          const SizedBox(height: 12),
          const SPPTCard(
            tahun: "SPPT 2022",
            alamat: "Kec. Bantul, Kab. Bantul",
            status: "BELUM LUNAS",
            isLunas: false,
            nominal: "Rp 245.000",
          ),
          const SizedBox(height: 12),
          const SPPTCard(
            tahun: "SPPT 2021",
            alamat: "Kec. Bantul, Kab. Bantul",
            status: "LUNAS",
            isLunas: true,
            nominal: "Rp 210.000",
          ),
          
          const SizedBox(height: 30),
          
          // Tombol Menuju Detail Lengkap
          const SPPTButtonCard(),
        ],
      ),
    );
  }
}

// --- WIDGET KOMPONEN AGAR TIDAK ERROR ---

class SPPTCard extends StatelessWidget {
  final String tahun;
  final String alamat;
  final String status;
  final String nominal;
  final bool isLunas;

  const SPPTCard({
    super.key,
    required this.tahun,
    required this.alamat,
    required this.status,
    required this.nominal,
    required this.isLunas,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tahun,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(alamat, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 8),
              Text(
                nominal,
                style: const TextStyle(
                  fontWeight: FontWeight.bold, 
                  color: Color(0xFF1B4B7F),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isLunas ? Colors.green.shade50 : Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: isLunas ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SPPTButtonCard extends StatelessWidget {
  const SPPTButtonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DetailSpptPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1B4B7F), Color(0xFF2E5E91)],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          children: [
            Icon(Icons.open_in_new_rounded, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                "Lihat Rincian Detail SPPT",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),
          ],
        ),
      ),
    );
  }
}