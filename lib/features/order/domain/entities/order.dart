import 'package:equatable/equatable.dart';
import 'package:orda_merchant/features/order/domain/entities/order_item.dart';

enum OrderStatus {
  confirmed('Đã xác nhận'),
  preparing('Đang chuẩn bị'),
  completed('Hoàn thành'),
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
    required this.createdAt,
    required this.items,
  });

  final String id;
  final String shopId;
  final int orderNumber;
  final String note;
  final int totalPrice;
  final OrderStatus status;
  final DateTime createdAt;
  final List<OrderItem> items;

  int get totalItems =>
      items.fold(0, (sum, item) => sum + item.quantity);

  Order copyWith({
    String? id,
    String? shopId,
    int? orderNumber,
    String? note,
    int? totalPrice,
    OrderStatus? status,
    DateTime? createdAt,
    List<OrderItem>? items,
  }) {
    return Order(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      orderNumber: orderNumber ?? this.orderNumber,
      note: note ?? this.note,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [
    id,
    shopId,
    orderNumber,
    note,
    totalPrice,
    status,
    createdAt,
    items,
  ];
}
