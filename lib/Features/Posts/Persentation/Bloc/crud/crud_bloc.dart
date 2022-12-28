import 'dart:async';

import 'package:arc/Features/Posts/Domain/Entities/post.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../Core/Failure/Failure.dart';
import '../../../../../Core/resources/messages.dart';
import '../../../../../Core/resources/strings.dart';
import '../../../Domain/UseCase/add_posts_usecase.dart';
import '../../../Domain/UseCase/delete_posts_usecase.dart';
import '../../../Domain/UseCase/update_posts_usecase.dart';

part 'crud_event.dart';

part 'crud_state.dart';

class CrudBloc extends Bloc<CrudEvent, CrudState> {
  final AddPostsUseCase addPostsUseCase;
  final UpdatePostsUseCase updatePostsUseCase;
  final DeletePostsUseCase deletePostsUseCase;

  CrudBloc({
    required this.addPostsUseCase,
    required this.deletePostsUseCase,
    required this.updatePostsUseCase,
  }) : super(CrudInitial()) {
    on<CrudEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingCrudState());
        final failureOrDone = await addPostsUseCase(event.posts);
        emit(_mapState(failureOrDone, Messages.addSuccessMessage));
        // failureOrDone.fold(
        //   (l) {
        //     emit(ErrorCrudState(error: _mapFailureToError(l)));
        //   },
        //   (r) {
        //     emit(const MessageCrudState(message: Messages.addSuccessMessage));
        //   },
        // );
      } else if (event is UpdatePostEvent) {
        emit(LoadingCrudState());
        final failureOrDone = await updatePostsUseCase(event.posts);
        emit(_mapState(failureOrDone, Messages.updateSuccessMessage));
      } else if (event is DeletePostEvent) {
        emit(LoadingCrudState());
        final failureOrDone = await deletePostsUseCase(event.postId);
        emit(_mapState(failureOrDone, Messages.deleteSuccessMessage));
      }
    });
  }

  CrudState _mapState(Either<Failure, Unit> either, String message) {
    return either.fold(
      (l) {
        return ErrorCrudState(error: _mapFailureToError(l));
      },
      (r) {
        return MessageCrudState(message: message);
      },
    );
  }

  String _mapFailureToError(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return StringsManager.serverError;
      case OfflineFailure:
        return StringsManager.offlineError;
      default:
        return "Un Expected Error , Please Try Again Later";
    }
  }
}
