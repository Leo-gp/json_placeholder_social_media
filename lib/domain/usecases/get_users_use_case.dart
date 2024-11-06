import 'package:dartz/dartz.dart';
import 'package:json_placeholder_social_media/domain/entities/user.dart';
import 'package:json_placeholder_social_media/domain/repositories/user_repository.dart';

class GetUsersUseCase {
  final UserRepository _userRepository;

  GetUsersUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  Future<Either<Exception, List<User>>> call() {
    return _userRepository.getUsers();
  }
}
