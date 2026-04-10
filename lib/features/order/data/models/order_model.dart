import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/order/domain/entities/order.dart';

class OrderModel extends Order {
  const OrderModel({required super.id});

  factory OrderModel.fromJson(JsonData json) {
    return OrderModel(id: json['id'] as String);
  }
}
