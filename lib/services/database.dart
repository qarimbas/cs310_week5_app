import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_week5_app/model/appuser.dart';
import 'package:flutter/material.dart';

class DBService {
  final String userToken;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  DBService({required this.userToken});

  Future<void> createUserData(String name, String date) async {
    return users.doc(userToken).set({
      'name': name,
      'last_login': date,
    });
  }

  Future<void> createAppUserData(AppUser user) async {
    return users.doc(userToken).set({
      'name': user.name,
      'last_login': user.date,
    });
  }

  List<AppUser?> _userListFromDB(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      AppUser(
        name: doc.get('name'),
        date: doc.get('last_login'),
      );
    }).toList();
  }

  Stream<List<AppUser?>> get userList {
    return users.snapshots().map(_userListFromDB);
  }
}
