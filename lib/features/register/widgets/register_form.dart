import 'package:flutter/material.dart';
import 'package:ccp_mobile/core/services/customer_service.dart';
import '../../../core/constants/app_colors.dart';
import 'package:ccp_mobile/features/login/views/login_view.dart';

class RegisterForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final void Function() onSubmit;

  const RegisterForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onSubmit,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final customerService = CustomerService();
      final email = widget.emailController.text.trim();
      final password = widget.passwordController.text.trim();
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
                  // Asignamos una clave única al campo de correo electrónico
                  TextFormField(
                    key: const Key('loginEmailField'),
                    controller: widget.emailController,
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
                  // Asignamos una clave única al campo de contraseña
                  TextFormField(
                    key: const Key('loginPasswordField'),
                    controller: widget.passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Contraseña'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Campo requerido'
                        : null,
                  ),
                  const SizedBox(height: 10),
                  // Asignamos una clave única al campo de confirmación de contraseña
                  TextFormField(
                    key: const Key('loginConfirmPasswordField'),
                    controller: widget.confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'Confirmar Contraseña'),
                    validator: (value) => value != widget.passwordController.text
                        ? 'Las contraseñas no coinciden'
                        : null,
                  ),
                  const SizedBox(height: 20),
                  // Asignamos una clave única al botón de registrar
                  Center(
                    child: ElevatedButton(
                      key: const Key('loginButton'),
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
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          ),
      ],
    );
  }
}