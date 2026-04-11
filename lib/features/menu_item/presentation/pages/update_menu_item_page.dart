import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:orda_merchant/core/ui/components/loading_widget.dart';
import 'package:orda_merchant/core/utils/app_util.dart';
import 'package:orda_merchant/features/menu_item/domain/entities/menu_item.dart';
import 'package:orda_merchant/features/menu_item/presentation/bloc/menu_item/menu_item_bloc.dart';
import 'package:orda_merchant/features/menu_item/presentation/widgets/update_menu_item_form.dart';

class UpdateMenuItemPage extends StatelessWidget {
  const UpdateMenuItemPage({
    required this.id,
    required this.item,
    super.key,
  });

  final String id;
  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: context.pop),
        title: const Text('Cập nhật món'),
        centerTitle: true,
      ),
      body: BlocConsumer<MenuItemBloc, MenuItemState>(
        listener: (context, state) {
          if (state is MenuItemError) {
            showSnackBar(context, content: state.message);
          }

          if (state is MenuItemSuccess) {
            showSnackBar(context, content: 'Cập nhật món thành công');
            context.pop();
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              UpdateMenuItemForm(id: id, item: item),
              if (state is MenuItemLoading)
                const LoadingWidget(text: 'Đang cập nhật món..'),
            ],
          );
        },
      ),
    );
  }
}
