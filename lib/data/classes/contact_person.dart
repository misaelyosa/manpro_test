class ContactPerson {
  final String id;
  final String name;
  final String role;
  final String time;
  final String info;

  ContactPerson({
    required this.id,
    required this.name,
    required this.role,
    required this.time,
    required this.info,
  });

  factory ContactPerson.fromJson(Map<String, dynamic> json) {
    return ContactPerson(
      id: json['id'],
      name: json['name'],
      role: json['role'],
      time: json['time'],
      info: json['info'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'time': time,
      'info': info,
    };
  }
}
