import 'dart:async';

import 'package:authentication/model/article_model.dart';
import 'package:authentication/navigationbar/repos/article_repository.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArticleViewModel extends AsyncNotifier<List<ArticleModel>> {
  late final ArticleRepository _articleRepository;
  List<ArticleModel> _list = [];

  final String userId = 'Anomynous';

  Future<List<ArticleModel>> _fetchArticles() async {
    final result = await _articleRepository.fetchArticles();
    final articles = result.docs.map(
      (doc) => ArticleModel.fromJson(doc.data()),
    );
    return articles.toList();
  }

  @override
  FutureOr<List<ArticleModel>> build() async {
    _articleRepository = ref.read(articleRepo);
    _list = await _fetchArticles();
    return _list.toList();
  }
}

final articleProvider =
    AsyncNotifierProvider<ArticleViewModel, List<ArticleModel>>(
  () => ArticleViewModel(),
);
