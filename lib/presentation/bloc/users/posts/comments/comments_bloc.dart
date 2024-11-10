import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_placeholder_social_media/domain/usecases/get_post_comments_use_case.dart';
import 'package:json_placeholder_social_media/presentation/bloc/users/posts/comments/comments_event.dart';
import 'package:json_placeholder_social_media/presentation/bloc/users/posts/comments/comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final GetPostCommentsUseCase _getPostCommentsUseCase;

  CommentsBloc({required GetPostCommentsUseCase getPostCommentsUseCase})
      : _getPostCommentsUseCase = getPostCommentsUseCase,
        super(CommentsState(postsCommentsStates: {})) {
    on<CommentsInitiatedEvent>(_onCommentsInitiatedEvent);
    on<CommentsLoadStartedEvent>(_onCommentsLoadStartedEvent);
    on<CommentsClosedEvent>(_onCommentsClosedEvent);
  }

  void _onCommentsInitiatedEvent(
    CommentsInitiatedEvent event,
    Emitter<CommentsState> emit,
  ) {
    emit(CommentsState(
      postsCommentsStates: {
        for (final postId in event.postsIds)
          postId: PostCommentsState.unloaded()
      },
    ));
  }

  void _onCommentsLoadStartedEvent(
    CommentsLoadStartedEvent event,
    Emitter<CommentsState> emit,
  ) async {
    emit(
      copyCommentsStateWith(
        postId: event.postId,
        postCommentsStateUpdater: (postCommentsState) =>
            postCommentsState.setLoading(),
      ),
    );

    final commentsEither = await _getPostCommentsUseCase(event.postId);

    commentsEither.fold(
      (ex) => emit(
        copyCommentsStateWith(
          postId: event.postId,
          postCommentsStateUpdater: (postCommentsState) =>
              postCommentsState.setError(
                  error: "Failed to load comments. Please, try again later."),
        ),
      ),
      (commentsResult) => emit(
        copyCommentsStateWith(
          postId: event.postId,
          postCommentsStateUpdater: (postCommentsState) =>
              postCommentsState.setLoaded(comments: commentsResult),
        ),
      ),
    );
  }

  void _onCommentsClosedEvent(
    CommentsClosedEvent event,
    Emitter<CommentsState> emit,
  ) {
    emit(
      copyCommentsStateWith(
        postId: event.postId,
        postCommentsStateUpdater: (_) => PostCommentsState.unloaded(),
      ),
    );
  }

  CommentsState copyCommentsStateWith({
    required int postId,
    required PostCommentsState Function(PostCommentsState)
        postCommentsStateUpdater,
  }) {
    return CommentsState(
      postsCommentsStates: {
        ...state.postsCommentsStates,
        postId:
            postCommentsStateUpdater(state.getCommentsStateFromPost(postId)),
      },
    );
  }
}
