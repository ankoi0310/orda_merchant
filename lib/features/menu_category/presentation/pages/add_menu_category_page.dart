import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/core/ui/components/loading_widget.dart';
import 'package:orda_merchant/core/utils/app_util.dart';
import 'package:orda_merchant/features/menu_category/presentation/bloc/menu_category/menu_category_bloc.dart';
import 'package:orda_merchant/features/menu_category/presentation/widgets/add_menu_category_form.dart';

class AddMenuCategoryPage extends StatelessWidget {
  const AddMenuCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCategoryBloc, MenuCategoryState>(
      listener: (context, state) {
        if (state is MenuCategoryError) {
          showSnackBar(context, content: state.message);
        }

        if (state is MenuCategorySuccess) {
          showSnackBar(context, content: 'Thêm nhóm mới thành công');
          context.pop();
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: const Text('Thêm nhóm mới'),
                centerTitle: true,
                elevation: 2,
                shadowColor: context.colors.shadow,
              ),
              body: const AddCategoryForm(),
            ),
            if (state is MenuCategoryLoading)
              const LoadingWidget(text: 'Đang thêm nhóm..'),
          ],
        );
      },
    );
  }
}
