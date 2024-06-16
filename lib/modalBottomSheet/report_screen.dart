import 'package:authentication/constants/gaps.dart';
import 'package:authentication/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Report',
          style: TextStyle(fontSize: Sizes.size20),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(Sizes.size5),
          child: Container(
            color: Colors.grey.shade400.withOpacity(0.5),
            height: 1,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(Sizes.size16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Why are you reporting this thread?',
                  style: TextStyle(
                    fontSize: Sizes.size16 + Sizes.size2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gaps.v10,
                Text(
                  "Your report is anonymous, except if you're reporting an intellectual property infringement. If someone is in immediate danger, call the local emergency services - don't wait.",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: Sizes.size14,
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.grey.shade400.withOpacity(0.5),
            height: 1,
          ),
          ListTile(
            title: const Text("I just don't like it"),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size16,
              color: Colors.grey.shade600,
            ),
          ),
          Divider(
            color: Colors.grey.shade400.withOpacity(0.5),
            height: 1,
          ),
          ListTile(
            title: const Text("It's unlawful content under NetzDG"),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size16,
              color: Colors.grey.shade600,
            ),
          ),
          Divider(
            color: Colors.grey.shade400.withOpacity(0.5),
            height: 1,
          ),
          ListTile(
            title: const Text("It's spam"),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size16,
              color: Colors.grey.shade600,
            ),
          ),
          Divider(
            color: Colors.grey.shade400.withOpacity(0.5),
            height: 1,
          ),
          ListTile(
            title: const Text("Hate speech or symbols"),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size16,
              color: Colors.grey.shade600,
            ),
          ),
          Divider(
            color: Colors.grey.shade400.withOpacity(0.5),
            height: 1,
          ),
          ListTile(
            title: const Text("Nudity or sexual activity"),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size16,
              color: Colors.grey.shade600,
            ),
          ),
          Divider(
            color: Colors.grey.shade400.withOpacity(0.5),
            height: 1,
          ),
          ListTile(
            title: const Text("Else"),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size16,
              color: Colors.grey.shade600,
            ),
          ),
          Divider(
            color: Colors.grey.shade400.withOpacity(0.5),
            height: 1,
          ),
        ],
      ),
    );
  }
}
