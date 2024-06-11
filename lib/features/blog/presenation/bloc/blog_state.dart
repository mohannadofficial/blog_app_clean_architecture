// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'blog_bloc.dart';

class BlogState extends Equatable {
  final List<Blog> blogs;
  final SubmissionStatus submissionStatus;
  final String error;
  const BlogState({
    this.blogs = const [],
    this.submissionStatus = SubmissionStatus.idle,
    this.error = '',
  });

  @override
  List<Object> get props => [blogs, submissionStatus, error];

  BlogState copyWith({
    List<Blog>? blogs,
    SubmissionStatus? submissionStatus,
    String? error,
  }) {
    return BlogState(
      blogs: blogs ?? this.blogs,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      error: error ?? this.error,
    );
  }
}

enum SubmissionStatus { idle, inProgress, loaded, error }
