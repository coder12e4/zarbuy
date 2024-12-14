import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zarbuy/features/Cart/Presentation/cubit/cart_cubit.dart';

import '../../../home/Data/Models/homeModel.dart';
import '../../Data/DishCountModel/DishCount.dart';

class CartPage extends StatefulWidget {
  final List<Dish> CartItems;
  const CartPage({super.key, required this.CartItems});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartCubit cartCubitHome;
  Map<int, DishCount> dishCountMap = {};
  int CartCunt = 0;
  int CartItemCount = 0;
  @override
  void initState() {
    cartCubitHome = CartCubit();
    cartCubitHome.CartItems = widget.CartItems;
    cartCubitHome.cartIndividualDishCount(widget.CartItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Summary"),
      ),
      body: BlocProvider<CartCubit>(
        create: (context) => CartCubit(),
        child: BlocListener<CartCubit, CartState>(
          bloc: cartCubitHome,
          listener: (context, state) {
            if (state is CartInitial) {
            } else if (state is CartPageLoading) {
            } else if (state is CartPageUpdateSucces) {
              print("state emited ${state.dishCountMap.length}");
              CartCunt = state.dishCountMap.length;

              CartItemCount = state.dishCountMap
                  .fold<Set<DishCount>>(Set<DishCount>(),
                      (Set<DishCount> set, item) => set..add(item))
                  .length;
            }
          },
          child: BlocBuilder<CartCubit, CartState>(
            bloc: cartCubitHome,
            builder: (context, state) {
              if (state is CartInitial) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CartPageLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                );
              } else if (state is CartPageUpdateSucces) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Card(
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: Colors.green[900],
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                  "${state.dishCountMap.length}  Dishes  ${state.ItemsCount}  Items"),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * .5,
                              child: Expanded(
                                  child: ListView.builder(
                                itemCount: state.dishCountMap.length,
                                itemBuilder: (context, index) {
                                  final dish = state.dishCountMap[index].dish;

                                  return Container(
                                    padding: const EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        top: 16,
                                        bottom: 16),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey, width: 1))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 16,
                                              width: 16,
                                              margin: EdgeInsets.only(
                                                  top: 4, left: 4),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.red)),
                                              alignment: Alignment.center,
                                              child: Container(
                                                height: 10,
                                                width: 10,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.red),
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                alignment: Alignment.center,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 80,
                                              width: 80,
                                              child: Text(
                                                dish.name,
                                                maxLines: 4,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 24,
                                                    ),
                                                    Container(
                                                      width: 100,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: Colors.green),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              cartCubitHome
                                                                  .addItemToCartPage(
                                                                      dish);
                                                            },
                                                            child: SizedBox(
                                                              height: 30,
                                                              width: 30,
                                                              child: Icon(
                                                                Icons.add,
                                                                size: 24,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            state
                                                                .dishCountMap[
                                                                    index]
                                                                .count
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              cartCubitHome
                                                                  .removeItemFromCartPage(
                                                                      dish);
                                                            },
                                                            child: SizedBox(
                                                              height: 30,
                                                              width: 30,
                                                              child: Icon(
                                                                Icons.remove,
                                                                size: 24,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "INR ${dish.price}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${dish.calories} calories",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              height: 70,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total amount",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    state.totalPrice.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Container(
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: Colors.green[900]),
                        child: Text(
                          "Place Order",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}