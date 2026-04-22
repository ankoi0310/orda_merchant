import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:orda_merchant/app.dart';
import 'package:orda_merchant/core/bloc/session/session_cubit.dart';
import 'package:orda_merchant/core/bloc/user_setup/user_setup_cubit.dart';
import 'package:orda_merchant/core/constant/app_constants.dart';
import 'package:orda_merchant/di.dart';
import 'package:orda_merchant/features/invitation/presentation/bloc/invitation_bloc.dart';
import 'package:orda_merchant/features/order/presentation/bloc/history_orders/history_orders_cubit.dart';
import 'package:orda_merchant/features/order/presentation/bloc/upcoming_orders/upcoming_orders_cubit.dart';
import 'package:orda_merchant/features/shop/presentation/bloc/shop/shop_bloc.dart';
import 'package:orda_merchant/features/shop/presentation/bloc/shop_list/shop_list_bloc.dart';
import 'package:orda_merchant/features/user/presentation/bloc/user_bloc.dart';
import 'package:orda_merchant/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FirebaseMessaging.onBackgroundMessage(
  //   firebaseMessagingBackgroundHandler,
  // );

  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabasePublishableKey,
  );

  await initInjection();

  // NotificationService.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<SessionCubit>()),
        BlocProvider(create: (_) => sl<UserSetupCubit>()),
        BlocProvider(create: (_) => sl<ShopListBloc>()),
        BlocProvider(
          create: (_) => sl<ShopBloc>()..add(GetCachedShop()),
        ),
        BlocProvider(
          create: (_) => sl<UserBloc>()..add(GetUserProfile()),
        ),
        BlocProvider(create: (_) => sl<UpcomingOrdersCubit>()),
        BlocProvider(create: (_) => sl<HistoryOrdersCubit>()),
        BlocProvider(create: (_) => sl<InvitationBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}
