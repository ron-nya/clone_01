import 'dart:convert';

import 'package:authentication/constants/gaps.dart';
import 'package:authentication/constants/sizes.dart';
import 'package:authentication/model/user_info_model.dart';
import 'package:authentication/profile/view_models/user_search_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchScreen extends ConsumerStatefulWidget {
  static String routerUrl = "/search";

  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late List<UserInfoModel> _users;
  final TextEditingController _controller = TextEditingController();
  late String _searchText;

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

  void onChanged() {
    setState(() {
      _searchText = _controller.text;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(onChanged);
    _controller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _searchText = _controller.text;
    _controller.addListener(onChanged);
    //loadJsonData();
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
              CupertinoSearchTextField(
                controller: _controller,
              ),
              Gaps.v16,
            ],
          ),
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return ref.watch(userSearchProvider(_searchText)).when(
                data: (data) => ListView.separated(
                  separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(left: Sizes.size80),
                    child: Divider(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: data[index].profileImageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      title: Row(
                        children: [
                          Text(
                            data[index].id,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Gaps.h10,
                          if (data[index].authentication)
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
                            data[index].name,
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Gaps.v5,
                          Text(
                            "${data[index].followerCount / 1000}K follwers",
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
                error: (error, stackTrace) => Center(
                  child: Text(error.toString()),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
        },
      ),
    );
  }
}
