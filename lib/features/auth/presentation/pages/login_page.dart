import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:orda_merchant/config/router/app_router.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/core/ui/components/loading_widget.dart';
import 'package:orda_merchant/core/utils/app_util.dart';
import 'package:orda_merchant/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:orda_merchant/features/auth/presentation/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthError) {
          showSnackBar(context, content: state.message);
        }

        if (state is AuthSuccess) {
          context.go(AppRouter.dashboard);
          showSnackBar(context, content: 'Đăng nhập thành công');
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsetsGeometry.symmetric(
                        vertical: context.height * .05,
                      ),
                      child: Column(
                        spacing: 8,
                        children: [
                          Text(
                            'Orda',
                            style: context.textTheme.displayLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..shader =
                                        LinearGradient(
                                          colors: [
                                            context.colors.primary,
                                            context.colors.primary
                                                .withValues(
                                                  alpha: 0.7,
                                                ),
                                          ],
                                        ).createShader(
                                          const Rect.fromLTWH(
                                            0,
                                            0,
                                            80,
                                            70,
                                          ),
                                        ),
                                ),
                          ),
                          Text(
                            'Welcome back!',
                            style: context.textTheme.headlineLarge,
                          ),
                        ],
                      ),
                    ),
                    const LoginForm(),
                  ],
                ),
              ),
              if (state is AuthLoading)
                const LoadingWidget(text: 'Đang đăng nhập...'),
            ],
          ),
        );
      },
    );
  }
}
