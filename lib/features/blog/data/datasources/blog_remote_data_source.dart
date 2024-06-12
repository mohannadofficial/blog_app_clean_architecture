import 'dart:io';

import 'package:blog/core/error/exception.dart';
import 'package:blog/features/blog/data/models/blog_model.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BaseBlogRemoteDataSource {
  Future<BlogModel> addNewBlog({required BlogModel blog});
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });
  Future<List<BlogModel>> getAllBlog();
  Future<BlogModel> editBlog({required BlogModel blog});
}

class BlogRemoteDataSource implements BaseBlogRemoteDataSource {
  final SupabaseClient supabaseClient;
  BlogRemoteDataSource({required this.supabaseClient});
  @override
  Future<BlogModel> addNewBlog({required BlogModel blog}) async {
    try {
      final blogData =
          await supabaseClient.from('blogs').insert(blog.toJson()).select();

      final blogModel = BlogModel.fromJson(blogData.first);

      return blogModel;
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage(
      {required File image, required BlogModel blog}) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(
            blog.id,
            image,
          );

      return supabaseClient.storage.from('blog_images').getPublicUrl(
            blog.id,
          );
    } on StorageException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlog() async {
    try {
      final blogsData =
          await supabaseClient.from('blogs').select('*, profiles (name)');

      return blogsData
          .map((blog) => (BlogModel.fromJson(blog)).copyWith(
                posterName: blog['profiles']['name'],
              ))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<BlogModel> editBlog({required BlogModel blog}) async {
    try {
      final blogData = await supabaseClient
          .from('blogs')
          .update(blog.toJson())
          .eq('id', blog.id)
          .select();

      final blogModel = BlogModel.fromJson(blogData.first);

      print(blogModel.toJson().toString());

      return blogModel;
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
