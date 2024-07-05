import 'dart:io';

import 'package:authentication/model/article_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_file/cross_file.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArticleRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _stroage = FirebaseStorage.instance;

  Future<void> createArticle(ArticleModel am) async {}

  UploadTask uploadImage(XFile image, String userId) {
    final fileRef = _stroage.ref().child(
        '/image/$userId/${DateTime.now().microsecondsSinceEpoch.toString()}');
    return fileRef.putFile(File(image.path));
  }

  Future<void> saveArticle(ArticleModel data) async {
    print('save');
    await _db.collection("article").add(data.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchArticles() {
    return _db
        .collection("article")
        .orderBy("registDttm", descending: true)
        .get();
  }
}

final articleRepo = Provider(
  (ref) => ArticleRepository(),
);
