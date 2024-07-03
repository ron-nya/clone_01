import 'package:authentication/constants/gaps.dart';
import 'package:authentication/constants/sizes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PrivacyScreen extends StatefulWidget {
  static String routerUrl = "privacy";
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool _isActivatedPrivateProfile = false;

  @override
  void initState() {
    super.initState();
    _isActivatedPrivateProfile = false;
  }

  void _onChangedSwitch(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _isActivatedPrivateProfile = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                SwitchListTile.adaptive(
                  value: _isActivatedPrivateProfile,
                  onChanged: _onChangedSwitch,
                  secondary: const FaIcon(FontAwesomeIcons.lock),
                  title: const Text('Private profile'),
                ),
                const ListTile(
                  leading: FaIcon(FontAwesomeIcons.at),
                  title: Text('Mentions'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Everyone',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: Sizes.size16,
                        ),
                      ),
                      Gaps.h5,
                      FaIcon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                const ListTile(
                  leading: FaIcon(FontAwesomeIcons.bellSlash),
                  title: Text('Muted'),
                  trailing: FaIcon(
                    FontAwesomeIcons.chevronRight,
                    color: Colors.grey,
                  ),
                ),
                const ListTile(
                  leading: FaIcon(FontAwesomeIcons.eyeSlash),
                  title: Text('Hidden words'),
                  trailing: FaIcon(
                    FontAwesomeIcons.chevronRight,
                    color: Colors.grey,
                  ),
                ),
                const ListTile(
                  leading: FaIcon(FontAwesomeIcons.users),
                  title: Text('Profiles you follow'),
                  trailing: FaIcon(
                    FontAwesomeIcons.chevronRight,
                    color: Colors.grey,
                  ),
                ),
                Divider(
                  color: Colors.grey.shade300,
                ),
                const ListTile(
                  title: Text(
                    'Other Privacy Settings',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    'Some settings, like restrict, apply to both Threads and Instagram and can be managed on Instagram.',
                  ),
                  trailing: FaIcon(
                    FontAwesomeIcons.arrowUpRightFromSquare,
                    color: Colors.grey,
                  ),
                ),
                const ListTile(
                  leading: FaIcon(FontAwesomeIcons.circleXmark),
                  title: Text(
                    'Blocked profiles',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: FaIcon(
                    FontAwesomeIcons.arrowUpRightFromSquare,
                    color: Colors.grey,
                  ),
                ),
                const ListTile(
                  leading: FaIcon(FontAwesomeIcons.heartCrack),
                  title: Text(
                    'Hide likes',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: FaIcon(
                    FontAwesomeIcons.arrowUpRightFromSquare,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
