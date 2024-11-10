import 'package:dartz/dartz.dart';
import 'package:json_placeholder_social_media/domain/entities/comment.dart';
import 'package:json_placeholder_social_media/domain/repositories/comment_repository.dart';

class GetPostCommentsUseCase {
  final CommentRepository _commentRepository;

  GetPostCommentsUseCase({
    required CommentRepository commentRepository,
  }) : _commentRepository = commentRepository;

  Future<Either<Exception, List<Comment>>> call(int postId) {
    return _commentRepository.getCommentsByPostId(postId);
  }
}
