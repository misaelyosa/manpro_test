class UserBHT {
  final String id;
  final String nama;
  final String email;
  final String noTelp;

  UserBHT({
    required this.id,
    required this.nama,
    required this.email,
    required this.noTelp,
  });

  factory UserBHT.fromJson(Map<String, dynamic> json) {
    return UserBHT(
      id: json['id'],
      nama: json['nama'],
      email: json['email'],
      noTelp: json['noTelp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
     'id': id,
     'nama': nama,
     'email': email,
     'noTelp': noTelp
     };
  }
}
