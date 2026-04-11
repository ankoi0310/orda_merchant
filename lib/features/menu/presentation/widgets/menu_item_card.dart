import 'package:flutter/material.dart';
import 'package:orda_merchant/config/gen/assets.gen.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/features/menu_item/domain/entities/menu_item.dart';

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
            SizedBox(
              width: context.width * .2,
              height: context.width * .2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: item.imageUrl.isEmpty
                    ? Assets.images.blankItem.image(fit: BoxFit.cover)
                    : Image.network(
                        item.imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder:
                            (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }

                              final progress =
                                  loadingProgress
                                          .expectedTotalBytes !=
                                      null
                                  ? loadingProgress
                                            .cumulativeBytesLoaded /
                                        loadingProgress
                                            .expectedTotalBytes!
                                  : null;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: progress,
                                  color: context.colors.outline,
                                ),
                              );
                            },
                      ),
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
