import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/core/ui/components/text_form_field.dart';
import 'package:orda_merchant/features/menu/presentation/widgets/bottom_form_action.dart';
import 'package:orda_merchant/features/menu_category/presentation/bloc/menu_category/menu_category_bloc.dart';
import 'package:orda_merchant/features/shop/presentation/bloc/shop/shop_bloc.dart';

class AddCategoryForm extends StatefulWidget {
  const AddCategoryForm({super.key});

  @override
  State<AddCategoryForm> createState() => _AddCategoryFormState();
}

class _AddCategoryFormState extends State<AddCategoryForm> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final nameFocusNode = FocusNode();

  @override
  void dispose() {
    nameController.dispose();
    nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shop = context.read<ShopBloc>().state.shop;

    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 16,
              children: [
                AppTextFormField(
                  title: 'Tên nhóm',
                  controller: nameController,
                  focusNode: nameFocusNode,
                  hintText: 'Tên nhóm thực đơn mới',
                  onFieldSubmitted: (value) {
                    nameFocusNode.unfocus();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          BlocBuilder<MenuCategoryBloc, MenuCategoryState>(
            builder: (context, state) {
              return BottomFormAction(
                isLoading: state is MenuCategoryLoading,
                onSubmmited: () {
                  if (formKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    context.read<MenuCategoryBloc>().add(
                      CreateMenuCategory(
                        shopId: shop?.id,
                        name: nameController.text.trim(),
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
