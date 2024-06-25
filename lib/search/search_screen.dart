import 'dart:convert';

import 'package:authentication/constants/gaps.dart';
import 'package:authentication/constants/sizes.dart';
import 'package:authentication/model/user_info_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<UserInfoModel> _users;

  Future<void> loadJsonData() async {
    _users = [];
    final String response =
        await rootBundle.loadString('assets/data/user.json');
    setState(() {
      var userJson = jsonDecode(response);
      for (var uj in userJson) {
        _users.add(UserInfoModel.fromJson(uj));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0), // HomeTab의 AppBar 높이 설정
        child: AppBar(
          toolbarHeight: 120,
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Gaps.v16,
              const CupertinoSearchTextField(),
              Gaps.v16,
            ],
          ),
        ),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(left: Sizes.size80),
          child: Divider(
            color: Colors.grey.shade300,
          ),
        ),
        itemCount: _users.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: ClipOval(
              child: CachedNetworkImage(
                imageUrl: _users[index].profileImageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            title: Row(
              children: [
                Text(
                  _users[index].name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gaps.h10,
                if (_users[index].authentication)
                  FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    size: Sizes.size16,
                    color: Theme.of(context).primaryColor,
                  ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _users[index].name,
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gaps.v5,
                Text(
                  "${_users[index].followerCount / 1000}K follwers",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            trailing: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.grey, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Follow'),
            ),
          );
        },
      ),
    );
  }
}
