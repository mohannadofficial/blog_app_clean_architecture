part of 'blog_bloc.dart';

sealed class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object> get props => [];
}

final class BlogInitial extends BlogState {
  @override
  List<Object> get props => [];
}

final class BlogLoading extends BlogState {
  @override
  List<Object> get props => [];
}

final class BlogUploadSuccess extends BlogState {}

final class BlogFetchSuccess extends BlogState {
  final List<Blog> blogs;

  const BlogFetchSuccess({required this.blogs});

  @override
  List<Object> get props => [blogs];
}

final class BlogFailure extends BlogState {
  final String error;
  const BlogFailure({required this.error});
  @override
  List<Object> get props => [error];
}
