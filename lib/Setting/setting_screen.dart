import 'dart:io';

import 'package:authentication/Setting/privacy_screen.dart';
import 'package:authentication/authentication/repos/authentiaction_repository.dart';
import 'package:authentication/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class SettingScreen extends ConsumerWidget {
  static String routerUrl = "/setting";
  const SettingScreen({super.key});

  void _onTapLogOutIos(BuildContext context, WidgetRef ref) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('IOS Log out'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            isDefaultAction: true,
            child: const Text("No"),
          ),
          CupertinoDialogAction(
            onPressed: () {
              ref.read(authRepo).signOut();
              context.go("/");
            },
            isDestructiveAction: true,
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  void _onTapLogOutAndroid(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Android Log out'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  void _onTapPrivacy(BuildContext context) {
    context.push("${SettingScreen.routerUrl}/${PrivacyScreen.routerUrl}");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Setting',
            style: TextStyle(fontSize: Sizes.size20),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: Colors.grey.shade300,
              height: 1,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.size10),
            child: Column(
              children: [
                const ListTile(
                  leading: FaIcon(FontAwesomeIcons.userPlus),
                  title: Text('Follow and invite friends'),
                ),
                const ListTile(
                  leading: FaIcon(FontAwesomeIcons.bell),
                  title: Text('Notifications'),
                ),
                ListTile(
                  onTap: () => _onTapPrivacy(context),
                  leading: const FaIcon(FontAwesomeIcons.lock),
                  title: const Text('Privacy'),
                ),
                const ListTile(
                  leading: FaIcon(FontAwesomeIcons.circleUser),
                  title: Text('Account'),
                ),
                const ListTile(
                  leading: FaIcon(FontAwesomeIcons.lifeRing),
                  title: Text('Help'),
                ),
                const ListTile(
                  leading: FaIcon(FontAwesomeIcons.circleInfo),
                  title: Text('About'),
                ),
                Divider(
                  color: Colors.grey.shade300,
                ),
                ListTile(
                  title: const Text('Log out'),
                  textColor: Theme.of(context).primaryColor,
                  onTap: () => (Platform.isIOS)
                      ? _onTapLogOutIos(context, ref)
                      : _onTapLogOutAndroid(context),
                ),
              ],
            ),
          ),
        ));
  }
}
