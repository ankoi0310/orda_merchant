import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/features/invitation/domain/entities/invitation.dart';
import 'package:orda_merchant/features/invitation/domain/usecases/accept_invitation_use_case.dart';
import 'package:orda_merchant/features/invitation/domain/usecases/create_invitation_use_case.dart';
import 'package:orda_merchant/features/invitation/domain/usecases/get_invitation_use_case.dart';

part 'invitation_event.dart';

part 'invitation_state.dart';

class InvitationBloc extends Bloc<InvitationEvent, InvitationState> {
  InvitationBloc({
    required GetInvitationUseCase getInvitation,
    required CreateInvitationUseCase createInvitation,
    required AcceptInvitationUseCase acceptInvitation,
  }) : _getInvitation = getInvitation,
       _createInvitation = createInvitation,
       _acceptInvitation = acceptInvitation,
       super(InvitationInitial()) {
    on<GetInvitation>(_onGetInvitation);
    on<CreateInvitation>(_onCreateInvitation);
    on<AcceptInvitation>(_onAcceptInvitation);
  }

  final GetInvitationUseCase _getInvitation;
  final CreateInvitationUseCase _createInvitation;
  final AcceptInvitationUseCase _acceptInvitation;

  Future<void> _onGetInvitation(
    GetInvitation event,
    Emitter<InvitationState> emit,
  ) async {
    emit(GettingInvitation());
    final result = await _getInvitation();

    result.fold(
      (failure) => emit(InvitationError(failure.message)),
      (invitation) => emit(GetInvitationsSuccess(invitation)),
    );
  }

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

  Future<void> _onAcceptInvitation(
    AcceptInvitation event,
    Emitter<InvitationState> emit,
  ) async {
    emit(AcceptingInvitation());
    final result = await _acceptInvitation(event.id);

    result.fold(
      (failure) => emit(InvitationError(failure.message)),
      (_) => emit(AcceptInvitationSuccess()),
    );
  }
}
