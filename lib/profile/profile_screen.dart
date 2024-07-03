import 'package:authentication/Setting/setting_screen.dart';
import 'package:authentication/constants/gaps.dart';
import 'package:authentication/constants/sizes.dart';
import 'package:authentication/widgets/persistent_tabbar.dart';
import 'package:authentication/widgets/tweet_content.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  static String routerUrl = "/profile";
  const ProfileScreen({super.key});

  void _onTapSetting(BuildContext context) {
    context.push(SettingScreen.routerUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  leading: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Sizes.size16),
                    child: IconButton(
                        onPressed: () {},
                        icon: const FaIcon(FontAwesomeIcons.globe)),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const FaIcon(FontAwesomeIcons.instagram),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: Sizes.size3,
                        right: Sizes.size16,
                      ),
                      child: IconButton(
                        onPressed: () => _onTapSetting(context),
                        icon: const FaIcon(FontAwesomeIcons.barsStaggered),
                      ),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(Sizes.size16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Jane',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge),
                                    Row(
                                      children: [
                                        const Text(
                                          'jane_mobbin',
                                          style: TextStyle(
                                            fontSize: Sizes.size16,
                                          ),
                                        ),
                                        Gaps.h5,
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.grey,
                                            backgroundColor:
                                                Colors.grey.shade200, // 배경 색상
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 8.0),
                                            textStyle:
                                                const TextStyle(fontSize: 12),
                                          ),
                                          onPressed: () {},
                                          child: const Text('threads.net'),
                                        ),
                                      ],
                                    ),
                                    Gaps.v6,
                                    const Text(
                                      'Plant enthusiast!',
                                      style: TextStyle(
                                        fontSize: Sizes.size16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const CircleAvatar(
                                  radius: Sizes.size32, // 아바타의 크기 설정
                                  backgroundImage: NetworkImage(
                                      'https://picsum.photos/id/13/320/240'),
                                ),
                              ],
                            ),
                            Gaps.v12,
                            Row(
                              children: [
                                const SizedBox(
                                  width: Sizes.size36,
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: Sizes.size12, // 아바타의 크기 설정
                                        backgroundImage: NetworkImage(
                                            'https://picsum.photos/id/13/320/240'),
                                      ),
                                      Positioned(
                                        left: Sizes.size12,
                                        child: CircleAvatar(
                                          radius: Sizes.size12, // 아바타의 크기 설정
                                          backgroundImage: NetworkImage(
                                              'https://picsum.photos/id/14/320/240'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Gaps.h5,
                                Text(
                                  '2 follwers',
                                  style: TextStyle(
                                    fontSize: Sizes.size16,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                            Gaps.v16,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: Colors.white,
                                    side:
                                        BorderSide(color: Colors.grey.shade400),
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width /
                                                8,
                                        vertical: 8.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'Share profile',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: Colors.white,
                                    side:
                                        BorderSide(color: Colors.grey.shade400),
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width /
                                                8,
                                        vertical: 8.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'Share profile',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Gaps.v10,
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  delegate: PersistentTabbar(),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              children: [
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return TweetContent(
                      tweetId: index,
                      retweetId: (index % 2 == 1) ? 1 : null,
                    );
                  },
                ),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return TweetContent(
                      tweetId: index,
                      retweetId: (index % 2 == 1) ? 1 : null,
                      replyId: 1,
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
