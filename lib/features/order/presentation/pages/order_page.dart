import 'package:flutter/material.dart';

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
        title: const Text('Order'),
        centerTitle: true,
        titleSpacing: 0,
        bottom: TabBar(
          controller: _tabController,
          // indicator: BoxDecoration(
          //   borderRadius: BorderRadius.circular(20),
          //   color: Colors.black,
          // ),
          // labelColor: Colors.white,
          // unselectedLabelColor: Colors.black,
          tabs: const [
            Tab(text: 'Current'),
            Tab(text: 'Finished'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
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
                          top: false,
                          maintainBottomViewPadding: true,
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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    await showModalBottomSheet<void>(
                      context: context,
                      shape: RoundedRectangleBorder(
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
    );
  }
}
