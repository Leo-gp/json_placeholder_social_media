import 'package:json_placeholder_social_media/domain/entities/comment.dart';

class CommentModel extends Comment {
  CommentModel({
    required super.postId,
    required super.id,
    required super.name,
    required super.body,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      postId: json["postId"],
      id: json["id"],
      name: json["name"],
      body: json["body"],
    );
  }
}
