class ArticleModel {
  final int id;
  final DateTime registDttm;
  final int writerId;
  final int replyCnt;
  final int likeCnt;
  final List<int> replyeIds;
  final String articleCntn;
  final List<String> imageUrls;

  ArticleModel({
    required this.id,
    required this.registDttm,
    required this.writerId,
    required this.replyCnt,
    required this.likeCnt,
    required this.replyeIds,
    required this.articleCntn,
    required this.imageUrls,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      registDttm: DateTime.parse(json['registDttm']),
      writerId: json['writerId'],
      replyCnt: json['replyCnt'],
      likeCnt: json['likeCnt'],
      replyeIds: List<int>.from(json['replyeIds']),
      articleCntn: json['articleCntn'],
      imageUrls: List<String>.from(
          (json['imageUrls'] == null) ? [] : json['imageUrls']),
    );
  }
}
