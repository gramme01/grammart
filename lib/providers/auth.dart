import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  static const api = 'AIzaSyD9-9hnifV-irZNfAWD5hzxe20rwXS6Big';

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment';

    final resp = await http.post(
      url,
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    print(json.decode(resp.body));
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp?key=$api');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword?key=$api');
  }
}
