import 'package:json_placeholder_social_media/domain/entities/comment.dart';

class CommentsState {
  final Map<int, PostCommentsState> postsCommentsStates;

  CommentsState({required this.postsCommentsStates});

  PostCommentsState getCommentsStateFromPost(int postId) {
    return postsCommentsStates[postId]!;
  }
}

class PostCommentsState {
  final List<Comment> comments;
  final bool isUnloaded;
  final bool isLoading;
  final String? error;

  PostCommentsState({
    required this.comments,
    required this.isUnloaded,
    required this.isLoading,
    required this.error,
  });

  factory PostCommentsState.unloaded() {
    return PostCommentsState(
      comments: [],
      isUnloaded: true,
      isLoading: false,
      error: null,
    );
  }

  PostCommentsState setLoading() {
    return PostCommentsState(
      comments: [],
      isUnloaded: false,
      isLoading: true,
      error: null,
    );
  }

  PostCommentsState setLoaded({required List<Comment> comments}) {
    return PostCommentsState(
      comments: comments,
      isUnloaded: false,
      isLoading: false,
      error: null,
    );
  }

  PostCommentsState setError({required String error}) {
    return PostCommentsState(
      comments: [],
      isUnloaded: false,
      isLoading: false,
      error: error,
    );
  }
}
