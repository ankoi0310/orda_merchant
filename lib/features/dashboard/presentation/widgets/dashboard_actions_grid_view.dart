import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/core/models/nav_item.dart';

class DashboardActionsGridView extends StatelessWidget {
  const DashboardActionsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      children: dashboardActions.map((action) {
        return InkWell(
          onTap: () => context.push(action.route),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.colors.secondaryContainer,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: context.colors.shadow.withValues(alpha: 0.5),
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                Icon(
                  action.icon,
                  color: context.colors.onSecondaryContainer,
                ),
                Text(
                  action.label,
                  textAlign: TextAlign.center,
                  style: context.textTheme.labelMedium!.copyWith(
                    color: context.colors.onSecondaryContainer,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
