import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/features/invitation/domain/entities/invitation.dart';
import 'package:orda_merchant/features/invitation/domain/usecases/create_invitation_use_case.dart';

part 'invitation_event.dart';

part 'invitation_state.dart';

class InvitationBloc extends Bloc<InvitationEvent, InvitationState> {
  InvitationBloc({required CreateInvitationUseCase createInvitation})
    : _createInvitation = createInvitation,
      super(InvitationInitial()) {
    on<CreateInvitation>(_onCreateInvitation);
  }

  final CreateInvitationUseCase _createInvitation;

  Future<void> _onCreateInvitation(
    CreateInvitation event,
    Emitter<InvitationState> emit,
  ) async {
    emit(CreatingInvitation());
    final result = await _createInvitation(event.params);

    result.fold(
      (failure) => emit(InvitationError(failure.message)),
      (invitation) => emit(CreateInvitationSuccess(invitation)),
    );
  }
}
