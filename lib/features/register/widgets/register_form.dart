import 'package:ccp_mobile/core/services/customer_service.dart';
import 'package:ccp_mobile/core/widgets/loading_spinner.dart';
import 'package:ccp_mobile/features/login/views/login_view.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;

  void _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final customerService = CustomerService();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final username = email.split('@').first;

      final success =
          await customerService.registerCustomer(username, email, password);

      setState(() => _isLoading = false);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registro exitoso')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al registrar')),
        );
      }

      // Navegar al LoginView después de la respuesta
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginView(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AbsorbPointer(
          absorbing: _isLoading,
          child: Opacity(
            opacity: _isLoading ? 0.5 : 1.0,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TextFormField(
                  //   controller: nameController,
                  //   decoration: const InputDecoration(labelText: 'Nombre'),
                  //   validator: (value) => value == null || value.isEmpty
                  //       ? 'Campo requerido'
                  //       : null,
                  // ),
                  // const SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    decoration:
                        const InputDecoration(labelText: 'Correo Electrónico'),
                    validator: (value) {
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (value == null || value.isEmpty) {
                        return 'Campo requerido';
                      } else if (!emailRegex.hasMatch(value)) {
                        return 'Correo no válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Contraseña'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Campo requerido'
                        : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'Confirmar Contraseña'),
                    validator: (value) => value != passwordController.text
                        ? 'Las contraseñas no coinciden'
                        : null,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: _handleRegister,
                      child: const Text(
                        'Registrar',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_isLoading)
          const Center(
            child: LoadingSpinner(
              color: AppColors.primaryColor,
              size: 20.0,
            ),
          ),
      ],
    );
  }
}
