import 'package:dartz/dartz.dart';
import 'package:json_placeholder_social_media/domain/entities/post.dart';

abstract class PostRepository {
  Future<Either<Exception, List<Post>>> getPostsByUserId(int userId);
}
