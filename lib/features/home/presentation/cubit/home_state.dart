part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class MenuLoading extends HomeState {}

class MenuLoaded extends HomeState {
  final Menu menu;
  MenuLoaded({required this.menu});
}

class MenuError extends HomeState {
  final String message;
  MenuError(this.message);
}
