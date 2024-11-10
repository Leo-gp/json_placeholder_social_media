import 'package:json_placeholder_social_media/domain/entities/post.dart';

abstract class PostsState {}

class PostsLoadingState extends PostsState {}

class PostsLoadFailState extends PostsState {}

class PostsLoadedState extends PostsState {
  final List<Post> posts;

  PostsLoadedState({
    required this.posts,
  });
}
