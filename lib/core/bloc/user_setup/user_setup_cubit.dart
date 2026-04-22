import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/features/invitation/domain/entities/invitation.dart';
import 'package:orda_merchant/features/invitation/domain/usecases/get_pending_invitation_use_case.dart';
import 'package:orda_merchant/features/shop/domain/entities/shop.dart';
import 'package:orda_merchant/features/shop/domain/usecases/cache_shop_use_case.dart';
import 'package:orda_merchant/features/shop/domain/usecases/get_cached_shop_use_case.dart';
import 'package:orda_merchant/features/shop/domain/usecases/get_shop_list_use_case.dart';
import 'package:orda_merchant/features/shop/domain/usecases/load_shop_use_case.dart';
import 'package:orda_merchant/features/shop/domain/usecases/remove_cached_shop_use_case.dart';

part 'user_setup_state.dart';

class UserSetupCubit extends Cubit<UserSetupState> {
  UserSetupCubit({
    required GetShopListUseCase getShopList,
    required GetCachedShopUseCase getCachedShop,
    required CacheShopUseCase cacheShop,
    required RemoveCachedShopUseCase removeCachedShop,
    required GetPendingInvitationUseCase getPendingInvitation,
    required LoadShopUseCase loadShop,
  }) : _getShopList = getShopList,
       _getCachedShop = getCachedShop,
       _cacheShop = cacheShop,
       _removeCachedShop = removeCachedShop,
       _getPendingInvitation = getPendingInvitation,
       _loadShop = loadShop,
       super(UserSetupInitial());

  final GetShopListUseCase _getShopList;
  final GetCachedShopUseCase _getCachedShop;
  final CacheShopUseCase _cacheShop;
  final RemoveCachedShopUseCase _removeCachedShop;
  final GetPendingInvitationUseCase _getPendingInvitation;
  final LoadShopUseCase _loadShop;

  Future<void> loadUserData() async {
    emit(UserSetupLoading());

    final result = await _getShopList();

    result.fold((failure) => emit(UserSetupError(failure.message)), (
      shops,
    ) async {
      if (shops.isEmpty) {
        final invitationResult = await _getPendingInvitation();

        invitationResult.fold(
          (failure) => emit(UserSetupError(failure.message)),
          (invitation) => emit(
            invitation == null
                ? UserSetupNoShop()
                : UserSetupHasInvitation(invitation),
          ),
        );
        return;
      }

      final cachedResult = await _getCachedShop();

      var selectedShop = shops.first; // Default to first shop
      cachedResult.fold((failure) {}, (cachedShop) {
        if (cachedShop != null) {
          final foundShop = shops
              .where((shop) => shop.id == cachedShop.id)
              .firstOrNull;
          if (foundShop != null) {
            selectedShop = foundShop;
          }
        }
      });

      await _cacheShop(selectedShop);
      emit(UserSetupReady(selectedShop: selectedShop, shops: shops));
    });
  }

  Future<void> switchShop(Shop shop) async {
    final current = state;
    if (current is UserSetupReady) {
      await _cacheShop(shop);
      emit(UserSetupReady(selectedShop: shop, shops: current.shops));
    }
  }

  Future<void> completeInvitationSetup(Invitation invitation) async {
    emit(UserSetupLoading());

    final result = await _loadShop(invitation.shopId);

    result.fold((failure) => emit(UserSetupError(failure.message)), (
      shop,
    ) async {
      await _cacheShop(shop);
      emit(UserSetupReady(selectedShop: shop, shops: [shop]));
    });
  }

  Future<void> reset() async {
    await _removeCachedShop();
    emit(UserSetupInitial());
  }
}
