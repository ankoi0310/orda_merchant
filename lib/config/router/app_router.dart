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
import 'package:orda_merchant/features/menu_category/presentation/bloc/menu_category_list/menu_category_list_cubit.dart';
import 'package:orda_merchant/features/menu_category/presentation/pages/add_menu_category_page.dart';
import 'package:orda_merchant/features/menu_category/presentation/pages/edit_menu_category_page.dart';
import 'package:orda_merchant/features/menu_category/presentation/pages/menu_category_page.dart';
import 'package:orda_merchant/features/menu_item/domain/entities/menu_item.dart';
import 'package:orda_merchant/features/menu_item/presentation/bloc/menu_item/menu_item_bloc.dart';
import 'package:orda_merchant/features/menu_item/presentation/bloc/menu_item_list/menu_item_list_cubit.dart';
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
          ShellRoute(
            builder: (context, state, child) {
              final shopId = context
                  .read<SessionCubit>()
                  .state
                  .shopId;
              return BlocProvider(
                create: (context) =>
                    sl<MenuCategoryListCubit>()
                      ..startWatchingMenuCategories(shopId!),
                child: child,
              );
            },
            routes: [
              GoRoute(
                path: menu,
                builder: (context, state) {
                  final shopId = context
                      .read<SessionCubit>()
                      .state
                      .shopId;
                  return BlocProvider(
                    create: (context) =>
                        sl<MenuItemListCubit>()
                          ..startWatchingMenuItems(shopId!),
                    child: const MenuPage(),
                  );
                },
                routes: [
                  GoRoute(
                    path: item,
                    builder: (context, state) {
                      final shopId = context
                          .read<SessionCubit>()
                          .state
                          .shopId;
                      return BlocProvider(
                        create: (context) =>
                            sl<MenuItemListCubit>()
                              ..startWatchingMenuItems(shopId!),
                        child: const MenuItemPage(),
                      );
                    },
                    routes: [
                      ShellRoute(
                        builder: (context, state, child) {
                          return BlocProvider(
                            create: (context) {
                              final shopId = context
                                  .read<SessionCubit>()
                                  .state
                                  .shopId;
                              return sl<MenuCategoryListCubit>()
                                ..startWatchingMenuCategories(
                                  shopId!,
                                );
                            },
                          );
                        },
                        routes: [
                          GoRoute(
                            path: 'add',
                            builder: (context, state) => BlocProvider(
                              create: (context) => sl<MenuItemBloc>(),
                              child: const AddMenuItemPage(),
                            ),
                          ),
                          GoRoute(
                            path: ':id/edit',
                            builder: (context, state) {
                              final id = state.pathParameters['id']!;
                              final item = state.extra! as MenuItem;
                              return BlocProvider(
                                create: (context) =>
                                    sl<MenuItemBloc>(),
                                child: UpdateMenuItemPage(
                                  id: id,
                                  item: item,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  GoRoute(
                    path: category,
                    builder: (_, _) => const MenuCategoryPage(),
                    routes: [
                      GoRoute(
                        path: 'add',
                        builder: (_, _) => BlocProvider(
                          create: (context) => sl<MenuCategoryBloc>(),
                          child: const AddMenuCategoryPage(),
                        ),
                      ),
                      GoRoute(
                        path: ':id/edit',
                        builder: (_, _) => BlocProvider(
                          create: (context) => sl<MenuCategoryBloc>(),
                          child: const EditMenuCategoryPage(),
                        ),
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
