import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/core/bloc/session/session_cubit.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/core/extensions/string_extension.dart';
import 'package:orda_merchant/core/ui/components/text_form_field.dart';
import 'package:orda_merchant/features/menu/presentation/widgets/bottom_form_action.dart';
import 'package:orda_merchant/features/menu_category/presentation/bloc/menu_category_list/menu_category_list_bloc.dart';
import 'package:orda_merchant/features/menu_item/domain/usecases/create_menu_item_use_case.dart';
import 'package:orda_merchant/features/menu_item/presentation/bloc/menu_item/menu_item_bloc.dart';
import 'package:orda_merchant/features/menu_item/presentation/widgets/image_upload_field.dart';

class AddMenuItemForm extends StatefulWidget {
  const AddMenuItemForm({super.key});

  @override
  State<AddMenuItemForm> createState() => _AddMenuItemFormState();
}

class _AddMenuItemFormState extends State<AddMenuItemForm> {
  final formKey = GlobalKey<FormState>();
  final nameTextControler = TextEditingController();
  final descriptionTextController = TextEditingController();
  final priceTextController = TextEditingController();

  final nameFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final priceFocusNode = FocusNode();

  final valueListenable = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();

    final shopId = context.read<SessionCubit>().state.shopId;
    if (shopId != null) {
      context.read<MenuCategoryListBloc>().add(
        EnsureCategoriesLoaded(shopId: shopId),
      );
    }
  }

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
    final shopId = context.read<SessionCubit>().state.shopId;

    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 16,
              children: [
                const ImageUploadField(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      'Phân loại',
                      style: context.textTheme.bodyLarge,
                    ),
                    BlocConsumer<
                      MenuCategoryListBloc,
                      MenuCategoryListState
                    >(
                      listener: (context, state) {
                        if (state.isLoaded &&
                            valueListenable.value == null) {
                          valueListenable.value =
                              state.categories.first.id;
                        }
                      },
                      builder: (context, state) {
                        if (state.isLoaded &&
                            valueListenable.value == null &&
                            state.categories.isNotEmpty) {
                          valueListenable.value =
                              state.categories.first.id;
                        }
                        return DropdownButtonFormField2(
                          valueListenable: valueListenable,
                          onChanged: (value) {
                            valueListenable.value = value;
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                          ),
                          items: state.categories.map((category) {
                            return DropdownItem<String>(
                              value: category.id,
                              child: Text(category.name),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
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
                  CreateMenuItem(
                    CreateMenuItemParams(
                      shopId: shopId,
                      categoryId: valueListenable.value,
                      name: nameTextControler.text.trim(),
                      description: descriptionTextController.text
                          .trim(),
                      price: int.parse(
                        priceTextController.text.trim(),
                      ),
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
