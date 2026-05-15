import 'package:flutter/material.dart';
import 'package:lapakbantul/tax/pbb_page.dart';

class LayananKelilingPage extends StatelessWidget {
  const LayananKelilingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: _buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTanggal(),
          const SizedBox(height: 20),
          _buildHari(),
          const SizedBox(height: 12),
          _buildListJadwal(context),
        ],
      ),
    );
  }

  // ================= APPBAR =================
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        "Layanan Keliling",
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black87, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Colors.grey.shade200,
          height: 1.0,
        ),
      ),
    );
  }

  // ================= TANGGAL =================
  Widget _buildTanggal() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _dateItem("21/01/2024", true),
          _dateItem("25/01/2024", false),
          _dateItem("28/01/2024", false),
        ],
      ),
    );
  }

  // ================= HARI =================
  Widget _buildHari() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        "Hari Ini, 21 Januari 2024",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black54,
        ),
      ),
    );
  }

  // ================= LIST =================
  Widget _buildListJadwal(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const MobilCard(
            title: "Mobil 01",
            location: "Mangir lor & Manager tengah, sendang",
          ),
          const SizedBox(height: 14),
          const MobilCard(
            title: "Mobil 02",
            location: "Mangir lor & Manager tengah, sendang",
          ),
          const SizedBox(height: 14),
          MobilCard(
            title: "Inova Rebon",
            location: "Mobil Pribadi Anak PEPELEGE",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PBBPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ================= DATE ITEM =================
  Widget _dateItem(String date, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF1B4B7F) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: const Color(0xFF1B4B7F).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ]
            : null,
      ),
      child: Text(
        date,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black87,
          fontWeight: selected ? FontWeight.bold : FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }
}

// ================= MOBIL CARD =================
class MobilCard extends StatelessWidget {
  final String title;
  final String location;
  final VoidCallback? onPressed;

  const MobilCard({
    super.key,
    required this.title,
    required this.location,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1B4B7F),
        elevation: 0,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade200),
        ),
      ).copyWith(
        elevation: MaterialStateProperty.resolveWith<double>((states) {
          if (states.contains(MaterialState.pressed)) return 0;
          return 2;
        }),
        shadowColor: MaterialStateProperty.all(Colors.black.withOpacity(0.05)),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TEXT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on, size: 18, color: Color(0xFFE74C3C)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          location,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                            height: 1.3,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(width: 10),
            // JAM
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF2F6),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF1B4B7F).withOpacity(0.1)),
              ),
              child: Row(
                children: const [
                  Icon(Icons.access_time, size: 14, color: Color(0xFF1B4B7F)),
                  SizedBox(width: 4),
                  Text(
                    "08:00 - 16:00",
                    style: TextStyle(
                      color: Color(0xFF1B4B7F),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}