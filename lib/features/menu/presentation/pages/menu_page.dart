import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda_merchant/features/menu/presentation/widgets/menu_actions_bottom_sheet.dart';
import 'package:orda_merchant/features/menu/presentation/widgets/menu_category_horizontal_list.dart';
import 'package:orda_merchant/features/menu/presentation/widgets/menu_item_scrollable_list.dart';
import 'package:orda_merchant/features/menu_category/domain/entities/menu_category.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final itemScrollController = ItemScrollController();

    return Scaffold(
      appBar: AppBar(
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
      ),
      body: SafeArea(
        child: Column(
          children: [
            MenuCategoryHorizontalList(
              controller: itemScrollController,
              categories: fakeCategories,
            ),
            MenuItemScrollableList(
              itemScrollController: itemScrollController,
            ),
          ],
        ),
      ),
    );
  }
}
