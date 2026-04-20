import 'package:flutter/material.dart';

class ShopMemberPage extends StatelessWidget {
  const ShopMemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thành viên cửa hàng')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const .symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Thêm thành viên'),
                    ),
                  ],
                ),
                const Text('Danh sách thành viên...'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
