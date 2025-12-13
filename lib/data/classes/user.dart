class UserBHT {
  final String id;
  final String nama;
  final String email;
  final String noTelp;
  final String role;

  UserBHT({
    required this.id,
    required this.nama,
    required this.email,
    required this.noTelp,
    required this.role,
  });

  factory UserBHT.fromJson(Map<String, dynamic> json) {
    return UserBHT(
      id: json['id'],
      nama: json['nama'],
      email: json['email'],
      noTelp: json['noTelp'],
      role: json['role']
    );
  }

  Map<String, dynamic> toJson() {
    return {
     'id': id,
     'nama': nama,
     'email': email,
     'noTelp': noTelp,
     'role': role,
     };
  }
}
