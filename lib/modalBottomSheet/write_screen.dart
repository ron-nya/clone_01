import 'dart:io';
import 'dart:ui';
import 'package:authentication/camera/camera_screen.dart';
import 'package:authentication/constants/gaps.dart';
import 'package:authentication/constants/sizes.dart';
import 'package:authentication/model/article_model.dart';
import 'package:authentication/model/user_info_model.dart';
import 'package:authentication/navigationbar/view_models/article_upload_model.dart';
import 'package:authentication/navigationbar/view_models/article_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class WriteScreen extends ConsumerStatefulWidget {
  const WriteScreen({super.key});

  @override
  ConsumerState<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends ConsumerState<WriteScreen> {
  final _editController = TextEditingController();

  XFile? _image;

  void _setImage(XFile image) {
    setState(() {
      _image = image;
    });
  }

  final _writer = UserInfoModel(
    id: '10',
    name: 'jane_mobbin',
    profileImageUrl: 'https://loremflickr.com/320/240',
    authentication: false,
    followerCount: 1000,
  );

  bool _isWriting = false;

  void _checkText() {
    setState(() {
      _isWriting = _editController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _editController.addListener(_checkText);
  }

  @override
  void dispose() {
    _editController.removeListener(_checkText);
    _editController.dispose();
    super.dispose();
  }

  void _onTapScaffold() {
    FocusScope.of(context).unfocus();
  }

  void _onPressPaperClip() async {
    var image = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const CameraScreen(),
    ));
    if (image != null) {
      _setImage(image);
    }
  }

  void _onTapPost(BuildContext context, WidgetRef ref) {
    ArticleModel article = ArticleModel(
      id: 'Anomynous',
      registDttm: DateTime.now(),
      writerId: 'Anomynous',
      replyCnt: 0,
      likeCnt: 0,
      replyeIds: [],
      articleCntn: _editController.text,
      imageUrls: [],
    );
    ref
        .read(articleUploadProvider.notifier)
        .uploadArticle(context, _image, article);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTapScaffold,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'New Thread',
            style: TextStyle(fontSize: Sizes.size20),
          ),
          leading: TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // 뒤로가기 동작
            },
            child: const Text(
              'Cancel',
              softWrap: false,
              overflow: TextOverflow.visible,
              style: TextStyle(
                  color: Colors.black, fontSize: Sizes.size16), // 텍스트 스타일 설정
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(Sizes.size5),
            child: Container(
              color: Colors.grey.shade400.withOpacity(0.5),
              height: 1,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(Sizes.size16),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5 +
                  MediaQuery.of(context).viewInsets.bottom,
              child: Stack(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
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
                              Gaps.v5,
                              Container(
                                height: Sizes.size96,
                                width: Sizes.size1,
                                color: Colors.grey.shade400,
                              ),
                              Gaps.v5,
                              ClipOval(
                                child: ImageFiltered(
                                  imageFilter: ImageFilter.blur(
                                      sigmaX: 1.0, sigmaY: 1.0),
                                  child: CachedNetworkImage(
                                    imageUrl: _writer.profileImageUrl,
                                    width: 30,
                                    height: 30,
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
                        ],
                      ),
                      Gaps.h10,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _writer.name,
                            style: const TextStyle(
                              fontSize: Sizes.size16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 300,
                            child: TextField(
                              controller: _editController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Start a thread ...',
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: _onPressPaperClip,
                            icon: FaIcon(
                              FontAwesomeIcons.paperclip,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          if (_image != null)
                            Image.file(
                              File(_image!.path),
                              width: 200,
                              height: 200,
                            ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).viewInsets.bottom == 0
                        ? MediaQuery.of(context).size.height * 0.15
                        : MediaQuery.of(context).viewInsets.bottom + 100,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Anyone can reply',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        _isWriting
                            ? GestureDetector(
                                onTap: () => _onTapPost(context, ref),
                                child: Text(
                                  'Post',
                                  style: TextStyle(
                                    fontSize: Sizes.size16,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
