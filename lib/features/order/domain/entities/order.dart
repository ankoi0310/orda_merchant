import 'package:equatable/equatable.dart';

class Order extends Equatable {
  const Order({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}
