import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/features/order/domain/entities/order.dart';
import 'package:orda_merchant/features/order/presentation/bloc/upcoming_orders/upcoming_orders_cubit.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({required this.order, super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpcomingOrdersCubit, UpcomingOrdersState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Row(
        spacing: 8,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colors.onPrimary,
                foregroundColor: context.colors.primary,
              ),
              child: const Text('Huỷ đơn'),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () async {
                await context
                    .read<UpcomingOrdersCubit>()
                    .confirmOrderComplete(order.id);
              },
              child: const Text('Hoàn thành'),
            ),
          ),
        ],
      ),
    );
  }
}
