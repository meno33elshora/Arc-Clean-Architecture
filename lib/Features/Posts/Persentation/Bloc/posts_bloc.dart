import 'package:arc/Core/Failure/Failure.dart';
import 'package:arc/Core/resources/strings.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../Domain/Entities/post.dart';
import '../../Domain/UseCase/get_all_posts_usecase.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPostsUseCase;

  PostsBloc({
    required this.getAllPostsUseCase,
  }) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvents) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPostsUseCase();
        emit(_mapState(failureOrPosts));
      } else if (event is RefreshPostsEvents) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPostsUseCase();
        emit(_mapState(failureOrPosts));
      }
    });
  }

  PostsState _mapState(Either<Failure, List<Posts>> either) {
    return either.fold(
      (l) {
        return ErrorPostsState(error: _mapFailureToError(l));
      },
      (r) {
        return LoadedPostsState(posts: r);
      },
    );
  }

  String _mapFailureToError(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return StringsManager.serverError;
      case EmptyCacheFailure:
        return StringsManager.emptyCacheError;
      case OfflineFailure:
        return StringsManager.offlineError;
      default:
        return "Un Expected Error , Please Try Again Later";
    }
  }
}
