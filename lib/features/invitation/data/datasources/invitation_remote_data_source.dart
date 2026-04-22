import 'package:orda_merchant/core/error/exceptions.dart';
import 'package:orda_merchant/features/invitation/data/models/invitation_model.dart';
import 'package:orda_merchant/features/invitation/domain/entities/invitation.dart';
import 'package:orda_merchant/features/invitation/domain/usecases/create_invitation_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class InvitationRemoteDataSource {
  Future<InvitationModel?> getInvitation({InvitationStatus? status});

  Future<InvitationModel> createInvitation(
    CreateInvitationParams params,
  );

  Future<void> updateInvitationStatus({
    required String id,
    required InvitationStatus status,
  });
}

class InvitationRemoteDataSourceImpl
    implements InvitationRemoteDataSource {
  const InvitationRemoteDataSourceImpl({required this.client});

  final SupabaseClient client;

  @override
  Future<InvitationModel?> getInvitation({
    InvitationStatus? status,
  }) async {
    try {
      var query = client.from('invitations').select();

      if (status != null) {
        query = query.eq('status', status.name);
      }

      final json = await query.maybeSingle();

      return json == null ? null : InvitationModel.fromJson(json);
    } catch (e) {
      throw ServerException('Lấy lời mời không thành công: $e');
    }
  }

  @override
  Future<InvitationModel> createInvitation(
    CreateInvitationParams params,
  ) async {
    try {
      return client
          .from('invitations')
          .insert(params.toJson())
          .select()
          .single()
          .withConverter(InvitationModel.fromJson);
    } catch (e) {
      throw const ServerException('Something wen wrong');
    }
  }

  @override
  Future<void> updateInvitationStatus({
    required String id,
    required InvitationStatus status,
  }) async {
    final invitation = await _getInvitation(id);

    await client
        .from('invitations')
        .update({'status': status.name})
        .eq('id', id);

    if (status == InvitationStatus.accepted) {
      try {
        final user = client.auth.currentUser!;
        await client.from('shop_members').upsert({
          'shop_id': invitation.shopId,
          'user_id': user.id,
          'role': invitation.role.name,
        });
      } catch (e) {
        throw ServerException('Thêm nhân viên không thành công: $e');
      }
    }
  }

  Future<InvitationModel> _getInvitation(String id) async {
    try {
      final json = await client
          .from('invitations')
          .select()
          .eq('id', id)
          .maybeSingle();
      if (json == null) {
        throw const ServerException('Không tìm thấy lời mời');
      }

      return InvitationModel.fromJson(json);
    } catch (e) {
      throw const ServerException('Something wen wrong');
    }
  }
}
