import 'package:dartz/dartz.dart';

import '../../../../Core/Failure/Failure.dart';
import '../Entities/post.dart';
import '../Repository/base_posts_repository.dart';

class DeletePostsUseCase{
  final BasePostsRepository postsRepository ;
  DeletePostsUseCase(this.postsRepository);

  Future<Either<Failure, Unit>> call(int id)async{
    return await postsRepository.deletePosts(id);
  }
}