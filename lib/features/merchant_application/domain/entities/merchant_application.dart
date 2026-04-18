import 'package:equatable/equatable.dart';

enum ApplicationStatus {
  pending('Đang chờ duyệt'),
  approved('Đã duyệt'),
  rejected('Bị từ chối');

  const ApplicationStatus(this.label);

  final String label;
}

class MerchantApplication extends Equatable {
  const MerchantApplication({
    required this.id,
    required this.userId,
    required this.shopName,
    required this.description,
    required this.address,
    required this.status,
  });

  final String id;
  final String userId;
  final String shopName;
  final String description;
  final String address;
  final ApplicationStatus status;

  @override
  List<Object?> get props => [
    id,
    userId,
    shopName,
    description,
    address,
    status,
  ];
}
