part of 'crud_bloc.dart';

abstract class CrudState extends Equatable {
  const CrudState();

  @override
  List<Object> get props => [];
}

class CrudInitial extends CrudState {
  @override
  List<Object> get props => [];
}

class LoadingCrudState extends CrudState {}

class ErrorCrudState extends CrudState {
  final String error;

  const ErrorCrudState({required this.error});
  @override
  List<Object> get props => [error];
}

class MessageCrudState extends CrudState {
  final String message;

  const MessageCrudState({required this.message});
  @override
  List<Object> get props => [message];
}
