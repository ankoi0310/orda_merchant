import 'package:flutter/material.dart';
import 'package:orda_merchant/config/gen/assets.gen.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Assets.images.blankItem.image(width: 200, height: 200),
      ),
    );
  }
}
