import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orda_merchant/config/router/app_router.dart';

class NavItem {
  const NavItem({
    required this.label,
    required this.icon,
    required this.route,
  });

  final String label;
  final IconData icon;
  final String route;
}

final List<NavItem> dashboardActions = [
  const NavItem(
    label: 'Đơn hàng',
    icon: Iconsax.receipt_2_1_copy,
    route: AppRouter.order,
  ),
  const NavItem(
    label: 'Cửa hàng',
    icon: Iconsax.shop_copy,
    route: AppRouter.shop,
  ),
  const NavItem(
    label: 'Thực đơn',
    icon: Iconsax.menu_board_copy,
    route: AppRouter.menu,
  ),
  const NavItem(
    label: 'Thống kê',
    icon: Iconsax.chart_copy,
    route: AppRouter.analytics,
  ),
  const NavItem(
    label: 'Nhân viên',
    icon: Iconsax.profile_2user_copy,
    route: AppRouter.member,
  ),
  const NavItem(
    label: 'Cài đặt',
    icon: Iconsax.setting_2_copy,
    route: AppRouter.setting,
  ),
];

final List<NavItem> otherServices = [
  const NavItem(
    label: 'Hỗ trợ',
    icon: Iconsax.support_copy,
    route: AppRouter.order,
  ),
  const NavItem(
    label: 'Cài đặt',
    icon: Iconsax.setting_copy,
    route: AppRouter.order,
  ),
];
