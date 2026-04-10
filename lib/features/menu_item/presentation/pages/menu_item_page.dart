import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda_merchant/config/router/app_router.dart';

class MenuItemPage extends StatelessWidget {
  const MenuItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: context.pop),
        titleSpacing: 0,
        title: const Text('Danh sách món'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 8,
              ),
              child: Column(
                spacing: 4,
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Tìm kiếm món',
                            prefixIcon: const Icon(
                              Iconsax.search_normal_copy,
                            ),
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      IntrinsicHeight(
                        child: IntrinsicWidth(
                          child: IconButton.outlined(
                            icon: const Icon(Iconsax.add_copy),
                            style: IconButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  8,
                                ),
                              ),
                            ),
                            onPressed: () => context.push(
                              '${AppRouter.menuItem}/add',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    spacing: 8,
                    children: [
                      Chip(label: Text('Status')),
                      Chip(label: Text('Category')),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ListView.separated(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        spacing: 8,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            spacing: 4,
                            children: [
                              Text(
                                'Product Name $index',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text('Category $index'),
                              Text('Status $index'),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.grey[300],
                      thickness: 1,
                      height: 1,
                      indent: 16,
                      endIndent: 16,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
