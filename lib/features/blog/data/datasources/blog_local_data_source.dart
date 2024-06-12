import 'package:blog/features/blog/data/models/blog_model.dart';
import 'package:hive_flutter/adapters.dart';

abstract interface class BaseBlogLocalDataSource {
  void uploadBlogs(List<BlogModel> blogs);
  List<BlogModel> loadBlogs();
}

class BlogLocalDataSource implements BaseBlogLocalDataSource {
  final Box box;
  BlogLocalDataSource({required this.box});

  @override
  List<BlogModel> loadBlogs() {
    List<BlogModel> blogs = [];
    for (int i = 0; i < blogs.length; i++) {
      blogs.add(BlogModel.fromJson(box.get(i.toString())));
    }
    return blogs;
  }

  @override
  void uploadBlogs(List<BlogModel> blogs) {
    for (int i = 0; i < blogs.length; i++) {
      box.put(i.toString(), blogs[i].toJson());
    }
  }
}
