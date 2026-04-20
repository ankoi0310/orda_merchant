part of 'invitation_bloc.dart';

sealed class InvitationEvent extends Equatable {
  const InvitationEvent();

  @override
  List<Object?> get props => [];
}

final class GetInvitation extends InvitationEvent {}

final class CreateInvitation extends InvitationEvent {
  const CreateInvitation(this.params);

  final CreateInvitationParams params;

  @override
  List<Object?> get props => [params];
}

final class AcceptInvitation extends InvitationEvent {
  const AcceptInvitation(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}
