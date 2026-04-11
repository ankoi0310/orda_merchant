import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda_merchant/config/router/app_router.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/features/menu/presentation/widgets/menu_item_card.dart';
import 'package:orda_merchant/features/menu_category/domain/entities/menu_category.dart';
import 'package:orda_merchant/features/menu_category/presentation/bloc/menu_category_list/menu_category_list_bloc.dart';
import 'package:orda_merchant/features/menu_item/domain/entities/menu_item.dart';
import 'package:orda_merchant/features/menu_item/presentation/bloc/menu_item_list/menu_item_list_cubit.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MenuItemScrollableList extends StatelessWidget {
  const MenuItemScrollableList({
    required this.itemScrollController,
    super.key,
  });

  final ItemScrollController itemScrollController;

  @override
  Widget build(BuildContext context) {
    final categories = context
        .watch<MenuCategoryListBloc>()
        .state
        .categories;
    final items = context.watch<MenuItemListCubit>().state.items;
    final scrollOffsetController = ScrollOffsetController();
    final itemPositionsListener = ItemPositionsListener.create();
    final scrollOffsetListener = ScrollOffsetListener.create();

    final itemsByCategory = <MenuCategory, List<MenuItem>>{
      for (final category in categories) category: [],
    };

    for (final item in items) {
      final category = categories.firstWhere(
        (category) => category.id == item.categoryId,
      );
      itemsByCategory[category]?.add(item);
    }

    return BlocBuilder<MenuItemListCubit, MenuItemListState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state.isLoading,
          child: ScrollablePositionedList.builder(
            itemScrollController: itemScrollController,
            scrollOffsetController: scrollOffsetController,
            itemPositionsListener: itemPositionsListener,
            scrollOffsetListener: scrollOffsetListener,
            itemCount: state.isLoading
                ? 5
                : itemsByCategory.keys.length,
            itemBuilder: (context, index) {
              final category = state.isLoading
                  ? MenuCategory.test()
                  : itemsByCategory.keys.elementAt(index);
              final items = state.isLoading
                  ? fakeMenuItems
                  : itemsByCategory.values.elementAt(index);

              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      style: context.textTheme.titleLarge,
                    ),
                    if (state.isLoaded && items.isEmpty)
                      const Center(
                        child: Text('Chưa có món thuộc nhóm này'),
                      )
                    else
                      ScrollablePositionedList.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];

                          return Stack(
                            children: [
                              MenuItemCard(item: item),
                              Positioned(
                                bottom: 8,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () => context.push(
                                    AppRouter.updateMenuItem(item.id),
                                    extra: item,
                                  ),
                                  child: const Icon(
                                    Iconsax.edit_copy,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(height: 1);
                        },
                      ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
