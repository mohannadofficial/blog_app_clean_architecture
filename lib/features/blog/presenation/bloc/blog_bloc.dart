import 'dart:io';

import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:blog/features/blog/domain/usecases/add_new_blog_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final AddNewBlogUsecase _addNewBlog;

  BlogBloc({required AddNewBlogUsecase addNewBlog})
      : _addNewBlog = addNewBlog,
        super(BlogInitial()) {
    on<BlogEvent>((_, emit) => emit(BlogLoading()));
    on<AddNewBlogEvent>(_createNewBlog);
  }

  void _createNewBlog(AddNewBlogEvent event, Emitter<BlogState> emit) async {
    final res = await _addNewBlog(
      AddNewBlogParams(
        title: event.title,
        content: event.content,
        image: event.image,
        posterId: event.posterId,
        topics: event.topics,
      ),
    );

    res.fold(
      (l) => emit(BlogFailure(error: l.message)),
      (r) => emit(BlogUploadSuccess()),
    );
  }
}
