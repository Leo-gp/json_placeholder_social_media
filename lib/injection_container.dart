import 'package:get_it/get_it.dart';
import 'package:json_placeholder_social_media/data/data_sources/post_data_source.dart';
import 'package:json_placeholder_social_media/data/data_sources/user_data_source.dart';
import 'package:json_placeholder_social_media/data/repositories/post_repository_impl.dart';
import 'package:json_placeholder_social_media/data/repositories/user_repository_impl.dart';
import 'package:json_placeholder_social_media/domain/repositories/post_repository.dart';
import 'package:json_placeholder_social_media/domain/repositories/user_repository.dart';
import 'package:json_placeholder_social_media/domain/usecases/get_posts_use_case.dart';
import 'package:json_placeholder_social_media/domain/usecases/get_users_use_case.dart';
import 'package:json_placeholder_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:json_placeholder_social_media/presentation/bloc/users/users_bloc.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Blocs
  getIt.registerFactory(() => UsersBloc(getUsersUseCase: getIt()));

  getIt.registerFactory(() => ProfileBloc(getPostsUseCase: getIt()));

  // Usecases
  getIt.registerLazySingleton(() => GetUsersUseCase(userRepository: getIt()));

  getIt.registerLazySingleton(() => GetPostsUseCase(postRepository: getIt()));

  // Repositories
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(userDataSource: getIt()),
  );

  getIt.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(postDataSource: getIt()),
  );

  // Data Source
  getIt.registerLazySingleton(() => UserDataSource());

  getIt.registerLazySingleton(() => PostDataSource());
}
