import 'dart:convert';

import 'package:json_placeholder_social_media/data/data_sources/api_constants.dart';
import 'package:json_placeholder_social_media/data/models/comment_model.dart';
import 'package:http/http.dart' as http;

class CommentDataSource {
  Future<List<CommentModel>> getCommentsByPostId(int postId) async {
    final Uri uri = Uri.https(
      ApiConstants.baseUrl,
      ApiConstants.commentsPath,
      {
        ApiConstants.postIdQueryParam: postId.toString(),
      },
    );
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> commentsJson = jsonDecode(response.body);
      return commentsJson
          .map((comment) => CommentModel.fromJson(comment))
          .toList();
    }
    throw Exception("Failed to load comments from post $postId.");
  }
}
