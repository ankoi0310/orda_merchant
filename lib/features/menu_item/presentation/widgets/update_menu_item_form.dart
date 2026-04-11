import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/core/extensions/string_extension.dart';
import 'package:orda_merchant/core/ui/components/text_form_field.dart';
import 'package:orda_merchant/features/menu/presentation/widgets/bottom_form_action.dart';
import 'package:orda_merchant/features/menu_item/domain/entities/menu_item.dart';
import 'package:orda_merchant/features/menu_item/domain/usecases/update_menu_item_use_case.dart';
import 'package:orda_merchant/features/menu_item/presentation/bloc/menu_item/menu_item_bloc.dart';
import 'package:orda_merchant/features/menu_item/presentation/widgets/category_dropdown_field.dart';
import 'package:orda_merchant/features/menu_item/presentation/widgets/image_upload_field.dart';

class UpdateMenuItemForm extends StatefulWidget {
  const UpdateMenuItemForm({
    required this.id,
    required this.item,
    super.key,
  });

  final String id;
  final MenuItem item;

  @override
  State<UpdateMenuItemForm> createState() =>
      _UpdateMenuItemFormState();
}

class _UpdateMenuItemFormState extends State<UpdateMenuItemForm> {
  final formKey = GlobalKey<FormState>();
  late final nameTextControler = TextEditingController(
    text: widget.item.name,
  );
  late final descriptionTextController = TextEditingController(
    text: widget.item.description,
  );
  late final priceTextController = TextEditingController(
    text: '${widget.item.price}',
  );

  late final valueListenable = ValueNotifier<String?>(
    widget.item.categoryId,
  );

  File? selectedImage;

  final nameFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final priceFocusNode = FocusNode();

  @override
  void dispose() {
    nameTextControler.dispose();
    descriptionTextController.dispose();
    priceTextController.dispose();
    nameFocusNode.dispose();
    descriptionFocusNode.dispose();
    priceFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 16,
              children: [
                Column(
                  crossAxisAlignment: .start,
                  spacing: 8,
                  children: [
                    ImageUploadField(
                      selectedImage: selectedImage,
                      onImageSelected: (image) {
                        setState(() {
                          selectedImage = image;
                        });
                      },
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: selectedImage != null
                              ? Image.file(
                                  selectedImage!,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  widget.item.imageUrl,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedImage = null;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: context.colors.onSurface,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Iconsax.close_circle,
                                color: context.colors.surface,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                CategoryDropdownField(
                  valueListenable: valueListenable,
                ),
                AppTextFormField(
                  title: 'Tên món',
                  controller: nameTextControler,
                  focusNode: nameFocusNode,
                  hintText: 'Nhập tên món mới',
                  onFieldSubmitted: (value) {
                    descriptionFocusNode.requestFocus();
                  },
                ),
                AppTextFormField(
                  title: 'Mô tả món',
                  controller: descriptionTextController,
                  focusNode: descriptionFocusNode,
                  hintText: 'Thêm mô tả cho món mới',
                  maxLines: 5,
                ),
                AppTextFormField(
                  title: 'Giá tiền',
                  controller: priceTextController,
                  focusNode: priceFocusNode,
                  hintText: 'Nhập giá tiền cho món mới',
                  validator: (value) {
                    if (value == null) {
                      return 'Vui lòng nhập giá tiền';
                    }

                    if (!value.isInt) {
                      return 'Giá tiền không hợp lệ';
                    }

                    return null;
                  },
                  onFieldSubmitted: (value) {},
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BlocBuilder<MenuItemBloc, MenuItemState>(
        builder: (context, state) {
          return BottomFormAction(
            isLoading: state is MenuItemLoading,
            onSubmmited: () {
              if (formKey.currentState!.validate()) {
                FocusScope.of(context).unfocus();
                context.read<MenuItemBloc>().add(
                  UpdateMenuItem(
                    UpdateMenuItemParams(
                      id: widget.id,
                      categoryId: valueListenable.value,
                      name: nameTextControler.text.trim(),
                      description: descriptionTextController.text
                          .trim(),
                      price: int.parse(
                        priceTextController.text.trim(),
                      ),
                      file: selectedImage,
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
