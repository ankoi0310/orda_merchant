import 'package:flutter/material.dart';
import 'package:orda_merchant/features/user/presentation/widgets/general_section.dart';
import 'package:orda_merchant/features/user/presentation/widgets/preferences_section.dart';
import 'package:orda_merchant/features/user/presentation/widgets/profile_section.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hồ sơ người dùng')),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              ProfileSection(),
              GeneralSection(),
              PreferencesSection(),
            ],
          ),
        ),
      ),
    );
  }
}
