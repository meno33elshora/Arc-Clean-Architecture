import 'package:arc/Core/Failure/Failure.dart';
import 'package:arc/Core/Failure/exception.dart';
import 'package:arc/Features/Posts/Data/Models/posts_model.dart';
import 'package:arc/Features/Posts/Domain/Entities/post.dart';
import 'package:arc/Features/Posts/Domain/Repository/base_posts_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../Core/Network/network.dart';
import '../DataSource/posts_local_datasource.dart';
import '../DataSource/posts_remote_datasource.dart';

typedef Methods = Future<Unit> Function();

class PostsRepository implements BasePostsRepository {
  final PostsRemoteDataSource postsRemoteDataSource;
  final PostsLocalDataSource postsLocalDataSource;
  final NetworkInfo networkInfo;

  PostsRepository({
    required this.postsRemoteDataSource,
    required this.postsLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Posts>>> getPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await postsRemoteDataSource.getAllPosts();
        postsLocalDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await postsLocalDataSource.getCachePosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Posts posts) async {
    final PostsModel postsModel = PostsModel(
      // id: posts.id,
      title: posts.title,
      body: posts.body,
    );
    return await _getMethods(() {
      return postsRemoteDataSource.addPosts(postsModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePosts(int id) async {
    return await _getMethods(() {
      return postsRemoteDataSource.deletePosts(id);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Posts posts) async {
    final PostsModel postsModel = PostsModel(
      id: posts.id,
      title: posts.title,
      body: posts.body,
    );

    return await _getMethods(() {
      return postsRemoteDataSource.updatePosts(postsModel);
    });
  }

  Future<Either<Failure, Unit>> _getMethods(Methods methods) async {
    if (await networkInfo.isConnected) {
      try {
        await methods();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
