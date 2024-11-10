abstract class PostsEvent {}

class PostsLoadStartedEvent extends PostsEvent {
  final int userId;

  PostsLoadStartedEvent({required this.userId});
}
