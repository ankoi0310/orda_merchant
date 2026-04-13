import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/core/extensions/number_extension.dart';
import 'package:orda_merchant/features/order/presentation/bloc/upcoming_orders/upcoming_orders_cubit.dart';
import 'package:orda_merchant/features/order/presentation/widgets/action_buttons.dart';
import 'package:orda_merchant/features/order/presentation/widgets/order_item_field.dart';

class UpcomingOrdersTab extends StatelessWidget {
  const UpcomingOrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpcomingOrdersCubit, UpcomingOrdersState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.isError) {}

        return ListView.separated(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          itemCount: state.orders.length,
          itemBuilder: (context, index) {
            final order = state.orders[index];
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.colors.outline),
              ),
              child: Column(
                crossAxisAlignment: .stretch,
                spacing: 16,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Text(
                            '#${order.orderNumber}',
                            style: context.textTheme.titleLarge,
                          ),
                          Text(
                            '${order.totalPrice.toVND()} (${order.totalItems} món)',
                            style: context.textTheme.titleMedium!
                                .copyWith(
                                  color: context.colors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: order.items.length,
                    itemBuilder: (context, index) {
                      final item = order.items[index];
                      return OrderItemField(item: item);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 12);
                    },
                  ),
                  ActionButtons(order: order),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) =>
              const SizedBox(height: 16),
        );
      },
    );
  }
}
