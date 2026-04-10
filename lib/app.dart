import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/config/router/app_router.dart';
import 'package:orda_merchant/config/theme/theme.dart';
import 'package:orda_merchant/core/cubit/session_cubit.dart';
import 'package:orda_merchant/core/utils/app_util.dart';
import 'package:orda_merchant/features/shop/presentation/bloc/shop_list/shop_list_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(
      context,
    ).platformDispatcher.platformBrightness;

    final textTheme = createTextTheme(context, 'Manrope', 'Mitr');
    final theme = MaterialTheme(textTheme);
    return MultiBlocListener(
      listeners: [
        BlocListener<SessionCubit, SessionState>(
          listenWhen: (prev, curr) => prev.user != curr.user,
          listener: (context, state) {
            if (state.user != null) {
              context.read<ShopListBloc>().add(FetchShopList());
            }
          },
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Orda Merchant',
        theme: brightness == Brightness.light
            ? theme.light()
            : theme.dark(),
        routerConfig: AppRouter.config,
      ),
    );
  }
}
