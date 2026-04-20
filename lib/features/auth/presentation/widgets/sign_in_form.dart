import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/core/extensions/string_extension.dart';
import 'package:orda_merchant/core/ui/components/text_form_field.dart';
import 'package:orda_merchant/features/auth/presentation/bloc/auth_bloc.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      context.read<AuthBloc>().add(
        SignInWithEmailPassword(
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
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
                    return 'Email Không được để trống';
                  }

                  if (!value.isEmail) {
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
              Text.rich(
                textAlign: TextAlign.end,
                TextSpan(
                  text: 'Quên mật khẩu?',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.colors.error,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: state is AuthLoading ? null : _onSubmit,
                  child: const Text('Đăng nhập'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
