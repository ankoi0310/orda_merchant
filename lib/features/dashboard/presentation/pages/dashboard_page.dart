import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda_merchant/config/router/app_router.dart';
import 'package:orda_merchant/core/bloc/session/session_cubit.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/features/dashboard/presentation/widgets/dashboard_actions_grid_view.dart';
import 'package:orda_merchant/features/dashboard/presentation/widgets/dashboard_overview.dart';
import 'package:orda_merchant/features/shop/presentation/bloc/shop_list/shop_list_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final valueListenable = ValueNotifier<String?>(
      context.watch<SessionCubit>().state.shopId,
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 16,
          title: BlocListener<SessionCubit, SessionState>(
            listenWhen: (prev, curr) => prev.shopId != curr.shopId,
            listener: (context, sessionState) {
              valueListenable.value = sessionState.shopId;
            },
            child: BlocConsumer<ShopListBloc, ShopListState>(
              listener: (context, state) async {
                if (state is ShopListLoaded &&
                    valueListenable.value == null) {
                  valueListenable.value = state.shops.first.id;
                  await context.read<SessionCubit>().selectShop(
                    state.shops.first.id,
                  );
                }
              },
              builder: (shopListContext, state) {
                if (state is ShopListLoaded) {
                  final shops = state.shops;
                  return DropdownButton2<String>(
                    valueListenable: valueListenable,
                    onChanged: (shopId) async {
                      if (shopId != null) {
                        await context.read<SessionCubit>().selectShop(
                          shopId,
                        );
                      }
                    },
                    items: shops.map((shop) {
                      return DropdownItem<String>(
                        value: shop.id,
                        child: Text(shop.name),
                      );
                    }).toList(),
                  );
                }

                return const DropdownButton2<String?>(
                  items: [
                    DropdownItem<String?>(child: Text('Loading...')),
                  ],
                );
              },
            ),
          ),
          actionsPadding: const EdgeInsets.only(right: 16),
          actions: [
            IconButton.filled(
              onPressed: () => context.push(AppRouter.profile),
              color: context.colors.onPrimary,
              icon: const Icon(Iconsax.shop_copy),
            ),
            IconButton.filled(
              onPressed: () => context.push(AppRouter.profile),
              color: context.colors.onPrimary,
              icon: const Icon(Iconsax.user_copy),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: const Column(
              spacing: 24,
              children: [
                DashboardOverview(),

                DashboardActionsGridView(),

                // other services
                // Container(
                //   padding: const EdgeInsets.symmetric(vertical: 16),
                //   decoration: BoxDecoration(
                //     color: context.colors.secondaryContainer,
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     spacing: 4,
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.symmetric(
                //           horizontal: 16,
                //         ),
                //         child: Text(
                //           'Dịch vụ khác',
                //           style: Theme.of(context).textTheme.titleMedium!
                //               .copyWith(fontWeight: FontWeight.bold),
                //         ),
                //       ),
                //       ListView.separated(
                //         padding: EdgeInsets.zero,
                //         shrinkWrap: true,
                //         physics: const NeverScrollableScrollPhysics(),
                //         itemCount: otherServices.length,
                //         itemBuilder: (context, index) {
                //           final service = otherServices[index];
                //           return ListTile(
                //             tileColor: context.colors.secondaryContainer,
                //             onTap: () => context.push(service.route),
                //             leading: Icon(service.icon),
                //             titleTextStyle: context.textTheme.bodyMedium,
                //             title: Text(service.label),
                //             trailing: const Icon(
                //               Icons.arrow_forward_ios,
                //               size: 16,
                //             ),
                //           );
                //         },
                //         separatorBuilder: (context, index) {
                //           return const Divider(
                //             height: 1,
                //             indent: 16,
                //             endIndent: 16,
                //           );
                //         },
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
