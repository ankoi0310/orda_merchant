import 'package:equatable/equatable.dart';
import 'package:orda_merchant/features/order/domain/entities/order_item.dart';

enum OrderStatus {
  confirmed('Đã xác nhận'),
  preparing('Đang chuẩn bị'),
  completed('Đã hoàn thành'),
  cancelled('Đã hủy');

  const OrderStatus(this.label);

  final String label;
}

class Order extends Equatable {
  const Order({
    required this.id,
    required this.shopId,
    required this.orderNumber,
    required this.note,
    required this.totalPrice,
    required this.status,
    required this.items,
  });

  final String id;
  final String shopId;
  final int orderNumber;
  final String note;
  final int totalPrice;
  final OrderStatus status;
  final List<OrderItem> items;

  int get totalItems =>
      items.fold(0, (sum, item) => sum + item.quantity);

  @override
  List<Object?> get props => [
    id,
    shopId,
    orderNumber,
    note,
    totalPrice,
    status,
    items,
  ];
}
