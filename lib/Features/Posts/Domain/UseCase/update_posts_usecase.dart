import 'package:arc/Features/Posts/Domain/Entities/post.dart';
import 'package:dartz/dartz.dart';

import '../../../../Core/Failure/Failure.dart';
import '../Repository/base_posts_repository.dart';

class UpdatePostsUseCase{
  final BasePostsRepository postsRepository ;
  UpdatePostsUseCase(this.postsRepository);

  Future<Either<Failure, Unit>> call(Posts posts)async{
    return await postsRepository.updatePost(posts);
  }
}