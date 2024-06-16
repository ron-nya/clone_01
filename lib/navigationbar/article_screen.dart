import 'dart:convert';

import 'package:authentication/constants/gaps.dart';
import 'package:authentication/constants/sizes.dart';
import 'package:authentication/modalBottomSheet/bottom_sheet_option.dart';
import 'package:authentication/model/article_model.dart';
import 'package:authentication/model/user_info_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ArticleScreen extends StatefulWidget {
  final ArticleModel article;

  const ArticleScreen({super.key, required this.article});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late List<UserInfoModel> _replyers;
  late UserInfoModel _writer;

  Future<void> loadJsonData() async {
    _replyers = [];
    _writer = UserInfoModel(
        id: 0,
        name: '',
        profileImageUrl: 'https://loremflickr.com/320/240',
        authentication: false);

    var writerId = widget.article.writerId;
    var replyeIds = widget.article.replyeIds;
    final String response =
        await rootBundle.loadString('assets/data/user.json');
    setState(() {
      var userJson = jsonDecode(response);
      for (var uj in userJson) {
        if (uj['id'] == writerId) {
          _writer = UserInfoModel.fromJson(uj);
        }
        for (var replyId in replyeIds) {
          if (uj['id'] == replyId) {
            _replyers.add(UserInfoModel.fromJson(uj));
          }
        }
      }
    });
  }

  void _onTapOptions(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: const BottomSheetOption()),
    );
  }

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  String _getHoursMinuteDiffrentFromNow(DateTime dateTime) {
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(dateTime);
    final int minutesDifference = difference.inMinutes;

    return '${(minutesDifference ~/ 60)} h ${minutesDifference % 60} m';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: Sizes.size20,
        left: Sizes.size20,
        bottom: Sizes.size14,
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: _writer.profileImageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      const Positioned(
                        bottom: -Sizes.size7,
                        right: -Sizes.size7,
                        child: FaIcon(
                          FontAwesomeIcons.solidCircle,
                          color: Colors.white,
                          size: Sizes.size32,
                        ),
                      ),
                      const Positioned(
                        bottom: -Sizes.size5,
                        right: -Sizes.size5,
                        child: FaIcon(
                          FontAwesomeIcons.circlePlus,
                          color: Colors.black,
                          size: Sizes.size28,
                        ),
                      ),
                    ],
                  ),
                ),
                if (_replyers.isNotEmpty)
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 5,
                          left: 5,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: _replyers[0].profileImageUrl,
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        if (_replyers.length >= 2)
                          Positioned(
                            bottom: Sizes.size5,
                            right: Sizes.size5,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: _replyers[1].profileImageUrl,
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                        if (_replyers.length == 3)
                          Positioned(
                            right: 15,
                            top: 5,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: _replyers[2].profileImageUrl,
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
            Gaps.h14,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            _writer.name.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: Sizes.size16,
                            ),
                          ),
                          Gaps.h5,
                          if (_writer.authentication)
                            FaIcon(
                              FontAwesomeIcons.solidCircleCheck,
                              size: Sizes.size16,
                              color: Theme.of(context).primaryColor,
                            ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            _getHoursMinuteDiffrentFromNow(
                                widget.article.registDttm),
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.5)),
                          ),
                          Gaps.h10,
                          GestureDetector(
                            onTap: () => _onTapOptions(context),
                            child: const FaIcon(
                              FontAwesomeIcons.ellipsis,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    widget.article.articleCntn,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (widget.article.imageUrls.isNotEmpty)
                    SizedBox(
                      height: 320,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.article.imageUrls.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              right: Sizes.size12,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(Sizes.size16),
                              child: CachedNetworkImage(
                                imageUrl: widget.article.imageUrls[index],
                                width: 340,
                                height: 300,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  Gaps.v14,
                  const Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.heart,
                        color: Colors.black,
                        size: Sizes.size20,
                      ),
                      Gaps.h10,
                      FaIcon(
                        FontAwesomeIcons.comment,
                        color: Colors.black,
                        size: Sizes.size20,
                      ),
                      Gaps.h10,
                      FaIcon(
                        FontAwesomeIcons.retweet,
                        color: Colors.black,
                        size: Sizes.size20,
                      ),
                      Gaps.h10,
                      FaIcon(
                        FontAwesomeIcons.paperPlane,
                        color: Colors.black,
                        size: Sizes.size20,
                      ),
                      Gaps.h10,
                    ],
                  ),
                  Gaps.v14,
                  Text(
                    "${widget.article.replyCnt} replies • ${widget.article.likeCnt} likes",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: Sizes.size16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
