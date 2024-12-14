part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartUpdateSuccees extends CartState {
  Dish? item;
  int? Count;
  CartUpdateSuccees(this.item, this.Count);
}

final class CartCountUpdateSuccees extends CartState {
  int? Count;
  CartCountUpdateSuccees(this.Count);
}

final class CartPageLoading extends CartState {}

final class CartPageUpdateSucces extends CartState {
  List<DishCount> dishCountMap;
  double totalPrice;
  int ItemsCount;
  CartPageUpdateSucces(this.dishCountMap, this.totalPrice, this.ItemsCount);
}

final class CartPageUpdateFail extends CartState {}
