import 'dart:convert';

import 'package:json_placeholder_social_media/data/data_sources/api_constants.dart';
import 'package:json_placeholder_social_media/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserDataSource {
  final Uri uri = Uri.https(ApiConstants.baseUrl, ApiConstants.usersPath);

  Future<List<UserModel>> getUsers() async {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> users = jsonDecode(response.body);
      return users.map((user) => UserModel.fromJson(user)).toList();
    }
    throw Exception("Failed to load users.");
  }
}
