import 'package:flutter/material.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../widgets/register_form.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Registro",
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RegisterForm(
          emailController: emailController,
          passwordController: passwordController,
          confirmPasswordController: confirmPasswordController,
          onSubmit: () {},
        ),
      ),
    );
  }
}