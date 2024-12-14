part of 'authentication_cubit.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

class AuthLoading extends AuthenticationState {}

class AuthSimNumberListLoading extends AuthenticationState {}

class AuthSimNumberListSuccess extends AuthenticationState {
  List<String> phoneNo;
  AuthSimNumberListSuccess(this.phoneNo);
}

class AuthSimNumberListFail extends AuthenticationState {}

class GoogleSignInInitial extends AuthenticationState {}

class GoogleSignInLoading extends AuthenticationState {}

class GoogleSignInAccountsFetched extends AuthenticationState {
  final EmailResult? accounts;

  GoogleSignInAccountsFetched({required this.accounts});
}

class GoogleSignInSuccess extends AuthenticationState {
  final GoogleSignInAccount? account;

  GoogleSignInSuccess({this.account});
}

class GoogleSignInError extends AuthenticationState {
  final String message;

  GoogleSignInError({required this.message});
}

class Authenticated extends AuthenticationState {
  final User user;
  Authenticated(this.user);
  @override
  List<Object> get props => [user];
}

class AuthError extends AuthenticationState {
  final String error;
  AuthError(this.error);
  @override
  List<Object> get props => [error];
}

class Unauthenticated extends AuthenticationState {}

class AuthCodeSent extends AuthenticationState {
  final String verificationId;

  AuthCodeSent(this.verificationId);

  @override
  List<Object> get props => [verificationId];
}
