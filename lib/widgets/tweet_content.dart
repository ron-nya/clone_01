import 'package:authentication/constants/gaps.dart';
import 'package:authentication/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TweetContent extends StatelessWidget {
  final int tweetId;
  final int? retweetId, replyId;

  const TweetContent({
    super.key,
    this.retweetId,
    this.replyId,
    required this.tweetId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                        radius: Sizes.size20, // 아바타의 크기 설정
                        backgroundImage: (replyId != null)
                            ? const NetworkImage(
                                'https://picsum.photos/id/14/320/240')
                            : const NetworkImage(
                                'https://picsum.photos/id/16/320/240')),
                    if (replyId != null)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              VerticalDivider(
                                thickness: 2,
                                color: Colors.grey.shade300,
                              )
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                Gaps.h20,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            (replyId != null) ? 'john_mobbin' : 'jane_mobbin',
                            style: const TextStyle(
                                fontSize: Sizes.size16,
                                fontWeight: FontWeight.w700),
                          ),
                          const Row(
                            children: [
                              Text('5h'),
                              Gaps.h10,
                              FaIcon(FontAwesomeIcons.ellipsis),
                            ],
                          ),
                        ],
                      ),
                      (retweetId == null)
                          ? Text(
                              softWrap: true,
                              (replyId != null)
                                  ? 'Give @john_mobbin a follow if you want to see more travel content!'
                                  : 'See you later!')
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(softWrap: true, 'Tea. Spillage.'),
                                Gaps.v10,
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(Sizes.size8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const CircleAvatar(
                                              radius: Sizes.size10,
                                              backgroundImage: NetworkImage(
                                                  'https://picsum.photos/id/15/320/240'),
                                            ),
                                            Gaps.h5,
                                            const Text(
                                              'iwetmyyplants',
                                              style: TextStyle(
                                                fontSize: Sizes.size14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Gaps.h5,
                                            FaIcon(
                                              FontAwesomeIcons.solidCircleCheck,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: Sizes.size16,
                                            ),
                                          ],
                                        ),
                                        Gaps.v5,
                                        const Text(
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          "I'm just going to say what we are all thinking and knowing is about to go downity down: There is about to be some piping hot tea spillage on here daily that people will be There is about to be some piping hot tea spillage on here daily that people will be",
                                        ),
                                        Gaps.v5,
                                        (tweetId % 3 == 0)
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        16.0), // 둥근 모서리 설정
                                                child: Image.network(
                                                  'https://picsum.photos/id/16/320/240',
                                                  width: 280,
                                                  height: 250,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : Container(),
                                        Gaps.v10,
                                        const Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            '295 replies',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
                      Gaps.v10,
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        if (replyId != null) ...[
          Row(
            children: [
              VerticalDivider(
                thickness: 2,
                color: Colors.grey.shade300,
              )
            ],
          ),
          const TweetContent(tweetId: 10),
          Divider(
            color: Colors.grey.shade200,
          )
        ],
      ],
    );
  }
}
