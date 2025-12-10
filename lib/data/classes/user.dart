class User {
  final String id;
  final String nama;
  final String email;
  final String noTelp;

  User({
    required this.id,
    required this.nama,
    required this.email,
    required this.noTelp,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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
