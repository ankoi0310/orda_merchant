import 'package:flutter/material.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';

class DashboardOverview extends StatelessWidget {
  const DashboardOverview({super.key});

  @override
  Widget build(BuildContext context) {
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
            'Doanh thu hôm nay',
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
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: context.colors.onPrimary,
                      ),
                    ),
                    Text(
                      '18',
                      style: context.textTheme.titleLarge!.copyWith(
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
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: context.colors.onPrimary,
                      ),
                    ),
                    Text(
                      '10.000.000',
                      style: context.textTheme.titleLarge!.copyWith(
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
  }
}
