import 'package:ccp_mobile/core/services/login_service.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_labels.dart';
import '../../../core/widgets/home_screen.dart';
import '../../register/views/register_view.dart';
import '../widgets/login_form.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  final loginService = LoginService();

  Future<void> _handleLogin() async {
    setState(() => _isLoading = true);

    try {
      final response = await loginService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (response != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(userRole: response),
          ),
          (route) => false,
        );
      } else {
        _showErrorDialog('Credenciales incorrectas');
      }
    } catch (e) {
      _showErrorDialog('Error de conexión: ${e.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildLoginForm(),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      
      child:
       Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          Image.asset(
            'assets/images/LogoCCP.png',
            height: MediaQuery.of(context).size.width * 0.4,
            width: MediaQuery.of(context).size.width * 1,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              AppLabels.appBar,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.045,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: LoginForm(
                emailController: emailController,
                passwordController: passwordController,
                onSubmit: _handleLogin,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterView()),
              );
            },
            child: const Text(
              "¿Eres tendero? Regístrate aquí",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
