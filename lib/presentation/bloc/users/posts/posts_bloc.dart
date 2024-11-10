import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_placeholder_social_media/domain/usecases/get_posts_use_case.dart';
import 'package:json_placeholder_social_media/presentation/bloc/users/posts/posts_event.dart';
import 'package:json_placeholder_social_media/presentation/bloc/users/posts/posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPostsUseCase _getPostsUseCase;

  PostsBloc({
    required GetPostsUseCase getPostsUseCase,
  })  : _getPostsUseCase = getPostsUseCase,
        super(PostsLoadingState()) {
    on<PostsLoadStartedEvent>(_onPostsLoadStartedEvent);
  }

  void _onPostsLoadStartedEvent(
    PostsLoadStartedEvent event,
    Emitter<PostsState> emit,
  ) async {
    emit(PostsLoadingState());
    final postsEither = await _getPostsUseCase(event.userId);
    postsEither.fold(
      (ex) => emit(PostsLoadFailState()),
      (postsResult) => emit(PostsLoadedState(posts: postsResult)),
    );
  }
}
