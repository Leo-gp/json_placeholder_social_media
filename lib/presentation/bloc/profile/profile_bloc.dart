import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_placeholder_social_media/domain/usecases/get_posts_use_case.dart';
import 'package:json_placeholder_social_media/presentation/bloc/profile/profile_event.dart';
import 'package:json_placeholder_social_media/presentation/bloc/profile/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetPostsUseCase _getPostsUseCase;

  ProfileBloc({
    required GetPostsUseCase getPostsUseCase,
  })  : _getPostsUseCase = getPostsUseCase,
        super(ProfilePostsLoadingState()) {
    on<ProfileLoadStartedEvent>(_onProfileLoadStartedEvent);
  }

  void _onProfileLoadStartedEvent(
    ProfileLoadStartedEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfilePostsLoadingState());
    final postsEither = await _getPostsUseCase(event.userId);
    postsEither.fold(
      (ex) => emit(ProfilePostsLoadFailState()),
      (postsResult) => emit(ProfilePostsLoadedState(posts: postsResult)),
    );
  }
}
