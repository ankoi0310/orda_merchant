import 'package:orda_merchant/core/error/exceptions.dart';
import 'package:orda_merchant/features/invitation/data/models/invitation_model.dart';
import 'package:orda_merchant/features/invitation/domain/usecases/create_invitation_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class InvitationRemoteDataSource {
  Future<InvitationModel> createInvitation(InvitationParams params);
}

class InvitationRemoteDataSourceImpl
    implements InvitationRemoteDataSource {
  const InvitationRemoteDataSourceImpl({required this.client});

  final SupabaseClient client;

  @override
  Future<InvitationModel> createInvitation(
    InvitationParams params,
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
}
