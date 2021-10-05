// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromMap(jsonString);

import 'dart:convert';

class RegisterResponse {
  RegisterResponse({
    required this.nombre,
    required this.email,
    required this.password,
  });

  String nombre;
  String email;
  String password;

  factory RegisterResponse.fromJson(String str) =>
      RegisterResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterResponse.fromMap(Map<String, dynamic> json) =>
      RegisterResponse(
        nombre: json["nombre"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "email": email,
        "password": password,
      };
}
