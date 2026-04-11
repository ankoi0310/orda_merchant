import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/core/utils/app_util.dart';

class ImageUploadField extends StatefulWidget {
  const ImageUploadField({
    required this.onImageSelected,
    this.selectedImage,
    super.key,
  });

  final File? selectedImage;
  final void Function(File?) onImageSelected;

  @override
  State<ImageUploadField> createState() => _ImageUploadFieldState();
}

class _ImageUploadFieldState extends State<ImageUploadField> {
  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      final isValid = isImageFile(pickedFile.path);

      if (!isValid) {
        _retrieveDataError = 'Ảnh không đúng định dạng';
      }

      final selectedImage = File(pickedFile.path);

      widget.onImageSelected(selectedImage);
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text('Ảnh', style: context.textTheme.bodyLarge),
        ListTile(
          onTap: pickImage,
          dense: true,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: context.colors.outlineVariant),
            borderRadius: BorderRadius.circular(12),
          ),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.colors.outline,
              shape: BoxShape.circle,
            ),
            child: const Icon(Iconsax.gallery_copy),
          ),
          title: const Text('Thêm ảnh'),
          subtitle: Text(
            widget.selectedImage != null
                ? 'Đã tải lên 1 ảnh'
                : 'Ảnh mặc định sẽ được sử dụng',
          ),
          trailing: const Icon(Iconsax.arrow_right_3_copy),
        ),
        ?_getRetrieveErrorWidget(),
      ],
    );
  }
}
