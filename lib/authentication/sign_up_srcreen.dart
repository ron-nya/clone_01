import 'package:authentication/constants/gaps.dart';
import 'package:authentication/constants/sizes.dart';
import 'package:authentication/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpSrcreen extends StatelessWidget {
  const SignUpSrcreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FaIcon(
          FontAwesomeIcons.twitter,
          color: Theme.of(context).primaryColor,
          size: Sizes.size36,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gaps.v96,
              const Text(
                'See What\'s Happening\nin the world right now.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Sizes.size28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Gaps.v96,
              const AuthButton(
                title: 'Continue with google',
                icon: FaIcon(
                  FontAwesomeIcons.google,
                  size: Sizes.size24,
                ),
              ),
              Gaps.v20,
              const AuthButton(
                title: 'Continue with Apple',
                icon: FaIcon(
                  FontAwesomeIcons.apple,
                  size: Sizes.size32,
                ),
              ),
              Gaps.v24,
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  Gaps.h10,
                  Text(
                    'or',
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Gaps.h10,
                  Expanded(
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ],
              ),
              Gaps.v10,
              const AuthButton(
                title: 'Create Account',
                boxColor: Colors.black,
                textColor: Colors.white,
              ),
              Gaps.v32,
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    'By signing Up, you agree out Terms,\nPrivay Policy, and Cookie Use'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size36,
          ),
          child: Row(
            children: [
              const Text('Have an account already?'),
              Gaps.h6,
              Text(
                'Log in',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
