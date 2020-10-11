import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  Future<void> _authenticate(String email, String password, String urlSegment) {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyD69Mx66-lJ3hOpjt_aCdxyjKGMhj2uaSg";

    try {
      final response = http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      print(response.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signUp(String email, String password) async {
    return await _authenticate(email, password, 'signUp');
  }

  Future<void> signIn(String email, String password) async {
    return await _authenticate(email, password, 'signInWithPassword');
  }
}
