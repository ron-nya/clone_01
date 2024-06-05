import 'package:authentication/constants/gaps.dart';
import 'package:authentication/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthButton extends StatelessWidget {
  final String title;
  final FaIcon? icon;
  final Color? boxColor;
  final Color? textColor;

  const AuthButton({
    super.key,
    required this.title,
    this.icon,
    this.boxColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        height: Sizes.size44,
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size40,
        ),
        decoration: BoxDecoration(
          color: boxColor ?? Colors.white,
          border: Border.all(
            color: boxColor != null ? Colors.transparent : Colors.grey.shade400,
            width: Sizes.size1,
          ),
          borderRadius: BorderRadius.circular(Sizes.size20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? const Text(''),
            Gaps.h16,
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor ?? Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: Sizes.size16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
