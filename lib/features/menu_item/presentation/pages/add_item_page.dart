import 'package:flutter/material.dart';
import 'package:orda_merchant/features/menu/presentation/widgets/bottom_form_action.dart';
import 'package:orda_merchant/features/menu_item/presentation/widgets/add_item_form.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm món mới'),
        centerTitle: true,
      ),
      body: AddItemForm(formKey: formKey),
      bottomNavigationBar: BottomFormAction(
        isLoading: true,
        onSubmmited: () {},
      ),
    );
  }
}
