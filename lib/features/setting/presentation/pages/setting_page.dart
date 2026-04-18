import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/features/user/presentation/bloc/user_bloc.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cài đặt')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const .all(16),
            child: Column(
              spacing: 16,
              children: [
                buildContainer(context),
                buildContainer(context),
                buildSignOut(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListTile buildListTile({
    required String title,
    void Function()? onTap,
  }) {
    return ListTile(onTap: onTap, title: Text(title));
  }

  Container buildContainer(BuildContext context) {
    return Container(
      padding: const .symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: context.colors.outline,
        borderRadius: .circular(16),
      ),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: .zero,
            children: [
              buildListTile(title: 'Thông tin cá nhân'),
              buildListTile(title: 'Đổi mật khẩu'),
            ],
          ),
        ],
      ),
    );
  }

  Container buildSignOut(BuildContext context) {
    return Container(
      padding: const .symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: context.colors.errorContainer,
        borderRadius: .circular(16),
      ),
      child: ListTile(
        onTap: () async {
          final shouldSignOut = await showSignOutConfirmDialog(
            context,
          );

          if (shouldSignOut == true) {
            context.read<UserBloc>().add(SignOut());
          }
        },
        leading: Icon(
          Iconsax.logout_copy,
          color: context.colors.error,
        ),
        title: Text(
          'Đăng xuất',
          style: TextStyle(color: context.colors.error),
        ),
      ),
    );
  }

  Future<bool?> showSignOutConfirmDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // bắt buộc chọn
      builder: (context) {
        return AlertDialog(
          title: const Text('Đăng xuất'),
          content: const Text(
            'Bạn có chắc chắn muốn đăng xuất không?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Huỷ'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Đăng xuất'),
            ),
          ],
        );
      },
    );
  }
}
