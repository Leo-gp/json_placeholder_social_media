import 'dart:convert';

import 'package:json_placeholder_social_media/data/data_sources/api_constants.dart';
import 'package:json_placeholder_social_media/data/models/post_model.dart';
import 'package:http/http.dart' as http;

class PostDataSource {
  Future<List<PostModel>> getPostsByUserId(int userId) async {
    final Uri uri = Uri.https(
      ApiConstants.baseUrl,
      ApiConstants.postsPath,
      {
        ApiConstants.userIdQueryParam: userId.toString(),
      },
    );
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> postsJson = jsonDecode(response.body);
      return postsJson.map((post) => PostModel.fromJson(post)).toList();
    }
    throw Exception("Failed to load posts from user $userId.");
  }
}
