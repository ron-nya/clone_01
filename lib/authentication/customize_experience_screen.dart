import 'package:authentication/authentication/create_account_screen.dart';
import 'package:authentication/constants/gaps.dart';
import 'package:authentication/constants/sizes.dart';
import 'package:authentication/model/user_model.dart';
import 'package:authentication/widgets/auth_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomizeExperienceScreen extends StatefulWidget {
  final UserModel? user;
  const CustomizeExperienceScreen(this.user, {super.key});

  @override
  State<CustomizeExperienceScreen> createState() =>
      _CustomizeExperienceScreenState();
}

class _CustomizeExperienceScreenState extends State<CustomizeExperienceScreen> {
  bool _hasSwitched = false;

  void _onSwitchChanged(bool value) {
    setState(() {
      _hasSwitched = value;
    });
  }

  void _onSubmitNext(BuildContext context) {
    UserModel userInfo = widget.user!;
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CreateAccountScreen(userInfo),
    ));
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v96,
              const Text(
                'Customize\nYour Experience',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: Sizes.size28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Gaps.v24,
              const Text(
                'Track where you see Twitter\ncontent accros the web',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Gaps.v24,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    flex: 4,
                    child: Text(
                      'Twitter uses this data to personalize your experience. This web browsing hisotry will never be stored with your name, email, or phone number.',
                      textAlign: TextAlign.left,
                      maxLines: 5,
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Transform.scale(
                      scale: 1.2,
                      child: CupertinoSwitch(
                        activeColor: Colors.green.shade500,
                        value: _hasSwitched,
                        onChanged: _onSwitchChanged,
                      ),
                    ),
                  ),
                ],
              ),
              Gaps.v36,
              const Text(
                'By Siginng up, you agree to our Terms, Praivacy Policy, and Cookie Use. Twitter may user your contact information, including your email address and phone number for purposes outlined in our Privacy Policy. Learn more',
                textAlign: TextAlign.left,
                maxLines: 5,
                style: TextStyle(
                  fontSize: Sizes.size14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
          child: GestureDetector(
            onTap: _hasSwitched ? () => _onSubmitNext(context) : null,
            child: AuthButton(
              title: 'Next',
              boxColor: _hasSwitched ? Colors.black : Colors.grey,
              textColor: _hasSwitched ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
