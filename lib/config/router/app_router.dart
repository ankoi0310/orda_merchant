import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:orda_merchant/config/router/session_listenable.dart';
import 'package:orda_merchant/core/bloc/session/session_cubit.dart';
import 'package:orda_merchant/core/ui/layout/main_layout.dart';
import 'package:orda_merchant/di.dart';
import 'package:orda_merchant/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:orda_merchant/features/auth/presentation/pages/login_page.dart';
import 'package:orda_merchant/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:orda_merchant/features/menu/presentation/pages/menu_page.dart';
import 'package:orda_merchant/features/menu_category/presentation/bloc/menu_category/menu_category_bloc.dart';
import 'package:orda_merchant/features/menu_category/presentation/bloc/menu_category_list/menu_category_list_bloc.dart';
import 'package:orda_merchant/features/menu_category/presentation/pages/add_menu_category_page.dart';
import 'package:orda_merchant/features/menu_category/presentation/pages/edit_menu_category_page.dart';
import 'package:orda_merchant/features/menu_category/presentation/pages/menu_category_page.dart';
import 'package:orda_merchant/features/menu_item/presentation/bloc/menu_item/menu_item_bloc.dart';
import 'package:orda_merchant/features/menu_item/presentation/bloc/menu_item_list/menu_item_list_bloc.dart';
import 'package:orda_merchant/features/menu_item/presentation/pages/add_menu_item_page.dart';
import 'package:orda_merchant/features/menu_item/presentation/pages/menu_item_page.dart';
import 'package:orda_merchant/features/menu_item/presentation/pages/update_menu_item_page.dart';
import 'package:orda_merchant/features/order/presentation/pages/order_page.dart';
import 'package:orda_merchant/features/shop/presentation/pages/shop_page.dart';
import 'package:orda_merchant/features/user/presentation/pages/user_profile_page.dart';

class AppRouter {
  static const String login = '/login';
  static const String register = '/register';
  static const String dashboard = '/dashboard';
  static const String order = '/order';
  static const String shop = '/shop';
  static const String menu = '/menu';
  static const String item = '/item';
  static const String menuItem = '$menu$item';
  static const String addMenuItem = '$menu$item/add';

  static String updateMenuItem(String id) => '$menu$item/$id/edit';
  static const String category = '/category';
  static const String menuCategory = '$menu$category';
  static const String addMenuCategory = '$menu$category/add';

  static String updateMenuCategory(String id) =>
      '$menu$category/$id/edit';
  static const String profile = '/profile';

  static final config = GoRouter(
    initialLocation: login,
    refreshListenable: SessionListenable(sl<SessionCubit>().stream),
    routes: [
      GoRoute(
        path: login,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const LoginPage(),
        ),
      ),
      ShellRoute(
        builder: (context, state, child) => MainLayout(child: child),
        routes: [
          GoRoute(
            path: dashboard,
            builder: (context, state) => const DashboardPage(),
          ),
          GoRoute(
            path: order,
            builder: (context, state) => const OrderPage(),
          ),
          GoRoute(
            path: shop,
            builder: (context, state) => const ShopPage(),
          ),
          GoRoute(
            path: menu,
            builder: (context, state) => const MenuPage(),
            routes: [
              ShellRoute(
                builder: (context, state, child) {
                  return BlocListener<SessionCubit, SessionState>(
                    listenWhen: (prev, curr) =>
                        prev.shopId != curr.shopId,
                    listener: (context, state) {
                      if (state.shopId != null) {
                        print('STATE: $state');
                      }
                    },
                    child: BlocProvider.value(
                      value: sl<MenuCategoryListBloc>(),
                      child: child,
                    ),
                  );
                },
                routes: [
                  GoRoute(
                    path: item,
                    builder: (context, state) => BlocProvider(
                      create: (context) => sl<MenuItemListBloc>(),
                      child: const MenuItemPage(),
                    ),
                    routes: [
                      ShellRoute(
                        builder: (_, _, child) => BlocProvider.value(
                          value: sl<MenuItemBloc>(),
                          child: child,
                        ),
                        routes: [
                          GoRoute(
                            path: 'add',
                            builder: (context, state) =>
                                const AddMenuItemPage(),
                          ),
                          GoRoute(
                            path: ':id/edit',
                            builder: (context, state) =>
                                const UpdateMenuItemPage(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GoRoute(
                    path: category,
                    builder: (_, _) => const MenuCategoryPage(),
                    routes: [
                      ShellRoute(
                        builder: (context, state, child) =>
                            BlocProvider(
                              create: (context) =>
                                  sl<MenuCategoryBloc>(),
                              child: child,
                            ),
                        routes: [
                          GoRoute(
                            path: 'add',
                            builder: (_, _) =>
                                const AddMenuCategoryPage(),
                          ),
                          GoRoute(
                            path: ':id/edit',
                            builder: (_, _) =>
                                const EditMenuCategoryPage(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: profile,
            builder: (context, state) => const UserProfilePage(),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final authState = sl<SessionCubit>().state;

      final isLogin = state.matchedLocation == login;

      /// Nếu chưa đăng nhập
      if (!authState.isAuthenticated) {
        return isLogin ? null : login;
      }

      /// Nếu đã đăng nhập
      if (authState.isAuthenticated) {
        if (isLogin) {
          return dashboard;
        }
        return null;
      }

      return null;
    },
  );
}
