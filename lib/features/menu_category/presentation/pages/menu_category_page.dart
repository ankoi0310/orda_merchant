import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda_merchant/config/router/app_router.dart';
import 'package:orda_merchant/features/menu_category/presentation/bloc/menu_category_list/menu_category_list_cubit.dart';

class MenuCategoryPage extends StatefulWidget {
  const MenuCategoryPage({super.key});

  @override
  State<MenuCategoryPage> createState() => _MenuCategoryPageState();
}

class _MenuCategoryPageState extends State<MenuCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: context.pop),
        title: const Text('Quản lý nhóm thực đơn'),
        actionsPadding: const EdgeInsets.only(right: 16),
        actions: [
          GestureDetector(
            onTap: () => context.push(AppRouter.addMenuCategory),
            child: const Icon(Iconsax.add_circle_copy),
          ),
        ],
      ),
      body: BlocBuilder<MenuCategoryListCubit, MenuCategoryListState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.isError) {
            return Center(child: Text(state.error!));
          }

          return SingleChildScrollView(
            child: Column(
              children: state.categories.map((category) {
                return Text(category.name);
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
