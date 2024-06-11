import 'package:authentication/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TwitterAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const TwitterAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: FaIcon(
        FontAwesomeIcons.twitter,
        color: Theme.of(context).primaryColor,
        size: Sizes.size36,
      ),
    );
  }
}
