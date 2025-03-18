import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_labels.dart';
//import '../../../core/services/login_service.dart';
import '../../../main.dart';
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
  //final LoginService _loginService = LoginService();

  Future<void> _handleLogin() async {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(userRole: 'admin'),
        ),
      );
    // setState(() {
    //   _isLoading = true;
    // });
    // try {
    //   final isAuthenticated = await _loginService.login(
    //     emailController.text.trim(),
    //     passwordController.text.trim(),
    //   );
    //   if (isAuthenticated) {
    //     //Navigator.pushNamed(context, AppRoutes.qrScanner);
    //   } else {
    //     _showErrorDialog('Credenciales incorrectas');
    //   }
    // } catch (e) {
    //   _showErrorDialog('Error de conexión: ${e.toString()}');
    // } finally {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // }
  }

  // void _showErrorDialog(String message) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Error'),
  //       content: Text(message),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text('OK'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildLoginForm(),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(), // Spinner en el centro
            ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryColor, 
              AppColors.secondaryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
         Image.asset(
              'assets/images/LogoCCP.png',
              height: MediaQuery.of(context).size.width * 0.4,
              width: MediaQuery.of(context).size.width * 1,
            ),
            Align(
                alignment: Alignment.center,
                child: Text(
                  AppLabels.appBar, // Título centrado
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            const SizedBox(height: 40),
            LoginForm(
              emailController: emailController,
              passwordController: passwordController,
              onSubmit: _handleLogin,
            ),
          ],
        ),
      ),
    );
  }
}
