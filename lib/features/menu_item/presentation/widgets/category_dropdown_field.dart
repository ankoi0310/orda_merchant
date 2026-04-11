import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/features/menu_category/presentation/bloc/menu_category_list/menu_category_list_bloc.dart';

class CategoryDropdownField extends StatelessWidget {
  const CategoryDropdownField({
    required this.valueListenable,
    super.key,
  });

  final ValueNotifier<String?> valueListenable;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text.rich(
          TextSpan(
            text: 'Phân loại',
            children: [
              TextSpan(
                text: '*',
                style: TextStyle(color: context.colors.error),
              ),
            ],
            style: context.textTheme.bodyLarge,
          ),
        ),
        BlocConsumer<MenuCategoryListBloc, MenuCategoryListState>(
          listener: (context, state) {
            if (state.isLoaded && valueListenable.value == null) {
              valueListenable.value = state.categories.first.id;
            }
          },
          builder: (context, state) {
            if (state.isLoaded &&
                valueListenable.value == null &&
                state.categories.isNotEmpty) {
              valueListenable.value = state.categories.first.id;
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
    );
  }
}
