import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_placeholder_social_media/domain/usecases/get_users_use_case.dart';
import 'package:json_placeholder_social_media/presentation/bloc/users/users_event.dart';
import 'package:json_placeholder_social_media/presentation/bloc/users/users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetUsersUseCase _getUsersUseCase;

  UsersBloc({
    required GetUsersUseCase getUsersUseCase,
  })  : _getUsersUseCase = getUsersUseCase,
        super(UsersLoadingState()) {
    on<UsersLoadStartedEvent>(_onUsersLoadStartedEvent);
  }

  void _onUsersLoadStartedEvent(
    UsersLoadStartedEvent event,
    Emitter<UsersState> emit,
  ) async {
    emit(UsersLoadingState());
    final usersEither = await _getUsersUseCase();
    usersEither.fold(
      (ex) => emit(UsersLoadFailedState()),
      (usersResult) => emit(UsersLoadedState(users: usersResult)),
    );
  }
}
