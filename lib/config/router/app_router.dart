import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:orda_merchant/app_bootstrapper.dart';
import 'package:orda_merchant/config/router/session_listenable.dart';
import 'package:orda_merchant/core/bloc/session/session_cubit.dart';
import 'package:orda_merchant/core/bloc/user_setup/user_setup_cubit.dart';
import 'package:orda_merchant/core/ui/pages/splash_page.dart';
import 'package:orda_merchant/core/ui/pages/welcome_page.dart';
import 'package:orda_merchant/di.dart';
import 'package:orda_merchant/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:orda_merchant/features/analytics/presentation/pages/analytics_page.dart';
import 'package:orda_merchant/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:orda_merchant/features/auth/presentation/pages/sign_in_page.dart';
import 'package:orda_merchant/features/auth/presentation/pages/sign_up_page.dart';
import 'package:orda_merchant/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:orda_merchant/features/invitation/presentation/pages/invitation_page.dart';
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
import 'package:orda_merchant/features/merchant_application/presentation/bloc/merchant_application_bloc.dart';
import 'package:orda_merchant/features/merchant_application/presentation/pages/merchant_application_page.dart';
import 'package:orda_merchant/features/order/presentation/bloc/upcoming_orders/upcoming_orders_cubit.dart';
import 'package:orda_merchant/features/order/presentation/pages/order_page.dart';
import 'package:orda_merchant/features/setting/presentation/pages/setting_page.dart';
import 'package:orda_merchant/features/shop/presentation/bloc/shop/shop_bloc.dart';
import 'package:orda_merchant/features/shop/presentation/pages/shop_page.dart';
import 'package:orda_merchant/features/shop_member/presentation/pages/shop_member_page.dart';
import 'package:orda_merchant/features/user/presentation/pages/user_profile_page.dart';

class AppRouter {
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String invitation = '/invitation';
  static const String login = '/login';
  static const String register = '/register';
  static const String dashboard = '/dashboard';
  static const String order = '/order';
  static const String shop = '/shop';
  static const String merchantApplication = '/merchant-application';
  static const String member = '/member';
  static const String setting = '/setting';
  static const String analytics = '/analytics';
  static const String account = '/account';
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

  static List<String> publicRoutes = [login, register];

  static final config = GoRouter(
    refreshListenable: Listenable.merge([
      BlocListenable(sl<SessionCubit>()),
      BlocListenable(sl<UserSetupCubit>()),
    ]),
    routes: [
      ShellRoute(
        builder: (context, state, child) =>
            AppBootstrapper(child: child),
        routes: [
          GoRoute(
            path: splash,
            builder: (context, state) => const SplashPage(),
          ),
          GoRoute(
            path: welcome,
            builder: (context, state) => const WelcomePage(),
          ),
          GoRoute(
            path: invitation,
            builder: (context, state) => const InvitationPage(),
          ),
          GoRoute(
            path: register,
            builder: (context, state) => BlocProvider(
              create: (_) => sl<AuthBloc>(),
              child: const SignUpPage(),
            ),
          ),
          GoRoute(
            path: login,
            builder: (context, state) => BlocProvider(
              create: (_) => sl<AuthBloc>(),
              child: const SignInPage(),
            ),
          ),
          GoRoute(
            path: dashboard,
            builder: (context, state) => BlocProvider(
              create: (context) => sl<AnalyticsBloc>(),
              child: const DashboardPage(),
            ),
          ),
          GoRoute(
            path: order,
            builder: (context, state) {
              final shop = context.read<ShopBloc>().state.shop;
              return BlocProvider(
                create: (context) =>
                    sl<UpcomingOrdersCubit>()
                      ..startWatchingUpcomingOrders(shop!.id),
                child: const OrderPage(),
              );
            },
          ),
          GoRoute(
            path: merchantApplication,
            builder: (context, state) => BlocProvider(
              create: (context) => sl<MerchantApplicationBloc>(),
              child: const MerchantApplicationPage(),
            ),
          ),
          GoRoute(
            path: shop,
            builder: (context, state) => const ShopPage(),
          ),
          GoRoute(
            path: member,
            builder: (context, state) => const ShopMemberPage(),
          ),
          GoRoute(
            path: setting,
            builder: (context, state) => const SettingPage(),
          ),
          ShellRoute(
            builder: (context, state, child) {
              final shop = context.read<ShopBloc>().state.shop;
              return BlocProvider(
                create: (context) =>
                    sl<MenuCategoryListCubit>()
                      ..startWatchingMenuCategories(shop!.id),
                child: child,
              );
            },
            routes: [
              GoRoute(
                path: menu,
                builder: (context, state) {
                  final shop = context.read<ShopBloc>().state.shop;
                  return BlocProvider(
                    create: (context) =>
                        sl<MenuItemListCubit>()
                          ..startWatchingMenuItems(shop!.id),
                    child: const MenuPage(),
                  );
                },
                routes: [
                  GoRoute(
                    path: item,
                    builder: (context, state) {
                      final shop = context
                          .read<ShopBloc>()
                          .state
                          .shop;
                      return BlocProvider(
                        create: (context) =>
                            sl<MenuItemListCubit>()
                              ..startWatchingMenuItems(shop!.id),
                        child: const MenuItemPage(),
                      );
                    },
                    routes: [
                      ShellRoute(
                        builder: (context, state, child) {
                          return BlocProvider(
                            create: (context) {
                              final shop = context
                                  .read<ShopBloc>()
                                  .state
                                  .shop;
                              return sl<MenuCategoryListCubit>()
                                ..startWatchingMenuCategories(
                                  shop!.id,
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
            path: account,
            builder: (context, state) => const AccountPage(),
          ),
          GoRoute(
            path: analytics,
            builder: (context, state) => const AnalyticsPage(),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final session = context.read<SessionCubit>().state;
      final setup = context.read<UserSetupCubit>().state;
      final location = state.matchedLocation;

      /// Nếu chưa đăng nhập
      if (session is Unauthenticated) {
        return location == login ? null : login;
      }

      /// Nếu đã đăng nhập
      if (session is Authenticated) {
        if (setup is UserSetupInitial || setup is UserSetupLoading) {
          return location == splash ? null : splash;
        }

        if (setup is UserSetupNoShop) {
          return location == welcome ? null : welcome;
        }

        if (setup is UserSetupReady) {
          if (location == login ||
              location == splash ||
              location == welcome) {
            return dashboard;
          }
        }
      }

      return null;
    },
  );
}
