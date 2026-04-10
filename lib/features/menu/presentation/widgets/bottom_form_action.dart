import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';

class BottomFormAction extends StatelessWidget {
  const BottomFormAction({
    required this.isLoading,
    required this.onSubmmited,
    this.hasCancelButton = true,
    super.key,
  });

  final bool isLoading;
  final void Function() onSubmmited;
  final bool hasCancelButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: context.colors.surface,
        boxShadow: [
          BoxShadow(
            color: context.colors.shadow.withValues(alpha: 0.2),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          spacing: 8,
          children: [
            if (hasCancelButton)
              Expanded(
                child: ElevatedButton(
                  onPressed: () => context.pop(),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(),
                    ),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    foregroundColor: context.colors.onSurface,
                  ),
                  child: const Text('Huỷ'),
                ),
              ),
            Expanded(
              child: ElevatedButton(
                onPressed: isLoading ? null : onSubmmited,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                  backgroundColor: context.colors.primary,
                  disabledBackgroundColor: context.colors.primary
                      .withValues(alpha: 0.5),
                  disabledForegroundColor: context.colors.onPrimary
                      .withValues(alpha: 0.5),
                ),
                child: const Text('Xác nhận'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
