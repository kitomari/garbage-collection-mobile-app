import 'dart:convert';

class User {
    final String id;
    final String names;
    String email;
    final String contact;
    final String username;
    final String roles;
    final String date;
    // final String status;

    User({
        required this.id,
        required this.names,
        required this.email,
        required this.contact,
        required this.username,
        required this.roles,
        required this.date,
        // required this.status,
    });

    factory User.fromMap(Map<String, dynamic> map) => User(
        id: map["id"] ?? '',
        names: map["names"] ?? '',
        email: map["email"] ?? '',
        contact: map["contact"] ?? '',
        username: map["username"] ?? '',
        roles: map["roles"] ?? '',
        date: map["date"] ?? '',
        // status: map["status"] ?? '',
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "names": names,
        "email": email,
        "contact": contact,
        "username": username,
        "roles": roles,
        "date": date,
        // "status": status,
    };

    String toJson() => json.encode(toMap());

    factory User.fromJson(String source) => User.fromMap(json.decode(source));


}
