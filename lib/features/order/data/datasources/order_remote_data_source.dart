import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/order/data/models/order_model.dart';
import 'package:orda_merchant/features/order/domain/entities/order.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class OrderRemoteDataSource {
  Stream<List<OrderModel>> watchUpcomingOrders(String shopId);

  Future<List<OrderModel>> getOrderHistory(String shopId);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  const OrderRemoteDataSourceImpl({required this.client});

  final SupabaseClient client;

  @override
  Stream<List<OrderModel>> watchUpcomingOrders(String shopId) async* {
    await for (final rows
        in client
            .from('orders')
            .stream(primaryKey: ['id'])
            .eq('shop_id', shopId)) {
      final orders = rows
          .where(
            (row) =>
                ['confirmed', 'preparing'].contains(row['status']),
          )
          // .map(OrderModel.fromJson)
          .toList();

      final orderIds = orders.map((order) => order['id']).toList();

      if (orderIds.isEmpty) {
        yield [];
        continue;
      }

      final itemRows = await client
          .from('order_items')
          .select()
          .inFilter('order_id', orderIds);
      final itemsByOrderId = <String, List<JsonData>>{};
      for (final itemRow in itemRows) {
        final orderId = itemRow['order_id'] as String;
        itemsByOrderId.putIfAbsent(orderId, () => []).add(itemRow);
      }

      yield orders.map((order) {
        final orderId = order['id'] as String;
        final items = itemsByOrderId[orderId] ?? [];
        return OrderModel.fromJson({...order, 'order_items': items});
      }).toList();
    }
  }

  @override
  Future<List<OrderModel>> getOrderHistory(String shopId) async {
    final orders = await client
        .from('orders')
        .select('*, order_items(*)')
        .eq('shop_id', shopId)
        .inFilter('status', [
          OrderStatus.cancelled.name,
          OrderStatus.completed.name,
        ])
        .order('created_at', ascending: false)
        .withConverter<List<OrderModel>>((jsonList) {
          return List.of(jsonList).map(OrderModel.fromJson).toList();
        });

    return orders;
  }
}
