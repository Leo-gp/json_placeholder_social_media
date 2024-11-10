abstract class CommentsEvent {}

class CommentsInitiatedEvent extends CommentsEvent {
  final List<int> postsIds;

  CommentsInitiatedEvent({required this.postsIds});
}

class CommentsLoadStartedEvent extends CommentsEvent {
  final int postId;

  CommentsLoadStartedEvent({required this.postId});
}

class CommentsClosedEvent extends CommentsEvent {
  final int postId;

  CommentsClosedEvent({required this.postId});
}
