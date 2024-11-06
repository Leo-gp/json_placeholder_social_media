import 'package:dartz/dartz.dart';
import 'package:json_placeholder_social_media/data/data_sources/post_data_source.dart';
import 'package:json_placeholder_social_media/domain/entities/post.dart';
import 'package:json_placeholder_social_media/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostDataSource _postDataSource;

  PostRepositoryImpl({
    required PostDataSource postDataSource,
  }) : _postDataSource = postDataSource;

  @override
  Future<Either<Exception, List<Post>>> getPostsByUserId(int userId) async {
    try {
      final posts = await _postDataSource.getPostsByUserId(userId);
      return Right(posts);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
