import 'package:authentication/authentication/customize_experience_screen.dart';
import 'package:authentication/authentication/view_models/signup_view_model.dart';
import 'package:authentication/constants/gaps.dart';
import 'package:authentication/constants/sizes.dart';
import 'package:authentication/model/user_model.dart';
import 'package:authentication/onbarding/conformation_code_screen.dart';
import 'package:authentication/widgets/auth_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  static String routerUrl = "/createAccount";
  final UserModel? user;
  const CreateAccountScreen(this.user, {super.key});

  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _birthFocusNode = FocusNode();

  bool _nextEnabled = false;
  bool _isLast = false;

  late UserModel userModel;

  @override
  void initState() {
    super.initState();
    _setTextFieldDate(DateTime.now());
    setState(() {
      if (widget.user != null) {
        _nameController.text = widget.user!.name;
        _emailController.text = widget.user!.email;
        _birthController.text = widget.user!.birthday;
        _isLast = true;
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _birthController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _birthFocusNode.dispose();
    super.dispose();
  }

  void _onChanged(String text) {
    setState(() {
      var name = _nameController.text;
      var email = _nameController.text;
      var birth = _emailController.text;

      if (name.isNotEmpty && email.isNotEmpty && birth.isNotEmpty) {
        _nextEnabled = true;
      } else {
        _nextEnabled = false;
      }
    });
  }

  void _onNameTap() {
    setState(() {
      _emailFocusNode.unfocus();
      _birthFocusNode.unfocus();
      FocusScope.of(context).requestFocus(_nameFocusNode);
    });
  }

  void _onEmailTap() {
    setState(() {
      _birthFocusNode.unfocus();
      _nameFocusNode.unfocus();
      FocusScope.of(context).requestFocus(_emailFocusNode);
    });
  }

  void _onBirthdayTap() {
    setState(() {
      _emailFocusNode.unfocus();
      _nameFocusNode.unfocus();
      FocusScope.of(context).requestFocus(_birthFocusNode);
    });
  }

  Widget? _getSolidCircleCheck(TextEditingController controller) {
    if (controller.text.isNotEmpty) {
      return const FaIcon(FontAwesomeIcons.solidCircleCheck,
          color: Colors.green);
    }
    return null;
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _birthController.value = TextEditingValue(text: textDate);
  }

  void _onTimeChanged(DateTime date) {
    setState(() {
      _birthController.text = date.toString().split(" ").first;
    });
  }

  void _onSubmitNext(BuildContext context) {
    if (_formKey.currentState == null) {
      return;
    } else if (_formKey.currentState!.validate()) {
      ref.read(signUpForm.notifier).state = {"email": _emailController.text};
      UserModel userInfo = UserModel(
          name: _nameController.text,
          email: _emailController.text,
          birthday: _birthController.text);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CustomizeExperienceScreen(userInfo),
      ));
    }
  }

  void _onTapSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ConformationCodeScreen(),
      ),
    );
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v24,
                Text(
                  'Create your account',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Gaps.v20,
                TextFormField(
                  readOnly: _isLast,
                  controller: _nameController,
                  onChanged: _onChanged,
                  focusNode: _nameFocusNode,
                  onTap: _onNameTap,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    suffix: _getSolidCircleCheck(_nameController),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "필수입니다.";
                    }
                    return null;
                  },
                ),
                Gaps.v20,
                TextFormField(
                  readOnly: _isLast,
                  controller: _emailController,
                  onChanged: _onChanged,
                  focusNode: _emailFocusNode,
                  onTap: _onEmailTap,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    suffix: _getSolidCircleCheck(_emailController),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "필수입니다.";
                    }
                    var emailRegexp =
                        RegExp('^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}\$');
                    if (!emailRegexp.hasMatch(value)) {
                      return "형식이 다릅니다.";
                    }
                    return null;
                  },
                ),
                Gaps.v20,
                TextFormField(
                  readOnly: _isLast,
                  controller: _birthController,
                  onChanged: _isLast ? null : _onChanged,
                  onTap: _isLast ? null : _onBirthdayTap,
                  focusNode: _birthFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Date of Bitrh',
                    suffix: _getSolidCircleCheck(_birthController),
                    helperText: _birthFocusNode.hasFocus
                        ? 'This will not be shown publicly Confirm your\nown age, even if this account is\nfor a bussiness a pet, or something else'
                        : null,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "필수입니다.";
                    }
                    return null;
                  },
                ),
                Gaps.v36,
                _isLast
                    ? Container()
                    : Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: _nextEnabled
                              ? () => _onSubmitNext(context)
                              : null,
                          child: Container(
                            alignment: Alignment.center,
                            width: Sizes.size64,
                            height: Sizes.size40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color:
                                    _nextEnabled ? Colors.black : Colors.grey),
                            child: const Text(
                              'Next',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Visibility(
        visible: _birthFocusNode.hasFocus || _isLast,
        child: _isLast
            ? BottomAppBar(
                height: Sizes.size96 + Sizes.size96 + Sizes.size24,
                child: GestureDetector(
                  onTap: _onTapSignUp,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Sizes.size24),
                    child: Column(
                      children: [
                        const Text(
                            'By Signing up, you agree to our Terms, Praivacy Policy, and Cookie Use. Twitter may user your contact information, including your email address and phone number for purposes outlined in our Privacy Policy. Learn more'),
                        Gaps.v20,
                        AuthButton(
                          title: 'Sign Up',
                          boxColor: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              )
            : SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: _onTimeChanged,
                ),
              ),
      ),
    );
  }
}
