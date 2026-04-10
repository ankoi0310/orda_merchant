part of 'session_cubit.dart';

class SessionState extends Equatable {
  const SessionState({this.user, this.shopId});

  final User? user;
  final String? shopId;

  bool get isAuthenticated => user != null;

  SessionState copyWith({User? user, String? shopId}) {
    return SessionState(
      user: user ?? this.user,
      shopId: shopId ?? this.shopId,
    );
  }

  @override
  List<Object?> get props => [user, shopId];
}
