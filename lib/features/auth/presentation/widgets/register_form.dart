import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/core/extensions/string_extension.dart';
import 'package:orda_merchant/core/ui/components/text_form_field.dart';
import 'package:orda_merchant/features/auth/presentation/bloc/auth_bloc.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    fullNameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      context.read<AuthBloc>().add(
        SignUpWithEmailPassword(
          fullName: fullNameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: .stretch,
            spacing: 16,
            children: [
              Column(
                spacing: 12,
                children: [
                  AppTextFormField(
                    title: 'Họ tên',
                    enabled: state is! AuthLoading,
                    controller: fullNameController,
                    focusNode: fullNameFocusNode,
                    hintText: 'Nhập tên của bạn',
                    onFieldSubmitted: (value) {
                      emailFocusNode.requestFocus();
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        fullNameFocusNode.requestFocus();
                        return 'Tên Không được để trống';
                      }

                      return null;
                    },
                  ),
                  AppTextFormField(
                    title: 'Email',
                    enabled: state is! AuthLoading,
                    controller: emailController,
                    focusNode: emailFocusNode,
                    hintText: 'Nhập email của bạn',
                    onFieldSubmitted: (value) {
                      passwordFocusNode.requestFocus();
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        emailFocusNode.requestFocus();
                        return 'Email Không được để trống';
                      }

                      if (!value.isEmail) {
                        emailFocusNode.requestFocus();
                        return 'Email không hợp lệ';
                      }

                      return null;
                    },
                  ),
                  AppPasswordFormField(
                    enabled: state is! AuthLoading,
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                    onFieldSubmitted: (value) => _onSubmit(),
                  ),
                ],
              ),
              Padding(
                padding: const .only(top: 16),
                child: ElevatedButton(
                  onPressed: state is AuthLoading ? null : _onSubmit,
                  child: const Text('Đăng ký'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
