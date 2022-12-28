import 'package:arc/Features/Posts/Domain/Repository/base_posts_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../Core/Failure/Failure.dart';
import '../Entities/post.dart';

class GetAllPostsUseCase{
  final BasePostsRepository postsRepository ;
  GetAllPostsUseCase(this.postsRepository);

  Future<Either<Failure, List<Posts>>> call()async{
    return await postsRepository.getPosts();
  }
}