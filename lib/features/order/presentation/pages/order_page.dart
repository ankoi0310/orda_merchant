import 'package:flutter/material.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/features/order/presentation/widgets/upcoming_orders_tab.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    const length = 20;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý đơn hàng'),
        centerTitle: true,
        titleSpacing: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          // labelColor: Colors.white,
          // unselectedLabelColor: Colors.black,
          splashFactory: NoSplash.splashFactory,
          labelStyle: context.textTheme.bodyLarge,
          unselectedLabelStyle: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w500,
          ),
          tabs: const [
            Tab(text: 'Hiện tại'),
            Tab(text: 'Lịch sử'),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            const UpcomingOrdersTab(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      await showModalBottomSheet<void>(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadiusGeometry.directional(
                                topStart: Radius.circular(16),
                                topEnd: Radius.circular(16),
                              ),
                        ),
                        builder: (context) {
                          return SafeArea(
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16),
                              child: Text('order detail'),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 16,
                        bottom: index == length - 1 ? 16 : 0,
                      ),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.red),
                      child: Text('Order $index'),
                    ),
                  );
                },
                itemCount: length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
