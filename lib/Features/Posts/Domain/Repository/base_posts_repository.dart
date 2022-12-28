import '../../../../Core/Failure/Failure.dart';
import '../Entities/post.dart';
import 'package:dartz/dartz.dart';

abstract class BasePostsRepository {
  // unit mean nothings equal void
  Future<Either<Failure, List<Posts>>> getPosts();

  Future<Either<Failure, Unit>> deletePosts(int id);

  Future<Either<Failure, Unit>> updatePost(Posts posts);

  Future<Either<Failure, Unit>> addPost(Posts posts);
}
