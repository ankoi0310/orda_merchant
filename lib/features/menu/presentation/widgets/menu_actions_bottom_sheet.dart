import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/core/models/nav_item.dart';

class MenuActionsBottomSheet extends StatelessWidget {
  const MenuActionsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                /// 🔹 Title (center thật)
                Center(
                  child: Text(
                    'Hành động',
                    style: context.textTheme.titleLarge,
                  ),
                ),

                /// 🔹 Nút X bên phải
                Positioned(
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => context.pop(),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          Flexible(
            child: ListView.separated(
              itemCount: menuFloatingActions.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final action = menuFloatingActions[index];
                return ListTile(
                  onTap: () async {
                    await context.push(action.route);
                  },
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  leading: Icon(action.icon),
                  horizontalTitleGap: 8,
                  title: Text(
                    action.label,
                    style: context.textTheme.titleSmall,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
