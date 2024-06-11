import 'package:blog/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

void showSnackBar({required String text, required BuildContext context}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: const TextStyle(
            color: AppPallete.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppPallete.greyColor,
      ),
    );
}
