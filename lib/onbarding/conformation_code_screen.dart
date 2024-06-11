import 'package:authentication/constants/gaps.dart';
import 'package:authentication/constants/sizes.dart';
import 'package:authentication/onbarding/password_screen.dart';
import 'package:authentication/widgets/auth_button.dart';
import 'package:authentication/widgets/twitter_appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConformationCodeScreen extends StatefulWidget {
  const ConformationCodeScreen({super.key});

  @override
  State<ConformationCodeScreen> createState() => _ConformationCodeScreenState();
}

class _ConformationCodeScreenState extends State<ConformationCodeScreen> {
  final int maxCodeLength = 6;
  late List<FocusNode> _focusNodeList;
  late List<TextEditingController> _textEditingControllerList;
  late List<String> _code;

  int _currentIdx = 0;
  bool _isCodeFiiled = false;

  @override
  void initState() {
    super.initState();
    _focusNodeList = [];
    _textEditingControllerList = [];
    _code = [];
    for (var i = 0; i < maxCodeLength; i++) {
      _focusNodeList.add(FocusNode());
      _textEditingControllerList.add(TextEditingController());
      _code.add('');
    }
  }

  @override
  void dispose() {
    for (var fn in _focusNodeList) {
      fn.dispose();
    }
    for (var te in _textEditingControllerList) {
      te.dispose();
    }
    super.dispose();
  }

  void _verifyCorfirmationCode() {
    for (var i = 0; i < maxCodeLength; i++) {
      if (_textEditingControllerList[i].text.isEmpty) {
        _isCodeFiiled = false;
        return;
      }
    }
    _isCodeFiiled = true;
  }

  void _onTapConfirmationCode(int idx) {
    setState(() {
      _currentIdx = idx;
      FocusScope.of(context).requestFocus(_focusNodeList[idx]);
      _textEditingControllerList[idx].text = '';
    });
  }

  void _onChangeConfirmationCode(String text) {
    setState(() {
      _code[_currentIdx] = text;
      _verifyCorfirmationCode();
      if (text.isNotEmpty) {
        if (_currentIdx < _textEditingControllerList.length - 1) {
          _textEditingControllerList[_currentIdx + 1].text = '';
          FocusScope.of(context).requestFocus(_focusNodeList[_currentIdx + 1]);
          _currentIdx++;
        }
      }
    });
  }

  void _onTapNext() {
    if (!_isCodeFiiled) return;
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const PasswordScreen(),
    ));
  }

  void _onTapScaffold() {
    FocusScope.of(context).unfocus();
  }

  Widget _buildInputItem(int idx) {
    return TextField(
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      maxLines: 1,
      maxLength: 1,
      focusNode: _focusNodeList[idx],
      controller: _textEditingControllerList[idx],
      style: const TextStyle(
        fontSize: Sizes.size24,
      ),
      decoration: const InputDecoration(
        counterText: "",
      ),
      onTap: () => _onTapConfirmationCode(idx),
      onChanged: _onChangeConfirmationCode,
    );
  }

  List<Widget> _buildConfirmationCodeList() {
    List<Widget> confirmaitonCodeList = [];
    for (var i = 0; i < maxCodeLength; i++) {
      confirmaitonCodeList.add(
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: Sizes.size12),
            child: _buildInputItem(i),
          ),
        ),
      );
    }
    return confirmaitonCodeList;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTapScaffold,
      child: Scaffold(
        appBar: const TwitterAppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.size36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v16,
                const Text(
                  'We sent you a code',
                  style: TextStyle(
                    fontSize: Sizes.size28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Gaps.v14,
                Text(
                  'Enter it below to verify\nhugu.mobbin@gmail.com.',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: Sizes.size16,
                  ),
                ),
                Gaps.v14,
                Row(
                  children: _buildConfirmationCodeList(),
                ),
                Gaps.v24,
                _isCodeFiiled
                    ? const Align(
                        alignment: Alignment.center,
                        child: FaIcon(
                          FontAwesomeIcons.solidCircleCheck,
                          color: Colors.green,
                        ),
                      )
                    : Container(child: null),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: Sizes.size96 + Sizes.size48,
          child: GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
              child: Column(
                children: [
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Did\'t receive email?')),
                  Gaps.v10,
                  GestureDetector(
                    onTap: _onTapNext,
                    child: AuthButton(
                      title: 'Next',
                      boxColor: _isCodeFiiled ? Colors.black : Colors.grey,
                      textColor: Colors.white,
                    ),
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
