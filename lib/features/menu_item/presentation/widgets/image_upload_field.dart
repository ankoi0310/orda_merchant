import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';

class ImageUploadField extends StatelessWidget {
  const ImageUploadField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text('Ảnh', style: context.textTheme.bodyLarge),
        ListTile(
          onTap: () {},
          dense: true,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: context.colors.outlineVariant),
            borderRadius: BorderRadius.circular(12),
          ),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.colors.outline,
              shape: BoxShape.circle,
            ),
            child: const Icon(Iconsax.gallery_copy),
          ),
          title: const Text('Thêm ảnh'),
          subtitle: const Text('Thêm ảnh cho sản phẩm này'),
          trailing: const Icon(Iconsax.arrow_right_3_copy),
        ),
      ],
    );
  }
}
