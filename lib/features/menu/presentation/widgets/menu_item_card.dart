import 'package:flutter/material.dart';
import 'package:orda_merchant/config/gen/assets.gen.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/features/menu_item/domain/entities/menu_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MenuItemCard extends StatelessWidget {
  const MenuItemCard({required this.item, super.key});

  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: IntrinsicHeight(
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: item.imageUrl.isEmpty
                  ? Assets.images.blankItem.image(
                      width: context.width * 0.2,
                      height: context.width * 0.2,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      item.imageUrl,
                      width: context.width * 0.2,
                      height: context.width * 0.2,
                      fit: BoxFit.cover,
                      loadingBuilder:
                          (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;

                            return Skeletonizer(
                              containersColor:
                                  context.colors.outlineVariant,
                              child: Container(
                                height: context.width * .2,
                                width: context.width * .2,
                                color: context.colors.outlineVariant,
                              ),
                            );
                          },
                    ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(item.name, style: context.textTheme.bodyLarge),
                  Text(
                    item.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelMedium,
                  ),
                  const Spacer(),
                  Text(
                    '${item.price}',
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: context.colors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
