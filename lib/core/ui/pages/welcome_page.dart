import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
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
      body: const Padding(
        padding: .all(16),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text('Bạn chưa có cửa hàng'),
            Row(
              spacing: 16,
              children: [
                Text('Đăng ký cửa hàng'),
                Text('Nhập mã mời'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
