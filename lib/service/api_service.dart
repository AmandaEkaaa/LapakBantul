// STEP 3: Service Layer — semua komunikasi HTTP ada di sini
// Pisahkan logika API dari UI agar kode rapi dan mudah di-maintain

import 'dart:convert'; // untuk jsonDecode & jsonEncode
import 'package:http/http.dart' as http; // package http
import '../models/user_model.dart';

class ApiService {
  static const String _baseUrl = 'https://reqres.in/api';
  static const String _apiKey = 'free_user_3DWOwamgRjSSN11g8jTkItqsUcg';

  // Header standar: tipe konten JSON + API Key untuk autentikasi
  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'x-api-key': _apiKey,
  };

  // ─── GET: Ambil daftar pengguna dari reqres.in/api/users?page=2 ───────────
  // Future<List<UserModel>> artinya fungsi ini async dan mengembalikan List
  static Future<List<UserModel>> getUsers({int page = 2}) async {
    final url = Uri.parse('$_baseUrl/users?page=$page');
    final response = await http.get(url, headers: _headers);

    if (response.statusCode == 200) {
      // response.body adalah String JSON mentah
      // jsonDecode mengubah String → Map<String, dynamic>
      final Map<String, dynamic> body = jsonDecode(response.body);

      // Ambil list dari key 'data'
      final List<dynamic> dataList = body['data'];

      // Ubah setiap item JSON → UserModel menggunakan fromJson
      return dataList.map((item) => UserModel.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat data. Status: ${response.statusCode}');
    }
  }

  // ─── POST: Login ──────────────────────────────────────────────────────────
  // reqres test credential: eve.holt@reqres.in / cityslicka
  static Future<String> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/login');
    final response = await http.post(
      url,
      headers: _headers,
      body: jsonEncode({'email': email, 'password': password}),
    );

    final Map<String, dynamic> body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return body['token'] as String;
    } else {
      throw Exception(body['error'] ?? 'Login gagal');
    }
  }

  // ─── POST: Register ───────────────────────────────────────────────────────
  // reqres test credential: eve.holt@reqres.in / pistol
  static Future<Map<String, dynamic>> register(
    String email,
    String password,
  ) async {
    final url = Uri.parse('$_baseUrl/register');
    final response = await http.post(
      url,
      headers: _headers,
      body: jsonEncode({'email': email, 'password': password}),
    );

    final Map<String, dynamic> body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {'id': body['id'], 'token': body['token']};
    } else {
      throw Exception(body['error'] ?? 'Registrasi gagal');
    }
  }
}