import 'dart:io';

import 'package:blog/core/usecase/base_usecase.dart';
import 'package:blog/features/blog/domain/entities/blog.dart';
import 'package:blog/features/blog/domain/usecases/add_new_blog_usecase.dart';
import 'package:blog/features/blog/domain/usecases/edit_blog_usecase.dart';
import 'package:blog/features/blog/domain/usecases/get_all_blog_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final AddNewBlogUsecase _addNewBlog;
  final GetAllBlogUsecase _getAllBlog;
  final EditBlogUsecase _editBlog;

  BlogBloc(
      {required AddNewBlogUsecase addNewBlog,
      required GetAllBlogUsecase getAllBlog,
      required EditBlogUsecase editBlog})
      : _addNewBlog = addNewBlog,
        _getAllBlog = getAllBlog,
        _editBlog = editBlog,
        super(const BlogState()) {
    on<BlogEvent>((_, emit) =>
        emit(state.copyWith(submissionStatus: SubmissionStatus.inProgress)));
    on<AddNewBlogEvent>(_createNewBlog);
    on<EditBlogEvent>(_updateBlog);
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
      (l) => emit(state.copyWith(
          error: l.message, submissionStatus: SubmissionStatus.error)),
      (r) => emit(state.copyWith(
        blogs: [r, ...state.blogs],
        submissionStatus: SubmissionStatus.loaded,
      )),
    );
  }

  void _updateBlog(EditBlogEvent event, Emitter<BlogState> emit) async {
    final res = await _editBlog(
      EditBlogParams(
        id: event.id,
        imageUrl: event.imageUrl,
        title: event.title,
        content: event.content,
        image: event.image,
        posterId: event.posterId,
        topics: event.topics,
      ),
    );

    res.fold(
      (l) => emit(state.copyWith(
          error: l.message, submissionStatus: SubmissionStatus.error)),
      (r) => emit(state.copyWith(
        blogs: [
          r,
          ...state.blogs.filter((e) => e.id != r.id),
        ],
        submissionStatus: SubmissionStatus.loaded,
      )),
    );
  }

  void _fetchAllBlog(GetAllBlogEvent event, Emitter<BlogState> emit) async {
    final res = await _getAllBlog(NoParams());

    res.fold(
      (l) => emit(state.copyWith(
          error: l.message, submissionStatus: SubmissionStatus.error)),
      (r) => emit(state.copyWith(
        blogs: r,
        submissionStatus: SubmissionStatus.loaded,
      )),
    );
  }
}
