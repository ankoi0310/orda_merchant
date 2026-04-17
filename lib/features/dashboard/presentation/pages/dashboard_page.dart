import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:orda_merchant/features/dashboard/presentation/widgets/dashboard_actions_grid_view.dart';
import 'package:orda_merchant/features/dashboard/presentation/widgets/dashboard_overview.dart';
import 'package:orda_merchant/features/shop/domain/entities/shop.dart';
import 'package:orda_merchant/features/shop/presentation/bloc/shop/shop_bloc.dart';
import 'package:orda_merchant/features/shop/presentation/bloc/shop_list/shop_list_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentShop = context.watch<ShopBloc>().state.shop;
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () async {
            await showModalBottomSheet<void>(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: .directional(
                  topStart: .circular(16),
                  topEnd: .circular(16),
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
              mainAxisSize: .min,
              children: [
                Text(
                  currentShop!.name,
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
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          children: const [
            DashboardOverview(),
            SizedBox(height: 32),
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
        child: BlocBuilder<ShopListBloc, ShopListState>(
          buildWhen: (previous, current) => current is ShopListLoaded,
          builder: (context, state) {
            final shops = (state as ShopListLoaded).shops;
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
