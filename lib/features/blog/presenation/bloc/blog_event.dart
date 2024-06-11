part of 'blog_bloc.dart';

sealed class BlogEvent extends Equatable {
  const BlogEvent();

  @override
  List<Object> get props => [];
}

final class AddNewBlogEvent extends BlogEvent {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  const AddNewBlogEvent({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });

  @override
  List<Object> get props => [
        posterId,
        title,
        content,
        image,
        topics,
      ];
}

final class GetAllBlogEvent extends BlogEvent {
  @override
  List<Object> get props => [];
}
