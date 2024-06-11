import 'dart:io';

import 'package:blog/core/usecase/base_usecase.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:blog/features/blog/domain/usecases/add_new_blog_usecase.dart';
import 'package:blog/features/blog/domain/usecases/get_all_blog_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final AddNewBlogUsecase _addNewBlog;
  final GetAllBlogUsecase _getAllBlog;

  BlogBloc(
      {required AddNewBlogUsecase addNewBlog,
      required GetAllBlogUsecase getAllBlog})
      : _addNewBlog = addNewBlog,
        _getAllBlog = getAllBlog,
        super(BlogInitial()) {
    on<BlogEvent>((_, emit) => emit(BlogLoading()));
    on<AddNewBlogEvent>(_createNewBlog);
    on<GetAllBlogEvent>(_fetchAllBlog);
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

  void _fetchAllBlog(GetAllBlogEvent event, Emitter<BlogState> emit) async {
    final res = await _getAllBlog(NoParams());

    res.fold(
      (l) => emit(BlogFailure(error: l.message)),
      (r) => emit(BlogFetchSuccess(blogs: r)),
    );
  }
}
