// STEP 1: Model = "cetakan" untuk data JSON dari API
// Setiap field di JSON kita buat jadi properti class

class UserModel {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  // STEP 2: fromJson — mengubah Map (hasil decode JSON) → objek UserModel
  // json['first_name'] artinya ambil nilai dengan key "first_name" dari Map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      avatar: json['avatar'] as String,
    );
  }

  String get fullName => '$firstName $lastName';
}




































