import 'package:blog/core/theme/app_pallete.dart';
import 'package:blog/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:blog/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign Up.',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            AuthTextFormField(
              controller: nameController,
              keyboardType: TextInputType.name,
              hintText: 'Name',
            ),
            const SizedBox(
              height: 15,
            ),
            AuthTextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              hintText: 'E-mail',
            ),
            const SizedBox(
              height: 15,
            ),
            AuthTextFormField(
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              hintText: 'Password',
            ),
            const SizedBox(
              height: 30,
            ),
            AuthGradientButton(
              buttonText: 'Sign Up',
              onPressed: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                text: 'already have an account? ',
                style: Theme.of(context).textTheme.titleMedium,
                children: [
                  TextSpan(
                    text: 'Sign in',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppPallete.gradient2,
                        ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
