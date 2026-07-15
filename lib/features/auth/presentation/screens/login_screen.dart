import 'package:fitnies/core/theme/app_colors.dart';
import 'package:fitnies/features/auth/presentation/widgets/social_auth_row.dart';
import 'package:fitnies/features/auth/presentation/widgets/auth_or_divider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    // TODO login usecase
    // e.g. ref.read(authNotifierProvider.notifier).login(_email.text.trim(), _password.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,

      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/registerBG.png', fit: BoxFit.cover),
      Container(color: Colors.black.withOpacity(0.55)),
      SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Image.asset('assets/images/logo.png', height: 70),
                const SizedBox(height: 40),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Hey There', style: TextStyle(color: Colors.white70, fontSize: 14)),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('WELCOME BACK',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 24),
                const Text('Login', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),

                AuthTextField(
                  controller: _email,
                  hint: 'Email',
                  icon: Icons.mail_outline,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: AuthValidators.email,
                ),
                const SizedBox(height: 14),
                AuthTextField(
                  controller: _password,
                  hint: 'Password',
                  icon: Icons.lock_outline,
                  obscure: _obscure,
                  validator: AuthValidators.password,
                  textInputAction: TextInputAction.done,
                  suffix: IconButton(
                    icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility, color: Colors.white54, size: 20),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {}, // TODO go to Forget Password
                    child: const Text('Forget Password ?', style: TextStyle(color: AppColors.orange,
                        fontSize: 12)),
                  ),
                ),

                const SizedBox(height: 10),
                const AuthOrDivider(),
                const SizedBox(height: 20),
                const SocialAuthRow(),
                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(

                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                    ),
                    child: const Text('Login', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't Have An Account Yet ? ",
                        style: TextStyle(color: Colors.white54, fontSize: 12)),
                    GestureDetector(
                      onTap: () => GoRouter.of(context).push(RegisterRoute.path),
                      child: const Text('Register', style: TextStyle(
                          color: AppColors.orange,
                          fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ]
      ),

    );
  }
}
