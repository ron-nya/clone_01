import 'dart:convert';

import 'package:authentication/constants/sizes.dart';
import 'package:authentication/model/article_model.dart';
import 'package:authentication/navigationbar/article_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<ArticleModel> _articles;

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
    loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _articles.length,
      itemBuilder: (context, index) {
        return ArticleScreen(
          article: _articles[index],
        );
      },
    );
  }
}
