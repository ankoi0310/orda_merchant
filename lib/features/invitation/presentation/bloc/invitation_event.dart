part of 'invitation_bloc.dart';

sealed class InvitationEvent extends Equatable {
  const InvitationEvent();

  @override
  List<Object?> get props => [];
}

final class GetInvitations extends InvitationEvent {}

final class CreateInvitation extends InvitationEvent {
  const CreateInvitation(this.params);

  final InvitationParams params;

  @override
  List<Object?> get props => [params];
}
