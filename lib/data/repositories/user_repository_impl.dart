import 'package:dartz/dartz.dart';
import 'package:json_placeholder_social_media/data/data_sources/user_data_source.dart';
import 'package:json_placeholder_social_media/domain/entities/user.dart';
import 'package:json_placeholder_social_media/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _userDataSource;

  UserRepositoryImpl({
    required UserDataSource userDataSource,
  }) : _userDataSource = userDataSource;

  @override
  Future<Either<Exception, List<User>>> getUsers() async {
    try {
      final users = await _userDataSource.getUsers();
      return Right(users);
    } on Exception catch (ex) {
      return Left(ex);
    }
  }
}
