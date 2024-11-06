import 'package:json_placeholder_social_media/domain/entities/user.dart';

abstract class UsersState {}

class UsersLoadingState extends UsersState {}

class UsersLoadFailedState extends UsersState {}

class UsersLoadedState extends UsersState {
  final List<User> users;

  UsersLoadedState({required this.users});
}
