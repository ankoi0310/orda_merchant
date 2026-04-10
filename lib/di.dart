import 'package:get_it/get_it.dart';
import 'package:orda_merchant/core/cubit/session_cubit.dart';
import 'package:orda_merchant/core/service/shared_prefs_service.dart';
import 'package:orda_merchant/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:orda_merchant/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:orda_merchant/features/auth/domain/repositories/auth_repository.dart';
import 'package:orda_merchant/features/auth/domain/usecases/sign_in_with_password_use_case.dart';
import 'package:orda_merchant/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:orda_merchant/features/menu_category/data/datasources/menu_category_remote_data_source.dart';
import 'package:orda_merchant/features/menu_category/data/repositories/menu_category_repository_impl.dart';
import 'package:orda_merchant/features/menu_category/domain/repositories/menu_category_repository.dart';
import 'package:orda_merchant/features/menu_category/domain/usecases/create_menu_category_use_case.dart';
import 'package:orda_merchant/features/menu_category/domain/usecases/get_menu_category_list_use_case.dart';
import 'package:orda_merchant/features/menu_category/presentation/bloc/menu_category_bloc.dart';
import 'package:orda_merchant/features/shop/data/datasources/shop_remote_data_source.dart';
import 'package:orda_merchant/features/shop/data/repositories/shop_repository_impl.dart';
import 'package:orda_merchant/features/shop/domain/repositories/shop_repository.dart';
import 'package:orda_merchant/features/shop/domain/usecases/get_shop_list_use_case.dart';
import 'package:orda_merchant/features/shop/domain/usecases/load_shop_use_case.dart';
import 'package:orda_merchant/features/shop/presentation/bloc/shop_bloc.dart';
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
    ..registerLazySingleton<SharedPrefsService>(
      () => SharedPrefsServiceImpl(prefs),
    )
    ..registerLazySingleton(
      () => SessionCubit(
        supabaseClient: sl(),
        sharedPrefsService: sl(),
      ),
    );

  _initAuth(sl);
  _initUser(sl);
  _initShop(sl);
  _initMenuCategory(sl);
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
      () => SignInWithPasswordUseCase(repository: sl()),
    )
    ..registerFactory(() => AuthBloc(signInWithPassword: sl()));
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

void _initShop(GetIt sl) {
  sl
    ..registerLazySingleton<ShopRemoteDataSource>(
      () => ShopRemoteDataSourceImpl(client: sl()),
    )
    ..registerLazySingleton<ShopRepository>(
      () => ShopRepositoryImpl(remoteDataSource: sl()),
    )
    ..registerLazySingleton(
      () => GetShopListUseCase(repository: sl()),
    )
    ..registerLazySingleton(() => LoadShopUseCase(repository: sl()))
    ..registerLazySingleton(() => ShopListBloc(getShopList: sl()))
    ..registerFactory(() => ShopBloc(loadShop: sl()));
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
      () => GetMenuCategoryListUseCase(repository: sl()),
    )
    ..registerLazySingleton(
      () => CreateMenuCategoryUseCase(repository: sl()),
    )
    ..registerFactory(
      () => MenuCategoryBloc(
        getMenuCateogryList: sl(),
        createMenuCategory: sl(),
      ),
    );
}
