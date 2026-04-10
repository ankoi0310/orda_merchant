import 'package:flutter/material.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/features/menu_category/domain/entities/menu_category.dart';

class MenuCategoryChip extends StatelessWidget {
  const MenuCategoryChip({
    required this.category,
    required this.onTap,
    super.key,
  });

  final MenuCategory category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        labelStyle: context.textTheme.labelMedium,
        label: Text(category.name),
      ),
    );
  }
}
