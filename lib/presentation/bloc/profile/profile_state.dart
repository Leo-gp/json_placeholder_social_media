import 'package:json_placeholder_social_media/domain/entities/post.dart';

abstract class ProfileState {}

class ProfilePostsLoadingState extends ProfileState {}

class ProfilePostsLoadFailState extends ProfileState {}

class ProfilePostsLoadedState extends ProfileState {
  final List<Post> posts;

  ProfilePostsLoadedState({required this.posts});
}
