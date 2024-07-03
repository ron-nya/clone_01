import 'package:authentication/authentication/view_models/login_view_model.dart';
import 'package:authentication/constants/gaps.dart';
import 'package:authentication/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  static const String routerUrl = '/login';

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onPressLogin(BuildContext context, WidgetRef ref) {
    var email = _emailController.text;
    var password = _passwordController.text;
    ref.read(loginProvider.notifier).login(email, password, context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              right: Sizes.size24,
              left: Sizes.size24,
              top: Sizes.size96,
            ),
            child: Column(
              children: [
                const FaIcon(
                  FontAwesomeIcons.at,
                  size: 40,
                ),
                Gaps.v96,
                TextField(
                  controller: _emailController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  obscureText: true,
                ),
                Gaps.v52,
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => _onPressLogin(context, ref),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor, // 버튼 배경색
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Log in',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
