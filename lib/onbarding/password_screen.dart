import 'package:authentication/authentication/view_models/signup_view_model.dart';
import 'package:authentication/constants/gaps.dart';
import 'package:authentication/constants/sizes.dart';
import 'package:authentication/onbarding/intersets_screen.dart';
import 'package:authentication/widgets/auth_button.dart';
import 'package:authentication/widgets/twitter_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  const PasswordScreen({super.key});

  @override
  ConsumerState<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends ConsumerState<PasswordScreen> {
  bool _obscureText = true;
  String _password = '';
  final TextEditingController _passwordController = TextEditingController();

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool _verifyPassword() {
    if (_password.length >= 8) {
      return true;
    }
    return false;
  }

  void onTapNext() {
    if (!_verifyPassword()) return;
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {
      ...state,
      "password": _password,
    };
    ref.read(signUpProvider.notifier).signUp();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const IntersetsScreen(),
    ));
  }

  void _onTapScaffold() {
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTapScaffold,
      child: Scaffold(
        appBar: const TwitterAppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                left: Sizes.size36,
                right: Sizes.size36,
                top: Sizes.size36,
                bottom: Sizes.size12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v16,
                Text(
                  'You need a password',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Gaps.v14,
                Text('Make sure it\'s 8 charactersor more.',
                    style: Theme.of(context).textTheme.titleSmall),
                Gaps.v14,
                TextField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    suffix: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: _toggleObscureText,
                          child: FaIcon(
                            _obscureText
                                ? FontAwesomeIcons.eyeSlash
                                : FontAwesomeIcons.eye,
                            color: Colors.grey.shade400,
                            size: Sizes.size20,
                          ),
                        ),
                        Gaps.h5,
                        _verifyPassword()
                            ? const FaIcon(
                                FontAwesomeIcons.solidCircleCheck,
                                color: Colors.green,
                                size: Sizes.size20,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: Sizes.size96 + Sizes.size48,
          child: GestureDetector(
            onTap: onTapNext,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AuthButton(
                    title: 'Next',
                    boxColor: _verifyPassword() ? Colors.black : Colors.grey,
                    textColor: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
