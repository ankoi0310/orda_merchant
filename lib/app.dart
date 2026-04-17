import 'package:flutter/material.dart';
import 'package:orda_merchant/config/router/app_router.dart';
import 'package:orda_merchant/config/theme/theme.dart';
import 'package:orda_merchant/core/utils/app_util.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(
      context,
    ).platformDispatcher.platformBrightness;

    final textTheme = createTextTheme(context, 'Manrope', 'Mitr');
    final theme = MaterialTheme(textTheme);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Orda Merchant',
      theme: brightness == Brightness.light
          ? theme.light()
          : theme.dark(),
      routerConfig: AppRouter.config,
    );
  }
}
