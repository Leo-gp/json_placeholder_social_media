import 'package:dartz/dartz.dart';
import 'package:json_placeholder_social_media/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Exception, List<User>>> getUsers();
}
