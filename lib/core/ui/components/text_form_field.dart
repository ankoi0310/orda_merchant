import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    required this.title,
    required this.controller,
    required this.focusNode,
    this.isRequired = true,
    this.enabled = true,
    this.maxLines = 1,
    this.hintText,
    this.onFieldSubmitted,
    this.validator,
    super.key,
  });

  final String title;
  final bool isRequired;
  final bool enabled;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? hintText;
  final int? maxLines;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text.rich(
          TextSpan(
            text: title,
            children: [
              if (isRequired)
                TextSpan(
                  text: '*',
                  style: TextStyle(color: context.colors.error),
                ),
            ],
            style: context.textTheme.bodyLarge,
          ),
        ),
        TextFormField(
          enabled: enabled,
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(hintText: hintText),
          maxLines: maxLines,
          onFieldSubmitted: onFieldSubmitted,
          selectAllOnFocus: true,
          enableInteractiveSelection: true,
          textCapitalization: TextCapitalization.sentences,
          autovalidateMode: AutovalidateMode.onUserInteractionIfError,
          validator: validator,
        ),
      ],
    );
  }
}

class AppPasswordFormField extends StatefulWidget {
  const AppPasswordFormField({
    required this.controller,
    required this.focusNode,
    this.enabled = true,
    this.onFieldSubmitted,
    super.key,
  });

  final bool enabled;
  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String)? onFieldSubmitted;

  @override
  State<AppPasswordFormField> createState() =>
      _AppPasswordFormFieldState();
}

class _AppPasswordFormFieldState extends State<AppPasswordFormField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text('Mật khẩu', style: context.textTheme.bodyLarge),
        TextFormField(
          enabled: widget.enabled,
          controller: widget.controller,
          focusNode: widget.focusNode,
          obscureText: isObscure,
          decoration: InputDecoration(
            hintText: 'Nhập mật khẩu của bạn',
            suffixIcon: GestureDetector(
              onTap: () => setState(() {
                isObscure = !isObscure;
              }),
              child: Icon(
                isObscure ? Iconsax.eye_slash_copy : Iconsax.eye_copy,
              ),
            ),
          ),
          onFieldSubmitted: widget.onFieldSubmitted,
          selectAllOnFocus: true,
          enableInteractiveSelection: true,
          autovalidateMode: AutovalidateMode.onUserInteractionIfError,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Mật khẩu không được để trống';
            }

            return null;
          },
        ),
      ],
    );
  }
}
