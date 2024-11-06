import 'package:dartz/dartz.dart';
import 'package:json_placeholder_social_media/domain/entities/post.dart';
import 'package:json_placeholder_social_media/domain/repositories/post_repository.dart';

class GetPostsUseCase {
  final PostRepository _postRepository;

  GetPostsUseCase({
    required PostRepository postRepository,
  }) : _postRepository = postRepository;

  Future<Either<Exception, List<Post>>> call(int userId) {
    return _postRepository.getPostsByUserId(userId);
  }
}
