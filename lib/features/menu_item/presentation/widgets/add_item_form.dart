import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/core/ui/components/text_form_field.dart';

class AddItemForm extends StatelessWidget {
  const AddItemForm({required this.formKey, super.key});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final valueListenable = ValueNotifier<String>('1');
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 16,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text('Ảnh', style: context.textTheme.bodyLarge),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: context.colors.outlineVariant,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: context.colors.outline,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Iconsax.gallery_copy,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    title: const Text('Thêm ảnh'),
                    subtitle: const Text('Thêm ảnh cho sản phẩm này'),
                    trailing: const Icon(Iconsax.arrow_right_3_copy),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    'Category',
                    style: context.textTheme.bodyLarge,
                  ),
                  DropdownButtonFormField2(
                    valueListenable: valueListenable,
                    onChanged: (value) {
                      valueListenable.value =
                          value ?? valueListenable.value;
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                    ),
                    items: const [
                      DropdownItem<String>(
                        value: '1',
                        child: Text('Category 1'),
                      ),
                    ],
                  ),
                ],
              ),
              AppTextFormField(
                title: 'Tên mặt hàng',
                controller: TextEditingController(),
                focusNode: FocusNode(),
                hintText: 'Tên mặt hàng',
              ),
              AppTextFormField(
                title: 'Mô tả',
                controller: TextEditingController(),
                focusNode: FocusNode(),
                hintText: 'Thêm mô tả cho mặt hàng',
                maxLines: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
