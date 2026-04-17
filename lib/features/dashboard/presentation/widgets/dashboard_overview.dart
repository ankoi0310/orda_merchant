import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/core/extensions/number_extension.dart';
import 'package:orda_merchant/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:orda_merchant/features/shop/presentation/bloc/shop/shop_bloc.dart';

class DashboardOverview extends StatefulWidget {
  const DashboardOverview({super.key});

  @override
  State<DashboardOverview> createState() => _DashboardOverviewState();
}

class _DashboardOverviewState extends State<DashboardOverview> {
  @override
  Widget build(BuildContext context) {
    final shop = context.watch<ShopBloc>().state.shop;
    if (shop != null) {
      context.read<AnalyticsBloc>().add(GetTodayStats(shop.id));
    }
    return BlocBuilder<AnalyticsBloc, AnalyticsState>(
      builder: (context, state) {
        var totalOrders = 0;
        var totalRevenue = 0;

        if (state is GetTodayStatsSuccess) {
          totalOrders = state.stats.totalOrders;
          totalRevenue = state.stats.totalRevenue;
        }

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.colors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(
                'Thống kê hôm nay',
                style: context.textTheme.bodyLarge!.copyWith(
                  color: context.colors.onPrimary,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      spacing: 4,
                      children: [
                        Text(
                          'Số lượng đơn hàng',
                          style: context.textTheme.bodyMedium!
                              .copyWith(
                                color: context.colors.onPrimary,
                              ),
                        ),
                        Text(
                          '$totalOrders',
                          style: context.textTheme.titleLarge!
                              .copyWith(
                                color: context.colors.onPrimary,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      spacing: 4,
                      children: [
                        Text(
                          'Số tiền đặt hàng (VND)',
                          style: context.textTheme.bodyMedium!
                              .copyWith(
                                color: context.colors.onPrimary,
                              ),
                        ),
                        Text(
                          totalRevenue.toVND(),
                          style: context.textTheme.titleLarge!
                              .copyWith(
                                color: context.colors.onPrimary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
