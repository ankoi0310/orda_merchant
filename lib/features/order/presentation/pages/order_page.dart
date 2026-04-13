import 'package:flutter/material.dart';
import 'package:orda_merchant/core/extensions/build_context_extension.dart';
import 'package:orda_merchant/features/order/presentation/widgets/order_history_tab.dart';
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
          children: const [UpcomingOrdersTab(), OrderHistoryTab()],
        ),
      ),
    );
  }
}
