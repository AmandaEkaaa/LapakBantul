import 'package:flutter/material.dart';
import 'package:lapakbantul/tax/pbb_page2.dart';

class PBBPage extends StatefulWidget {
  const PBBPage({super.key});

  @override
  State<PBBPage> createState() => _PBBPageState();
}

class _PBBPageState extends State<PBBPage> {
  // Controller untuk memantau input NOP
  final TextEditingController _nopController = TextEditingController();
  bool _isFound = false;

  void _searchNOP(String value) {
    setState(() {
      // Simulasi: Jika NOP yang dimasukkan adalah "123", maka data dianggap ditemukan
      _isFound = value == "123";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Pajak Bumi Bangunan",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey.shade200, height: 1.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// SEARCH BOX
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: TextField(
                controller: _nopController,
                onChanged: _searchNOP,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  icon: const Icon(Icons.search, color: Colors.grey),
                  hintText: "Masukkan NOP (Contoh: 123)",
                  hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                  border: InputBorder.none,
                  suffixIcon: _nopController.text.isNotEmpty 
                    ? IconButton(
                        icon: const Icon(Icons.clear), 
                        onPressed: () {
                          _nopController.clear();
                          _searchNOP("");
                        }) 
                    : null,
                ),
              ),
            ),
            const SizedBox(height: 40),

            /// TAMPILAN DINAMIS
            if (!_isFound) ...[
              // Tampilan jika data belum ditemukan atau input salah
              const SizedBox(height: 50),
              const Icon(Icons.manage_search_rounded, color: Color(0xFF1B4B7F), size: 80),
              const SizedBox(height: 20),
              const Text(
                "Data Belum Dicari",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Masukkan NOP '123' untuk simulasi pencarian data pajak Anda.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
            ] else ...[
              // Tampilan preview jika NOP ditemukan
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), 
                  side: BorderSide(color: Colors.green.shade200),
                ),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFE8F8F5), 
                    child: Icon(Icons.check, color: Colors.green),
                  ),
                  title: const Text(
                    "NOP Ditemukan!",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("NOP: ${_nopController.text}"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () {
                    // Navigasi ke halaman daftar tunggakan
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const PBBResultPage()),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}