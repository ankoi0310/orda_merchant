import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:orda_merchant/config/gen/assets.gen.dart';
import 'package:orda_merchant/config/router/app_router.dart';
import 'package:orda_merchant/core/bloc/session/session_cubit.dart';
import 'package:orda_merchant/features/shop/presentation/bloc/shop/shop_bloc.dart';
import 'package:orda_merchant/features/shop/presentation/bloc/shop_list/shop_list_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionState = context.watch<SessionCubit>().state;
    final shopState = context.watch<ShopBloc>().state;

    if (sessionState.isAuthenticated) {
      context.read<ShopListBloc>().add(FetchShopList());
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<ShopListBloc, ShopListState>(
          listener: (context, state) async {
            if (state is ShopListLoaded) {
              if (shopState.shop == null) {
                context.read<ShopBloc>().add(
                  CacheShop(state.shops.first),
                );
              }
            }
          },
        ),
        BlocListener<ShopBloc, ShopState>(
          listener: (context, state) async {
            print(state);
            if (state.shop != null) {
              await context.push(AppRouter.dashboard);
            }
          },
        ),
      ],
      child: Scaffold(
        body: Center(
          child: Assets.images.blankItem.image(
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
