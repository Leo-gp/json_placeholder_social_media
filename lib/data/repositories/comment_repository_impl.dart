import 'package:dartz/dartz.dart';
import 'package:json_placeholder_social_media/data/data_sources/comment_data_source.dart';
import 'package:json_placeholder_social_media/domain/entities/comment.dart';
import 'package:json_placeholder_social_media/domain/repositories/comment_repository.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentDataSource _commentDataSource;

  CommentRepositoryImpl({
    required CommentDataSource commentDataSource,
  }) : _commentDataSource = commentDataSource;

  @override
  Future<Either<Exception, List<Comment>>> getCommentsByPostId(
    int postId,
  ) async {
    try {
      final comments = await _commentDataSource.getCommentsByPostId(postId);
      return Right(comments);
    } on Exception catch (ex) {
      return Left(ex);
    }
  }
}
