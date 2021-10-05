import 'dart:convert';

import 'package:chat/global/environment.dart';
import 'package:chat/models/login_response.dart';
import 'package:chat/models/register_response.dart';
import 'package:chat/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthServices with ChangeNotifier {
  User? user;
  bool _authenticating = false;

  final _storage = new FlutterSecureStorage();

  bool get authenticating => _authenticating;

  set authenticating(bool value) {
    this._authenticating = value;
    notifyListeners();
  }

  //Getters del token de forma estatica
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token!;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    final token = await this._storage.read(key: 'token') ?? '';

    this._authenticating = true;

    final data = {
      'email': email,
      'password': password,
    };

    final resp = await http.post(
        Uri.parse(
          '${Environment.apiUrl}/login',
        ),
        body: jsonEncode(data),
        headers: {
          'Content-type': 'application/json',
          'token': token,
        });
    this._authenticating = false;

    if (resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(resp.body);
      this.user = loginResponse.user;

      await this._saveToken(loginResponse.token);
      print(loginResponse.ok);

      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future register(String nombre, String email, String password) async {
    this._authenticating = true;

    final data = {
      'nombre': nombre,
      'email': email,
      'password': password,
    };

    final resp = await http.post(
      Uri.parse(
        '${Environment.apiUrl}/login/new',
      ),
      body: jsonEncode(data),
      headers: {
        'Content-type': 'application/json',
      },
    );

    this._authenticating = false;
    print(resp.body);

    if (resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(resp.body);
      this.user = loginResponse.user;

      await this._saveToken(loginResponse.token);

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');

    final resp = await http.get(
      Uri.parse(
        '${Environment.apiUrl}/login/renew',
      ),
      headers: {
        'Content-type': 'application/json',
        'x-token': token!,
      },
    );

    this._authenticating = false;
    print(resp.body);

    if (resp.statusCode == 200) {
      final loginResponse = LoginResponse.fromJson(resp.body);
      this.user = loginResponse.user;

      await this._saveToken(loginResponse.token);

      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    // Delete value
    await _storage.delete(key: 'token');
  }
}
