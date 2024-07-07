import 'dart:async';

import 'package:authentication/authentication/repos/authentiaction_repository.dart';
import 'package:authentication/model/user_info_model.dart';
import 'package:authentication/profile/repos/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserSearchViewModel extends AsyncNotifier<List<UserInfoModel>> {
  late final UserRepository _repository;
  late final AuthentiactionRepository _authenticationRepository;
  List<UserInfoModel> _list = [];

  @override
  FutureOr<List<UserInfoModel>> build() async {
    _repository = ref.read(userRepo);
    _authenticationRepository = ref.read(authRepo);
    _list = await _fetchUsers();
    return _list.toList();
  }

  Future<List<UserInfoModel>> _fetchUsers() async {
    final result =
        await _repository.fetchUsers(_authenticationRepository.user!.email!);
    final users = result.docs.map(
      (doc) => UserInfoModel.fromJson(doc.data()),
    );
    return users.toList();
  }

  Stream<List<UserInfoModel>> searchUsers(String email) {
    final result = _repository.searchUsers(email);
    final users = result.map((event) => event.docs
        .map(
          (doc) => UserInfoModel.fromJson(
            doc.data(),
          ),
        )
        .toList());
    return users;
  }
}

final userfetchProvider =
    AsyncNotifierProvider<UserSearchViewModel, List<UserInfoModel>>(
  () => UserSearchViewModel(),
);

final userSearchProvider =
    StreamProvider.family<List<UserInfoModel>, String>((ref, email) {
  final db = FirebaseFirestore.instance;
  final authenticationRepository = ref.read(authRepo);

  return db
      .collection("users")
      .where("id", isLessThan: "$email\uf8ff")
      .where("id", isGreaterThanOrEqualTo: email)
      .where("id", isNotEqualTo: authenticationRepository.user!.email)
      .snapshots()
      .map((event) => event.docs
          .map(
            (doc) => UserInfoModel.fromJson(
              doc.data(),
            ),
          )
          .toList());
});
