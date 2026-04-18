import 'package:flutter/material.dart';

class ConfirmInvitationPage extends StatelessWidget {
  const ConfirmInvitationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const .all(16),
        child: Column(
          children: [
            Text('Bạn được mời tham gia vào cửa hàng A với vai trò là B'),
            Row(
              mainAxisAlignment: .spaceBetween,
              spacing: 16,
              children: [
                Text('Huỷ lời mời'),
                Text('Đồng ý'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
