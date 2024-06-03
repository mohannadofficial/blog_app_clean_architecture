import 'package:equatable/equatable.dart';

class Blog extends Equatable {
  final String id;
  final String posterId;
  final String title;
  final String content;
  final String imageUrl;
  final List<String> topics;
  final DateTime updatedAt;
  final String? posterName;

  const Blog({
    required this.id,
    required this.posterId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.topics,
    required this.updatedAt,
    this.posterName,
  });

  @override
  List<Object?> get props {
    return [
      id,
      posterId,
      title,
      content,
      imageUrl,
      topics,
      updatedAt,
      posterName,
    ];
  }
}
