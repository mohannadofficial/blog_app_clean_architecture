import 'dart:io';

import 'package:blog/app_router.dart';
import 'package:blog/core/common/cubit/app_user_cubit.dart';
import 'package:blog/core/common/widgets/loader.dart';
import 'package:blog/core/constants/constants.dart';
import 'package:blog/core/theme/app_pallete.dart';
import 'package:blog/core/utils/pick_image.dart';
import 'package:blog/core/utils/show_snackbar.dart';
import 'package:blog/features/blog/presenation/bloc/blog_bloc.dart';
import 'package:blog/features/blog/presenation/widgets/blog_form_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  late final TextEditingController blogTitleController;
  late final TextEditingController blogDescriptionController;
  final formKey = GlobalKey<FormState>();
  List<String> selectedTopics = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void addNewBlog() {
    if (formKey.currentState!.validate() &&
        selectedTopics.isNotEmpty &&
        image != null) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      context.read<BlogBloc>().add(AddNewBlogEvent(
            posterId: posterId,
            title: blogTitleController.text.trim(),
            content: blogDescriptionController.text.trim(),
            image: image!,
            topics: selectedTopics,
          ));
    }
  }

  @override
  void initState() {
    blogTitleController = TextEditingController();
    blogDescriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    blogTitleController.dispose();
    blogDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => addNewBlog(),
              icon: const Icon(
                Icons.done_rounded,
              ),
            )
          ],
        ),
        body: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state.submissionStatus == SubmissionStatus.error) {
              showSnackBar(context: context, text: state.error);
            } else if (state.submissionStatus == SubmissionStatus.loaded) {
              context.goNamed(AppRouter.blog.name);
            }
          },
          builder: (context, state) {
            if (state.submissionStatus == SubmissionStatus.inProgress) {
              return const Loader();
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => selectImage(),
                        child: SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    image!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : DottedBorder(
                                  color: AppPallete.borderColor,
                                  dashPattern: const [10, 4],
                                  radius: const Radius.circular(10),
                                  borderType: BorderType.RRect,
                                  strokeCap: StrokeCap.round,
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.folder_open,
                                        size: 40,
                                      ),
                                      SizedBox(
                                        height: 15,
                                        width: double.infinity,
                                      ),
                                      Text(
                                        'Select your image',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      //  List Category
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: Constants.topics
                              .map((e) => Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (selectedTopics.contains(e)) {
                                          selectedTopics.remove(e);
                                        } else {
                                          selectedTopics.add(e);
                                        }
                                        setState(() {});
                                      },
                                      child: Chip(
                                        label: Text(e),
                                        color: selectedTopics.contains(e)
                                            ? const WidgetStatePropertyAll(
                                                AppPallete.gradient1)
                                            : null,
                                        side: selectedTopics.contains(e)
                                            ? null
                                            : const BorderSide(
                                                color: AppPallete.borderColor,
                                              ),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),

                      // Blog Title
                      const SizedBox(
                        height: 15,
                      ),
                      BlogFormField(
                        hintText: 'Blog title',
                        controller: blogTitleController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      BlogFormField(
                        hintText: 'Blog description',
                        controller: blogDescriptionController,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
