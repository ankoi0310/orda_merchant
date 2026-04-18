import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:orda_merchant/config/router/app_router.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/core/ui/components/loading_widget.dart';
import 'package:orda_merchant/core/utils/app_util.dart';
import 'package:orda_merchant/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:orda_merchant/features/auth/presentation/widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthError) {
          showSnackBar(context, content: state.message);
        }

        if (state is AuthSuccess) {
          context.go(AppRouter.login);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: const .symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: SizedBox(
                    height: context.height,
                    child: Column(
                      mainAxisAlignment: .center,
                      crossAxisAlignment: .stretch,
                      children: [
                        buildContainer(context),
                        const SizedBox(height: 32),
                        const RegisterForm(),
                        Padding(
                          padding: const .only(top: 16),
                          child: OutlinedButton(
                            onPressed: () =>
                                context.go(AppRouter.login),
                            child: const Text('Đăng nhập'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (state is AuthLoading)
                  const LoadingWidget(text: 'Đang đăng ký...'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildContainer(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        Text(
          'Orda Merchant',
          style: context.textTheme.displayMedium!.copyWith(
            fontWeight: .bold,
            foreground: Paint()
              ..shader = LinearGradient(
                colors: [
                  context.colors.primary,
                  context.colors.primary.withValues(alpha: 0.7),
                ],
              ).createShader(const Rect.fromLTWH(0, 0, 80, 70)),
          ),
        ),
        Text(
          'Đăng ký tài khoản',
          style: context.textTheme.headlineLarge,
        ),
      ],
    );
  }
}
