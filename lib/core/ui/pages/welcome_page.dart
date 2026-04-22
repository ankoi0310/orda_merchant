import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda_merchant/config/router/app_router.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/features/user/presentation/bloc/user_bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: const .only(right: 16),
        actions: [
          GestureDetector(
            onTap: () => context.read<UserBloc>().add(SignOut()),
            child: const Icon(Iconsax.logout_copy),
          ),
        ],
      ),
      body: Padding(
        padding: const .all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
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
                    ).createShader(const .fromLTWH(0, 0, 80, 70)),
                ),
              ),
              Text(
                'Bạn chưa có cửa hàng',
                style: context.textTheme.headlineSmall,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () =>
                    context.push(AppRouter.merchantApplication),
                child: const Text('Đăng ký cửa hàng ngay'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
