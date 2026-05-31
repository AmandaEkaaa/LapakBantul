// STEP 4: UsersPage — StatelessWidget + FutureBuilder
//
// MENGAPA StatelessWidget?
// Karena halaman ini tidak punya state internal yang berubah.
// Data dikelola oleh FutureBuilder, bukan setState().
//
// MENGAPA FutureBuilder?
// FutureBuilder secara otomatis menangani 3 kondisi:
//   1. Waiting  → tampilkan loading spinner
//   2. Error    → tampilkan pesan error
//   3. Done     → tampilkan data

import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../service/api_service.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Data Pengguna API',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF003566),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildInfoBanner(),
          Expanded(
            child: FutureBuilder<List<UserModel>>(
              // future: fungsi async yang akan dieksekusi
              future: ApiService.getUsers(page: 2),
              // builder: dipanggil setiap kali status Future berubah
              builder: (context, snapshot) {
                // snapshot.connectionState = status koneksi Future
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: Color(0xFF003566)),
                        SizedBox(height: 16),
                        Text(
                          'Mengambil data dari server...',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                // snapshot.hasError = true jika Future melempar Exception
                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.wifi_off,
                            size: 64,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Gagal memuat data:\n${snapshot.error}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                // snapshot.data = hasil dari Future (List<UserModel>)
                final users = snapshot.data!;
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return _UserCard(user: users[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: const Color(0xFF003566).withValues(alpha: 0.08),
      child: const Row(
        children: [
          Icon(Icons.info_outline, size: 16, color: Color(0xFF003566)),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'GET reqres.in/api/users?page=2 — parsing JSON → UserModel',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF003566),
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final UserModel user;

  const _UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            // Avatar dari URL (jaringan)
            ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Image.network(
                user.avatar,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                errorBuilder: (ctx, err, stack) => const CircleAvatar(
                  radius: 28,
                  child: Icon(Icons.person),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xFF003566),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.email,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF003566),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'ID ${user.id}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}