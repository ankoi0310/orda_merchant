import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:orda_merchant/core/ui/components/loading_widget.dart';
import 'package:orda_merchant/core/utils/app_util.dart';
import 'package:orda_merchant/features/menu_item/presentation/bloc/menu_item/menu_item_bloc.dart';
import 'package:orda_merchant/features/menu_item/presentation/widgets/add_menu_item_form.dart';

class AddMenuItemPage extends StatelessWidget {
  const AddMenuItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: context.pop),
        title: const Text('Thêm món mới'),
        centerTitle: true,
      ),
      body: BlocConsumer<MenuItemBloc, MenuItemState>(
        listener: (context, state) {
          if (state is MenuItemError) {
            showSnackBar(context, content: state.message);
          }

          if (state is MenuItemSuccess) {
            showSnackBar(context, content: 'Thêm món mới thành công');
            context.pop();
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              const AddMenuItemForm(),
              if (state is MenuItemLoading)
                const LoadingWidget(text: 'Đang thêm món..'),
            ],
          );
        },
      ),
    );
  }
}
