import 'dart:async';

import 'package:authentication/authentication/repos/authentiaction_repository.dart';
import 'package:authentication/profile/view_models/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupViewModel extends AsyncNotifier<void> {
  late final AuthentiactionRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp() async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);
    final users = ref.read(userProvider.notifier);
    state = await AsyncValue.guard(() async {
      final userCredential = await _authRepo.signUp(
        form["email"],
        form["password"],
      );
      if (userCredential.user != null) {
        users.createAccount(userCredential);
      }
    });
  }
}

final signUpForm = StateProvider(
  (ref) => {},
);

final signUpProvider = AsyncNotifierProvider<SignupViewModel, void>(
  () => SignupViewModel(),
);
