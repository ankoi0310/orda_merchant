import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:orda_merchant/core/bloc/session/session_cubit.dart';
import 'package:orda_merchant/core/service/shared_prefs_service.dart';
import 'package:orda_merchant/core/service/supabase_storage_service.dart';
import 'package:orda_merchant/features/analytics/data/datasources/analytics_remote_data_source.dart';
import 'package:orda_merchant/features/analytics/data/repositories/analytics_repository_impl.dart';
import 'package:orda_merchant/features/analytics/domain/repositories/analytics_repository.dart';
import 'package:orda_merchant/features/analytics/domain/usecases/get_today_stats_use_case.dart';
import 'package:orda_merchant/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:orda_merchant/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:orda_merchant/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:orda_merchant/features/auth/domain/repositories/auth_repository.dart';
import 'package:orda_merchant/features/auth/domain/usecases/sign_in_with_password_use_case.dart';
import 'package:orda_merchant/features/auth/domain/usecases/sign_up_with_email_password_use_case.dart';
import 'package:orda_merchant/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:orda_merchant/features/invitation/data/datasources/invitation_remote_data_source.dart';
import 'package:orda_merchant/features/invitation/data/repositories/invitation_repository_impl.dart';
import 'package:orda_merchant/features/invitation/domain/repositories/invitation_repository.dart';
import 'package:orda_merchant/features/invitation/domain/usecases/accept_invitation_use_case.dart';
import 'package:orda_merchant/features/invitation/domain/usecases/create_invitation_use_case.dart';
import 'package:orda_merchant/features/invitation/domain/usecases/get_invitation_use_case.dart';
import 'package:orda_merchant/features/invitation/presentation/bloc/invitation_bloc.dart';
import 'package:orda_merchant/features/menu_category/data/datasources/menu_category_remote_data_source.dart';
import 'package:orda_merchant/features/menu_category/data/repositories/menu_category_repository_impl.dart';
import 'package:orda_merchant/features/menu_category/domain/repositories/menu_category_repository.dart';
import 'package:orda_merchant/features/menu_category/domain/usecases/create_menu_category_use_case.dart';
import 'package:orda_merchant/features/menu_category/domain/usecases/watch_menu_categories_use_case.dart';
import 'package:orda_merchant/features/menu_category/presentation/bloc/menu_category/menu_category_bloc.dart';
import 'package:orda_merchant/features/menu_category/presentation/bloc/menu_category_list/menu_category_list_cubit.dart';
import 'package:orda_merchant/features/menu_item/data/datasources/menu_item_remote_data_source.dart';
import 'package:orda_merchant/features/menu_item/data/repositories/menu_item_repository_impl.dart';
import 'package:orda_merchant/features/menu_item/domain/repositories/menu_item_repository.dart';
import 'package:orda_merchant/features/menu_item/domain/usecases/create_menu_item_use_case.dart';
import 'package:orda_merchant/features/menu_item/domain/usecases/update_menu_item_use_case.dart';
import 'package:orda_merchant/features/menu_item/domain/usecases/watch_menu_items_use_case.dart';
import 'package:orda_merchant/features/menu_item/presentation/bloc/menu_item/menu_item_bloc.dart';
import 'package:orda_merchant/features/menu_item/presentation/bloc/menu_item_list/menu_item_list_cubit.dart';
import 'package:orda_merchant/features/merchant_application/data/datasources/merchant_application_remote_data_source.dart';
import 'package:orda_merchant/features/merchant_application/data/repositories/merchant_application_repository_impl.dart';
import 'package:orda_merchant/features/merchant_application/domain/repositories/merchant_application_repository.dart';
import 'package:orda_merchant/features/merchant_application/domain/usecases/register_merchant_use_case.dart';
import 'package:orda_merchant/features/merchant_application/presentation/bloc/merchant_application_bloc.dart';
import 'package:orda_merchant/features/order/data/datasources/order_remote_data_source.dart';
import 'package:orda_merchant/features/order/data/repositories/order_repository_impl.dart';
import 'package:orda_merchant/features/order/domain/repositories/order_repository.dart';
import 'package:orda_merchant/features/order/domain/usecases/confirm_order_complete_use_case.dart';
import 'package:orda_merchant/features/order/domain/usecases/get_order_history_use_case.dart';
import 'package:orda_merchant/features/order/domain/usecases/watch_upcoming_orders_use_case.dart';
import 'package:orda_merchant/features/order/presentation/bloc/history_orders/history_orders_cubit.dart';
import 'package:orda_merchant/features/order/presentation/bloc/upcoming_orders/upcoming_orders_cubit.dart';
import 'package:orda_merchant/features/shop/data/datasources/shop_local_data_source.dart';
import 'package:orda_merchant/features/shop/data/datasources/shop_remote_data_source.dart';
import 'package:orda_merchant/features/shop/data/repositories/shop_repository_impl.dart';
import 'package:orda_merchant/features/shop/domain/repositories/shop_repository.dart';
import 'package:orda_merchant/features/shop/domain/usecases/cache_shop_use_case.dart';
import 'package:orda_merchant/features/shop/domain/usecases/get_cached_shop_use_case.dart';
import 'package:orda_merchant/features/shop/domain/usecases/get_shop_list_use_case.dart';
import 'package:orda_merchant/features/shop/domain/usecases/load_shop_use_case.dart';
import 'package:orda_merchant/features/shop/presentation/bloc/shop/shop_bloc.dart';
import 'package:orda_merchant/features/shop/presentation/bloc/shop_list/shop_list_bloc.dart';
import 'package:orda_merchant/features/user/data/datasource/user_remote_data_source.dart';
import 'package:orda_merchant/features/user/data/repositories/user_repository_impl.dart';
import 'package:orda_merchant/features/user/domain/repositories/user_repository.dart';
import 'package:orda_merchant/features/user/domain/usecases/get_user_profile_use_case.dart';
import 'package:orda_merchant/features/user/domain/usecases/sign_out_use_case.dart';
import 'package:orda_merchant/features/user/presentation/bloc/user_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt sl = GetIt.instance;

Future<void> initInjection() async {
  final prefs = await SharedPreferences.getInstance();

  sl
    ..registerLazySingleton(() => Supabase.instance.client)
    ..registerLazySingleton<SupabaseStorageService>(
      () => SupabaseStorageServiceImpl(client: sl()),
    )
    ..registerLazySingleton(() => FirebaseMessaging.instance)
    ..registerLazySingleton<SharedPrefsService>(
      () => SharedPrefsServiceImpl(prefs),
    )
    ..registerLazySingleton(() => SessionCubit(supabaseClient: sl()));

  _initAuth(sl);
  _initUser(sl);
  _initMerchantApplication(sl);
  _initShop(sl);
  _initMenuCategory(sl);
  _initMenuItem(sl);
  _initOrder(sl);
  _initAnalytics(sl);
  _initInvitation(sl);
}

void _initAuth(GetIt sl) {
  sl
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: sl()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl()),
    )
    ..registerLazySingleton(
      () => SignUpWithEmailPasswordUseCase(repository: sl()),
    )
    ..registerLazySingleton(
      () => SignInWithEmailPasswordUseCase(repository: sl()),
    )
    ..registerFactory(
      () => AuthBloc(
        signUpWithEmailPassword: sl(),
        signInWithEmailPassword: sl(),
      ),
    );
}

void _initUser(GetIt sl) {
  sl
    ..registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()),
    )
    ..registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: sl()),
    )
    ..registerLazySingleton(
      () => GetUserProfileUseCase(repository: sl()),
    )
    ..registerLazySingleton(() => SignOutUseCase(repository: sl()))
    ..registerFactory(
      () => UserBloc(getUserProfile: sl(), signOut: sl()),
    );
}

void _initMerchantApplication(GetIt sl) {
  sl
    ..registerLazySingleton<MerchantApplicationRemoteDataSource>(
      () => MerchantApplicationRemoteDataSourceImpl(client: sl()),
    )
    ..registerLazySingleton<MerchantApplicationRepository>(
      () => MerchantApplicationRepositoryImpl(remoteDataSource: sl()),
    )
    ..registerLazySingleton(
      () => RegisterMerchantUseCase(repository: sl()),
    )
    ..registerFactory(
      () => MerchantApplicationBloc(registerMerchant: sl()),
    );
}

void _initShop(GetIt sl) {
  sl
    ..registerLazySingleton<ShopRemoteDataSource>(
      () => ShopRemoteDataSourceImpl(client: sl()),
    )
    ..registerLazySingleton<ShopLocalDataSource>(
      () => ShopLocalDataSourceImpl(sharedPrefsService: sl()),
    )
    ..registerLazySingleton<ShopRepository>(
      () => ShopRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
      ),
    )
    ..registerLazySingleton(
      () => GetShopListUseCase(repository: sl()),
    )
    ..registerLazySingleton(() => ShopListBloc(getShopList: sl()))
    ..registerLazySingleton(() => LoadShopUseCase(repository: sl()))
    ..registerLazySingleton(
      () => GetCachedShopUseCase(repository: sl()),
    )
    ..registerLazySingleton(() => CacheShopUseCase(repository: sl()))
    ..registerLazySingleton(
      () => ShopBloc(
        loadShop: sl(),
        getCachedShop: sl(),
        cacheShop: sl(),
      ),
    );
}

void _initMenuCategory(GetIt sl) {
  sl
    ..registerLazySingleton<MenuCategoryRemoteDataSource>(
      () => MenuCategoryRemoteDataSourceImpl(client: sl()),
    )
    ..registerLazySingleton<MenuCategoryRepository>(
      () => MenuCategoryRepositoryImpl(remoteDataSource: sl()),
    )
    ..registerLazySingleton(
      () => WatchMenuCategoriesUseCase(repository: sl()),
    )
    ..registerLazySingleton(
      () => CreateMenuCategoryUseCase(repository: sl()),
    )
    ..registerFactory(
      () => MenuCategoryListCubit(watchMenuCategories: sl()),
    )
    ..registerFactory(
      () => MenuCategoryBloc(createMenuCategory: sl()),
    );
}

void _initMenuItem(GetIt sl) {
  sl
    ..registerLazySingleton<MenuItemRemoteDataSource>(
      () => MenuItemRemoteDataSourceImpl(
        client: sl(),
        storageService: sl(),
      ),
    )
    ..registerLazySingleton<MenuItemRepository>(
      () => MenuItemRepositoryImpl(remoteDataSource: sl()),
    )
    ..registerLazySingleton(
      () => WatchMenuItemsUseCase(repository: sl()),
    )
    ..registerLazySingleton(
      () => CreateMenuItemUseCase(repository: sl()),
    )
    ..registerLazySingleton(
      () => UpdateMenuItemUseCase(repository: sl()),
    )
    ..registerFactory(() => MenuItemListCubit(watchMenuItems: sl()))
    ..registerFactory(
      () => MenuItemBloc(createMenuItem: sl(), updateMenuItem: sl()),
    );
}

void _initOrder(GetIt sl) {
  sl
    ..registerLazySingleton<OrderRemoteDataSource>(
      () => OrderRemoteDataSourceImpl(client: sl()),
    )
    ..registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(remoteDataSource: sl()),
    )
    ..registerLazySingleton(
      () => WatchUpcomingOrdersUseCase(repository: sl()),
    )
    ..registerLazySingleton(
      () => ConfirmOrderCompleteUseCase(repository: sl()),
    )
    ..registerLazySingleton(
      () => GetOrderHistoryUseCase(repository: sl()),
    )
    ..registerFactory(
      () => UpcomingOrdersCubit(
        watchUpcomingOrders: sl(),
        confirmOrderComplete: sl(),
        historyOrdersCubit: sl(),
      ),
    )
    ..registerFactory(
      () => HistoryOrdersCubit(getOrderHistory: sl()),
    );
}

void _initAnalytics(GetIt sl) {
  sl
    ..registerLazySingleton<AnalyticsRemoteDataSource>(
      () => AnalyticsRemoteDataSourceImpl(client: sl()),
    )
    ..registerLazySingleton<AnalyticsRepository>(
      () => AnalyticsRepositoryImpl(remoteDataSource: sl()),
    )
    ..registerLazySingleton(
      () => GetTodayStatsUseCase(repository: sl()),
    )
    ..registerFactory(() => AnalyticsBloc(getTodayStats: sl()));
}

void _initInvitation(GetIt sl) {
  sl
    ..registerLazySingleton<InvitationRemoteDataSource>(
      () => InvitationRemoteDataSourceImpl(client: sl()),
    )
    ..registerLazySingleton<InvitationRepository>(
      () => InvitationRepositoryImpl(remoteDataSource: sl()),
    )
    ..registerLazySingleton(
      () => GetInvitationUseCase(repository: sl()),
    )
    ..registerLazySingleton(
      () => CreateInvitationUseCase(repository: sl()),
    )
    ..registerLazySingleton(
      () => AcceptInvitationUseCase(repository: sl()),
    )
    ..registerFactory(
      () => InvitationBloc(
        getInvitation: sl(),
        createInvitation: sl(),
        acceptInvitation: sl(),
      ),
    );
}
