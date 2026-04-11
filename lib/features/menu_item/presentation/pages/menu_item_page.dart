import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda_merchant/config/router/app_router.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/features/menu/presentation/widgets/menu_item_card.dart';
import 'package:orda_merchant/features/menu_item/domain/entities/menu_item.dart';
import 'package:orda_merchant/features/menu_item/presentation/bloc/menu_item_list/menu_item_list_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MenuItemPage extends StatefulWidget {
  const MenuItemPage({super.key});

  @override
  State<MenuItemPage> createState() => _MenuItemPageState();
}

class _MenuItemPageState extends State<MenuItemPage> {
  @override
  Widget build(BuildContext context) {
    final items = context.watch<MenuItemListCubit>().state.items;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: context.pop),
        titleSpacing: 0,
        title: const Text('Danh sách món'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: context.colors.surface,
                border: Border(
                  bottom: BorderSide(
                    width: 2,
                    color: context.colors.outlineVariant,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Tìm kiếm món',
                            prefixIcon: const Icon(
                              Iconsax.search_normal_copy,
                            ),
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      IntrinsicHeight(
                        child: IntrinsicWidth(
                          child: IconButton.outlined(
                            icon: const Icon(Iconsax.add_copy),
                            style: IconButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  8,
                                ),
                              ),
                            ),
                            onPressed: () =>
                                context.push(AppRouter.addMenuItem),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    spacing: 8,
                    children: [
                      Chip(label: Text('Status')),
                      Chip(label: Text('Category')),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),

            // Menu Item List
            Expanded(
              child:
                  BlocBuilder<MenuItemListCubit, MenuItemListState>(
                    builder: (context, state) {
                      return Skeletonizer(
                        enabled: state.isLoading,
                        child: ListView.separated(
                          itemCount: state.isLoading
                              ? 10
                              : items.length,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          itemBuilder: (context, index) {
                            final item = state.isLoading
                                ? MenuItem.test()
                                : items[index];
                            return Stack(
                              children: [
                                MenuItemCard(item: item),
                                Positioned(
                                  bottom: 8,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: state.isLoading
                                        ? null
                                        : () => context.push(
                                            AppRouter.updateMenuItem(
                                              item.id,
                                            ),
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
                            return Divider(
                              color: Colors.grey[300],
                              thickness: 1,
                              height: 1,
                              indent: 16,
                              endIndent: 16,
                            );
                          },
                        ),
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
