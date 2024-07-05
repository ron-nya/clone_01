import 'dart:async';

import 'package:authentication/model/article_model.dart';
import 'package:authentication/navigationbar/repos/article_repository.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArticleUploadModel extends AsyncNotifier<void> {
  late final ArticleRepository _articleRepository;
  final String userId = "Anonymous";
  @override
  FutureOr<void> build() async {
    _articleRepository = ref.read(articleRepo);
  }

  Future<void> uploadArticle(
      BuildContext context, XFile? image, ArticleModel article) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (image != null) {
        final task = await _articleRepository.uploadImage(image, userId);

        if (task.metadata != null) {
          await task.ref.getDownloadURL().then((url) => {
                article.imageUrls.add(url),
              });
        }
      }
      await _articleRepository.saveArticle(article);
    });
  }
}

final articleUploadProvider = AsyncNotifierProvider<ArticleUploadModel, void>(
  () => ArticleUploadModel(),
);
