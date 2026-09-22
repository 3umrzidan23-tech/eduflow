import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().login(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
    }
  }

  void _onDemoAccountPressed(BuildContext context) {
    _emailController.text = 'demo@eduflow.com';
    _passwordController.text = 'demo123456';
    context.read<LoginCubit>().useDemoAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              context.go('/home');
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is LoginLoading;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 48),
                    // Logo
                    const Center(
                      child: Icon(
                        Icons.layers,
                        size: 64,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Title
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),
                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      enabled: !isLoading,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      obscureText: _obscurePassword,
                      enabled: !isLoading,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Forget Password Link
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: isLoading ? null : () {},
                        child: const Text(
                          'Forget password',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Login Button
                    ElevatedButton(
                      onPressed: isLoading ? null : () => _onLoginPressed(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E293B),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                    const SizedBox(height: 16),
                    // Demo Account Button
                    OutlinedButton.icon(
                      onPressed:
                          isLoading ? null : () => _onDemoAccountPressed(context),
                      icon: const Icon(Icons.play_circle_fill, color: Colors.blueAccent),
                      label: const Text(
                        'Use Demo Account',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF1E293B),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(color: Colors.blueAccent, width: 2),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Create Account Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: isLoading ? null : () => context.go('/register'),
                          child: const Text(
                            'Create Account',
                            style: TextStyle(
                              color: Color(0xFF1E293B),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
