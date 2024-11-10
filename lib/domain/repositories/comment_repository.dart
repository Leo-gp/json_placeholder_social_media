import 'package:dartz/dartz.dart';
import 'package:json_placeholder_social_media/domain/entities/comment.dart';

abstract class CommentRepository {
  Future<Either<Exception, List<Comment>>> getCommentsByPostId(int postId);
}
