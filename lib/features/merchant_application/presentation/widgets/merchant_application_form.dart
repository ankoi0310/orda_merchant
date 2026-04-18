import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/core/ui/components/text_form_field.dart';
import 'package:orda_merchant/features/auth/presentation/bloc/auth_bloc.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  final passwordController = TextEditingController();
  final nameFocusNode = FocusNode();
  final addressFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    descriptionController.dispose();
    passwordController.dispose();
    nameFocusNode.dispose();
    addressFocusNode.dispose();
    descriptionFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      context.read<AuthBloc>().add(
        SignUpWithEmailPassword(
          fullName: nameController.text.trim(),
          email: addressController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: .stretch,
            spacing: 16,
            children: [
              Text(
                'Thông tin cửa hàng',
                style: context.textTheme.titleLarge,
              ),
              Column(
                spacing: 12,
                children: [
                  AppTextFormField(
                    title: 'Tên cửa hàng',
                    enabled: state is! AuthLoading,
                    controller: nameController,
                    focusNode: nameFocusNode,
                    hintText: 'Nhập tên cửa hàng của bạn',
                    onFieldSubmitted: (value) {
                      addressFocusNode.requestFocus();
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        nameFocusNode.requestFocus();
                        return 'Tên cửa hàng Không được để trống';
                      }

                      return null;
                    },
                  ),
                  AppTextFormField(
                    title: 'Địa chỉ',
                    enabled: state is! AuthLoading,
                    controller: addressController,
                    focusNode: addressFocusNode,
                    hintText: 'Nhập địa chỉ cửa hàng',
                    onFieldSubmitted: (value) {
                      descriptionFocusNode.requestFocus();
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        addressFocusNode.requestFocus();
                        return 'Địa chỉ Không được để trống';
                      }

                      return null;
                    },
                  ),
                  AppTextFormField(
                    title: 'Mô tả',
                    isRequired: false,
                    enabled: state is! AuthLoading,
                    controller: descriptionController,
                    focusNode: descriptionFocusNode,
                    maxLines: 4,
                    hintText: 'Mô tả cửa hàng của bạn',
                  ),
                ],
              ),
              Padding(
                padding: const .only(top: 16),
                child: ElevatedButton(
                  onPressed: state is AuthLoading ? null : _onSubmit,
                  child: const Text('Đăng ký'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
