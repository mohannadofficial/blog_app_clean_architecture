part of 'blog_bloc.dart';

sealed class BlogEvent extends Equatable {
  const BlogEvent();

  @override
  List<Object?> get props => [];
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

final class EditBlogEvent extends BlogEvent {
  final String id;
  final String posterId;
  final String title;
  final String content;
  final File? image;
  final String? imageUrl;
  final List<String> topics;

  const EditBlogEvent({
    required this.id,
    required this.posterId,
    required this.title,
    required this.content,
    this.image,
    this.imageUrl,
    required this.topics,
  });

  @override
  List<Object?> get props => [
        id,
        posterId,
        title,
        content,
        image,
        imageUrl,
        topics,
      ];
}
