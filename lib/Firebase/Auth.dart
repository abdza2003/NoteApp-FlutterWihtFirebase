import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sampleproject/main.dart';

class IdItem {
  var Id;
  IdItem({required this.Id});
}

class Auth with ChangeNotifier {
  List<IdItem> addNewUser = [];
  String userId = '';
  String idToken = '';
  Future<void> _authenticate(
      {required String email,
      required String password,
      required String urlSegment}) async {
    final String urlApi =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBQrduvWvo1Pas_d_OnEi6DCyfCcQa21NI';

    try {
      http.Response res = await http.post(
        Uri.parse(urlApi),
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final resData = json.decode(res.body);
      if (resData['error'] != null) {
        throw '${resData['error']['message']}';
      }
      userId = resData['localId'];
      idToken = resData['idToken'];
      addNewUser.add(IdItem(
        Id: userId,
      ));
      print('user Id ====' + userId);
      print('idToken Id ====' + idToken);
    } catch (_) {
      throw _;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(
        email: email, password: password, urlSegment: 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(
        email: email, password: password, urlSegment: 'signInWithPassword');
  }
}

newAccountCreated(
    {required String id,
    required String userName,
    required String email,
    required String password}) async {
  pref.setString('key', '${id}');
  pref.setBool('fetch', true);

  await FirebaseFirestore.instance
      .collection('newAccount')
      .doc('${id}')
      .collection('user')
      .doc('personalInf')
      .set({
    'userName': userName,
    'email': email,
    'password': password,
    'image_url': '',
  });
}