import 'dart:convert';
import 'package:authentication/model/article_model.dart';
import 'package:authentication/navigationbar/article_screen.dart';
import 'package:authentication/navigationbar/view_models/article_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static String routerUrl = "/article";
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<ArticleModel> _articles = [];

  Future<void> loadJsonData() async {
    _articles = [];
    final String response =
        await rootBundle.loadString('assets/data/article.json');
    setState(() {
      var articlesJson = jsonDecode(response);
      for (var aj in articlesJson) {
        _articles.add(ArticleModel.fromJson(aj));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(articleProvider).when(
          data: (articles) {
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return ArticleScreen(
                  article: articles[index],
                );
              },
            );
          },
          error: (error, StackTrace) => Center(
            child: Text('Cound not load Article: $error'),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
  }
}
