import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda_merchant/core/bloc/user_setup/user_setup_cubit.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:orda_merchant/features/dashboard/presentation/widgets/dashboard_actions_grid_view.dart';
import 'package:orda_merchant/features/dashboard/presentation/widgets/dashboard_overview.dart';
import 'package:orda_merchant/features/shop/domain/entities/shop.dart';
import 'package:orda_merchant/features/shop/presentation/bloc/shop/shop_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userSetupState = context.watch<UserSetupCubit>().state;
    final currentShop =
        (userSetupState as UserSetupReady).selectedShop!;
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () async {
            await showModalBottomSheet<void>(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(16),
                  topEnd: Radius.circular(16),
                ),
              ),
              builder: (context) {
                return buildChooseShopBottomSheet(
                  currentShop,
                  context,
                );
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: context.colors.outlineVariant,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              spacing: 8,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  currentShop.name,
                  style: context.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colors.onSecondaryContainer,
                  ),
                ),
                const Icon(Iconsax.arrow_swap_horizontal_copy),
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<AnalyticsBloc>().add(
            GetTodayStats(currentShop.id),
          );
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const .symmetric(horizontal: 16, vertical: 16),
          children: const [
            DashboardOverview(),
            SizedBox(height: 32),
            DashboardActionsGridView(),
          ],
        ),
      ),
    );
  }

  SafeArea buildChooseShopBottomSheet(
    Shop currentShop,
    BuildContext context,
  ) {
    return SafeArea(
      child: RadioGroup<Shop>(
        groupValue: currentShop,
        onChanged: (shop) {
          if (shop != null) {
            context.read<ShopBloc>().add(CacheShop(shop));
          }
        },
        child: Builder(
          builder: (context) {
            final userSetupState = context
                .watch<UserSetupCubit>()
                .state;
            final shops = (userSetupState as UserSetupReady).shops;
            return Padding(
              padding: const .symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: .stretch,
                mainAxisSize: .min,
                children: [
                  Padding(
                    padding: const .symmetric(horizontal: 16),
                    child: Text(
                      'Chọn cửa hàng',
                      textAlign: .center,
                      style: context.textTheme.titleMedium!.copyWith(
                        fontWeight: .bold,
                      ),
                    ),
                  ),

                  ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Radio<Shop>(value: shops[index]),
                          Text(shops[index].name),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 8);
                    },
                    itemCount: shops.length,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
