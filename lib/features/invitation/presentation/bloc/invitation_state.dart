part of 'invitation_bloc.dart';

sealed class InvitationState extends Equatable {
  const InvitationState();

  @override
  List<Object?> get props => [];
}

final class InvitationInitial extends InvitationState {}

final class GettingInvitation extends InvitationState {}

final class GetInvitationsSuccess extends InvitationState {
  const GetInvitationsSuccess(this.invitation);

  final Invitation? invitation;

  @override
  List<Object?> get props => [invitation];
}

final class CreatingInvitation extends InvitationState {}

final class CreateInvitationSuccess extends InvitationState {
  const CreateInvitationSuccess(this.invitation);

  final Invitation invitation;

  @override
  List<Object?> get props => [invitation];
}

final class AcceptingInvitation extends InvitationState {}

final class AcceptInvitationSuccess extends InvitationState {}

final class InvitationError extends InvitationState {
  const InvitationError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
