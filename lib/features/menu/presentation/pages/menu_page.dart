import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/features/menu/presentation/widgets/menu_actions_bottom_sheet.dart';
import 'package:orda_merchant/features/menu/presentation/widgets/menu_category_horizontal_list.dart';
import 'package:orda_merchant/features/menu/presentation/widgets/menu_item_scrollable_list.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    final itemScrollController = ItemScrollController();

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: context.pop),
        title: const Text('Thực đơn'),
        titleSpacing: 0,
        elevation: 0,
        actionsPadding: const EdgeInsets.only(right: 16),
        actions: [
          GestureDetector(
            onTap: () async {
              await showModalBottomSheet<dynamic>(
                context: context,
                builder: (context) {
                  return const MenuActionsBottomSheet();
                },
              );
            },
            child: const Icon(Iconsax.menu_1_copy),
          ),
        ],
        bottom: AppBar(
          centerTitle: true,
          title: MenuCategoryHorizontalList(
            controller: itemScrollController,
          ),
          elevation: 4,
          shadowColor: context.colors.shadow,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 12),
        child: MenuItemScrollableList(
          itemScrollController: itemScrollController,
        ),
      ),
    );
  }
}
