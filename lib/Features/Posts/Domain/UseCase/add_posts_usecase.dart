import 'package:dartz/dartz.dart';
import '../../../../Core/Failure/Failure.dart';
import '../Entities/post.dart';
import '../Repository/base_posts_repository.dart';

class AddPostsUseCase{
  final BasePostsRepository postsRepository ;
  AddPostsUseCase(this.postsRepository);

  Future<Either<Failure, Unit>> call(Posts posts)async{
    return await postsRepository.addPost(posts);
  }
}