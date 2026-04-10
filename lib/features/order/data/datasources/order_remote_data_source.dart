import 'package:orda_merchant/features/order/data/models/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> fetchOrders();
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  const OrderRemoteDataSourceImpl({required this.client});

  final SupabaseClient client;

  @override
  Future<List<OrderModel>> fetchOrders() async {
    final orders = await client
        .from('orders')
        .select()
        .withConverter<List<OrderModel>>((jsonList) {
          return List.of(jsonList).map(OrderModel.fromJson).toList();
        });

    return orders;
  }
}
