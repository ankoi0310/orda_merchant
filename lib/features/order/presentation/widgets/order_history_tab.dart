import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/core/extensions/date_time_extension.dart';
import 'package:orda_merchant/core/extensions/number_extension.dart';
import 'package:orda_merchant/features/order/domain/entities/order.dart';
import 'package:orda_merchant/features/order/presentation/bloc/history_orders/history_orders_cubit.dart';
import 'package:orda_merchant/features/order/presentation/widgets/order_detail_modal.dart';

class OrderHistoryTab extends StatelessWidget {
  const OrderHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryOrdersCubit, HistoryOrdersState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.isError) {}

        return ListView.separated(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          itemCount: state.orders.length,
          itemBuilder: (context, index) {
            final order = state.orders[index];
            return GestureDetector(
              onTap: () async {
                await showModalBottomSheet<void>(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.directional(
                      topStart: Radius.circular(16),
                      topEnd: Radius.circular(16),
                    ),
                  ),
                  builder: (context) {
                    return OrderDetailModal(order: order);
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.colors.outline),
                ),
                child: Column(
                  crossAxisAlignment: .stretch,
                  children: [
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text(
                          '#${order.orderNumber}',
                          style: context.textTheme.titleLarge,
                        ),
                        buildOrderStatus(context, order.status),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text('${order.totalItems} món'),
                        Text(
                          order.totalPrice.toVND(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(order.createdAt.fullTimeDate),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) =>
              const SizedBox(height: 16),
        );
      },
    );
  }

  Container buildOrderStatus(
    BuildContext context,
    OrderStatus status,
  ) {
    late Color backgroundColor, textColor;

    switch (status) {
      case OrderStatus.confirmed:
      case OrderStatus.preparing:
      case OrderStatus.completed:
        backgroundColor = context.colors.outlineVariant;
        textColor = context.colors.primary;
      case OrderStatus.cancelled:
        backgroundColor = context.colors.errorContainer;
        textColor = context.colors.error;
    }
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        // color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.label,
        style: context.textTheme.bodyMedium!.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
