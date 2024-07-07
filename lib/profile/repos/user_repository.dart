import 'package:authentication/model/user_info_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> createUser(UserInfoModel user) async {
    await _db.collection('users').doc(user.id).set(user.toJson());
  }

  Future<Map<String, dynamic>?> findUser(String email) async {
    final doc = await _db.collection("users").doc(email).get();
    return doc.data();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchUsers(String email) {
    return _db.collection("users").where("id", isNotEqualTo: email).get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> searchUsers(String? email) {
    print(email);
    if (email != null) {
      return _db
          .collection("users")
          .where("id", isLessThan: email)
          .where("id", isGreaterThanOrEqualTo: "$email\uf8ff")
          .snapshots();
    } else {
      return _db
          .collection("users")
          .where("id", isNotEqualTo: email)
          .snapshots();
    }
  }
}

final userRepo = Provider((ref) => UserRepository());
