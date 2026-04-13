import 'package:flutter/material.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/features/order/domain/entities/order.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({required this.order, super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Row(
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
            onPressed: () {},
            child: const Text('Hoàn thành'),
          ),
        ),
      ],
    );
  }
}
