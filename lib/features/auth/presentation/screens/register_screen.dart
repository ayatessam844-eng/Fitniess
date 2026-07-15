import 'package:fitnies/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import '../widgets/auth_or_divider.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_validator.dart';
import '../widgets/social_auth_row.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();

}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }
  String? _confirmPasswordValidator(String? value) {
    final baseError = AuthValidators.password(value);
    if (baseError != null) return baseError;
    if (value != _password.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/registerBG.png', fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.55)),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Image.asset('assets/images/logo.png', height: 60),
                    const SizedBox(height: 24),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Hey There', style: TextStyle(color: Colors.white70, fontSize: 14)),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('CREATE AN ACCOUNT',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const Text('Register',
                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 18),
                          AuthTextField(
                            controller: _firstName,
                            hint: 'First Name',
                            icon: Icons.person_outline,
                            keyboardType: TextInputType.name,
                            validator: (v)=> AuthValidators.name(v, fieldName: 'First name'),
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 12),
                          AuthTextField(
                            controller: _lastName,
                            hint: 'Last Name',
                            icon: Icons.person_outline,
                            keyboardType: TextInputType.name,
                            validator: (v) => AuthValidators.name(v, fieldName: 'Last name'),
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 12),
                          AuthTextField(
                            controller: _email,
                            hint: 'Email',
                            icon: Icons.mail_outline,
                            validator: AuthValidators.email,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 12),
                          AuthTextField(
                            controller: _password,
                            hint: 'Password',
                            validator: AuthValidators.password,
                            icon: Icons.lock_outline,
                            obscure: _obscure,
                            textInputAction: TextInputAction.done,
                            suffix: IconButton(
                              icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.white54, size: 20),
                              onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                            ),
                          ),
                          const SizedBox(height: 12),
                          AuthTextField(
                              controller: _confirmPassword,
                               hint: 'Enter a Confirm Password',
                              icon: Icons.lock_outline,
                              obscure: _obscure,
                              textInputAction: TextInputAction.done,
                              validator: AuthValidators.password,
                             ),
                          const SizedBox(height: 16),
                          const AuthOrDivider(),
                          const SizedBox(height: 16),
                          const SocialAuthRow(circleSize: 40),
                          const SizedBox(height: 22),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () =>
                              GoRouter.of(context).push(LoginRoute.path),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.orange,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                              ),
                              child: const Text(
                                  'Register',
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold)),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already Have An Account ? ', style: TextStyle(color: Colors.white54, fontSize: 12)),
                              GestureDetector(
                                onTap: () => GoRouter.of(context).pop(), // TODO go to Login
                                child: const Text('Login',
                                    style: TextStyle(color: AppColors.orange, fontSize: 12, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
