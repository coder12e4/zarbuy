import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zarbuy/features/home/Data/Models/homeModel.dart';

import '../../Data/CartItemModel/CartItemModel.dart';
import '../../Data/DishCountModel/DishCount.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  List<Dish> CartItems = [];
  Map<int, DishCount> dishCountMap = {};
  int k = 0;

  void addItem(Dish dish) {
    CartItems.add(dish);
    int countActiveItems = CartItems.where((item) => item.id == dish.id).length;
    print(countActiveItems);
    emit(CartUpdateSuccees(dish, countActiveItems));
  }

  void removeItem(Dish dish) {
    CartItems.remove(dish);
    int countActiveItems = CartItems.where((item) => item.id == dish.id).length;
    print(countActiveItems);
    emit(CartUpdateSuccees(dish, countActiveItems));
  }

  void addItemToCartPage(Dish dish) {
    // Step 1: Add one instance of the dish to CartItems
    CartItems.add(dish);

    // Step 2: Update the count of the dish in the dishCountMap
    if (dishCountMap.containsKey(dish.id)) {
      // If the dish is already in the map, increment the count
      dishCountMap[dish.id]!.count++;
    } else {
      // If the dish is not in the map, add it with a count of 1
      dishCountMap[dish.id] = DishCount(dish: dish, count: 1);
    }

    // Step 3: Recalculate the total amount after adding the item
    double totalAmount = 0;

    // Calculate the total amount based on the dishCountMap
    for (var dishCount in dishCountMap.values) {
      totalAmount += double.parse(dishCount.dish.price) * dishCount.count;
    }

    // Step 4: Convert dishCountMap to a List of DishCount
    List<DishCount> dishCountList = dishCountMap.values.toList();

    // Step 5: Emit the updated state with the new cart and total amount
    emit(CartPageUpdateSucces(dishCountList, totalAmount, CartItems.length));
  }

  void removeItemFromCartPage(Dish dish) {
    // Step 1: Remove one instance of the dish from CartItems
    CartItems.remove(dish);

    // Step 2: Update the count of the dish in the dishCountMap
    if (dishCountMap.containsKey(dish.id)) {
      // Decrease the count of the dish
      dishCountMap[dish.id]!.count--;

      // If the count reaches zero, remove the dish from the map
      if (dishCountMap[dish.id]!.count == 0) {
        dishCountMap.remove(dish.id);
      }
    }

    // Step 3: Recalculate the total amount after removing the item
    double totalAmount = 0;

    // Calculate the new total amount based on the updated CartItems
    for (var item in CartItems) {
      totalAmount += double.parse(item.price);
    }

    // Step 4: Convert dishCountMap to a List of DishCount
    List<DishCount> dishCountList = dishCountMap.values.toList();

    // Step 5: Emit the updated state with the new cart and total amount
    emit(CartPageUpdateSucces(dishCountList, totalAmount, CartItems.length));
  }

  void cartlistCount() {
    emit(CartCountUpdateSuccees(CartItems.length));
  }

  void cartIndividualDishCountDecrement(List<Dish> CartItems) {
    emit(CartPageLoading());

    double totalAmount = 0;

    // Calculate the total amount before any changes
    for (int i = 0; i < CartItems.length; i++) {
      totalAmount += double.parse(CartItems[i].price);
    }

    // Create a map to track dish counts
    Map<int, DishCount> dishCountMap = {};

    // Iterate through the cart to decrement dish count
    for (var dish in CartItems) {
      if (dishCountMap.containsKey(dish.id)) {
        if (dishCountMap[dish.id]!.count > 1) {
          // If count is greater than 1, just decrement the count and adjust the totalAmount
          dishCountMap[dish.id]!.count--;
          totalAmount -= double.parse(dish.price);
        } else {
          // If count is 1, remove the dish from the map entirely (indicating it's removed)
          dishCountMap.remove(dish.id);
          totalAmount -= double.parse(dish.price); // Remove price from total
        }
      } else {
        // Add the dish to the map with a count of 1 (if not already present)
        dishCountMap[dish.id] = DishCount(dish: dish, count: 1);
      }
    }

    // Convert the Map to a List of DishCount
    List<DishCount> dishCountList = dishCountMap.values.toList();

    // Emit the updated state with the new cart and total amount
    emit(CartPageUpdateSucces(dishCountList, totalAmount, CartItems.length));
  }

  void cartIndividualDishCount(List<Dish> CartItems) {
    emit(CartPageLoading());
    for (var dish in CartItems) {
      if (dishCountMap.containsKey(dish.id)) {
        dishCountMap[dish.id]!.count++;
      } else {
        dishCountMap[dish.id] = DishCount(dish: dish, count: 1);
      }
    }
    double? totalamount = 0;
    for (int i = 0; i < CartItems.length; i++) {
      totalamount = totalamount! + double.parse(CartItems[i].price);
    }
    // Convert the Map to a List of DishCount
    List<DishCount> dishCountList = dishCountMap.values.toList();
    emit(CartPageUpdateSucces(dishCountList, totalamount!, CartItems.length));
    // Print the list of dishes and their counts
  }
}
