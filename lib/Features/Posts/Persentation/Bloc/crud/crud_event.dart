part of 'crud_bloc.dart';

abstract class CrudEvent extends Equatable {
  const CrudEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddPostEvent extends CrudEvent {
  final Posts posts;

  const AddPostEvent({required this.posts});

  @override
  List<Object?> get props => [posts];
}

class UpdatePostEvent extends CrudEvent {
  final Posts posts;

  const UpdatePostEvent({required this.posts});

  @override
  List<Object?> get props => [posts];
}

class DeletePostEvent extends CrudEvent {
  final int postId;

  const DeletePostEvent({required this.postId});

  @override
  List<Object?> get props => [postId];
}
