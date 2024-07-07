import 'dart:async';

import 'package:authentication/authentication/repos/authentiaction_repository.dart';
import 'package:authentication/model/user_info_model.dart';
import 'package:authentication/profile/repos/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserViewModel extends AsyncNotifier<UserInfoModel> {
  late final UserRepository _repository;
  late final AuthentiactionRepository _authenticationRepository;

  @override
  FutureOr<UserInfoModel> build() async {
    _repository = ref.read(userRepo);
    _authenticationRepository = ref.read(authRepo);

    if (_authenticationRepository.isLoggedIn) {
      final user =
          await _repository.findUser(_authenticationRepository.user!.email!);
      return UserInfoModel.fromJson(user!);
    }

    return UserInfoModel.empty();
  }

  Future<void> createAccount(UserCredential credentail) async {
    if (credentail.user == null) {
      throw Exception('not created');
    }
    state = const AsyncValue.loading();
    final user = UserInfoModel(
        id: credentail.user!.email!,
        name: credentail.user!.displayName ?? 'Anomynous',
        profileImageUrl: 'https://picsum.photos/id/1/150/150',
        authentication: false,
        followerCount: 0);
    await _repository.createUser(user);
    print(user.id);
    state = AsyncValue.data(user);
  }
}

final userProvider = AsyncNotifierProvider<UserViewModel, UserInfoModel>(
  () => UserViewModel(),
);
