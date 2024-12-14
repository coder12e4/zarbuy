import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zarbuy/features/Cart/Presentation/cubit/cart_cubit.dart';
import 'package:zarbuy/features/Cart/Presentation/pages/CartPage.dart';
import 'package:zarbuy/features/auth/presnetation/pages/loginpage.dart';

import '../../../Cart/Data/CartItemModel/CartItemModel.dart';
import '../../../auth/cubit/authentication/authentication_cubit.dart';
import '../cubit/home_cubit.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late HomeCubit homeCubit;
  late CartCubit cartCubitHome;
  late AuthenticationCubit authenticationCubit;
  List<ClassItemModel> CartItems = [];

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    homeCubit = HomeCubit();
    cartCubitHome = CartCubit();
    authenticationCubit = AuthenticationCubit();
    homeCubit.fetchMenu();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => AuthenticationCubit()),
      ],
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              child: Icon(Icons.menu)),
          title: Container(
            child: Row(
              children: [
                const Expanded(child: SizedBox()),
                Container(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.shopping_cart,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CartPage(
                                  CartItems: cartCubitHome.CartItems)));
                        },
                      ),
                      Positioned(
                        top: 2,
                        right: -8,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            width: 14,
                            height: 14,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: Colors.red),
                            child: BlocProvider<CartCubit>(
                                create: (context) => CartCubit(),
                                child: BlocListener<CartCubit, CartState>(
                                  bloc: cartCubitHome,
                                  listener: (context, state) {
                                    if (state is CartInitial) {
                                    } else if (state
                                        is CartCountUpdateSuccees) {}
                                  },
                                  child: BlocBuilder<CartCubit, CartState>(
                                    bloc: cartCubitHome,
                                    builder: (context, state) {
                                      if (state is CartInitial) {
                                        return Text(
                                          "0",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 8),
                                        );
                                      } else if (state
                                          is CartCountUpdateSuccees) {
                                        return Text(
                                          state.Count.toString(),
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 8),
                                        );
                                      } else {
                                        return Text(
                                          "",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 8),
                                        );
                                      }
                                    },
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        drawer: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * .6,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 240,
                width: MediaQuery.of(context).size.width * .6,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    )),
              ),
              SizedBox(
                height: 4,
              ),
              GestureDetector(
                onTap: () {
                  authenticationCubit.signOut();
                  Navigator.pop(context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => loginpage()));
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(Icons.logout),
                    Text("Logout")
                  ],
                ),
              )
            ],
          ),
        ),
        body: BlocProvider(
            create: (context) => HomeCubit(),
            child: BlocListener<HomeCubit, HomeState>(
              bloc: homeCubit,
              listener: (context, state) {
                if (state is HomeInitial) {
                } else if (state is MenuLoading) {
                } else if (state is MenuLoaded) {
                } else if (state is MenuError) {
                } else {}
              },
              child: BlocBuilder<HomeCubit, HomeState>(
                bloc: homeCubit,
                builder: (context, state) {
                  if (state is HomeInitial) {
                    return Container();
                  } else if (state is MenuLoading) {
                    return Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MenuLoaded) {
                    return DefaultTabController(
                      length: state.menu.categories.length,
                      child: Column(
                        children: [
                          TabBar(
                            isScrollable: true,
                            tabs: state.menu.categories.map((category) {
                              return Tab(
                                  text: category.name,
                                  key: ValueKey(category.id));
                            }).toList(),
                            onTap: (index) {
                              final selectedTabId =
                                  state.menu.categories[index].id;
                              print('Selected Tab ID: $selectedTabId');
                            },
                          ),
                          Expanded(
                            child: TabBarView(
                              children: state.menu.categories.map((category) {
                                return ListView.builder(
                                  itemCount: category.dishes.length,
                                  itemBuilder: (context, index) {
                                    final dish = category.dishes[index];
                                    CartCubit cartCubit = CartCubit();
                                    return Container(
                                      padding: const EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 16,
                                          bottom: 16),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1))),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                                margin: EdgeInsets.only(top: 4),
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
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      dish.name,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    const SizedBox(
                                                      height: 16,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "INR ${dish.price}",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Text(
                                                          "${dish.calories} calories",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 16,
                                                    ),
                                                    Text(
                                                      dish.description,
                                                      maxLines: 4,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[800],
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .2,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .2,
                                                child: Image.network(
                                                  "https://clubmahindra.gumlet.io/blog/images/Paneer-Bhurji-resized.jpg?w=376&dpr=2.6",
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Row(
                                            children: [
                                              const SizedBox(
                                                width: 24,
                                              ),
                                              Container(
                                                width: 120,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: Colors.green),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        cartCubitHome
                                                            .addItem(dish);
                                                        cartCubitHome
                                                            .cartlistCount();
                                                        cartCubit.addItem(dish);
                                                      },
                                                      child: SizedBox(
                                                        height: 50,
                                                        width: 50,
                                                        child: Icon(
                                                          Icons.add,
                                                          size: 24,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    BlocProvider(
                                                      create: (context) =>
                                                          CartCubit(),
                                                      child: BlocListener<
                                                          CartCubit, CartState>(
                                                        bloc: cartCubit,
                                                        listener:
                                                            (context, state) {
                                                          if (state
                                                              is CartInitial) {
                                                          } else if (state
                                                              is CartUpdateSuccees) {}
                                                        },
                                                        child: BlocBuilder<
                                                            CartCubit,
                                                            CartState>(
                                                          bloc: cartCubit,
                                                          builder:
                                                              (context, state) {
                                                            if (state
                                                                is CartInitial) {
                                                              return Text(
                                                                "0",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              );
                                                            } else if (state
                                                                is CartUpdateSuccees) {
                                                              return Text(
                                                                state.Count
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              );
                                                            } else {
                                                              return Container();
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        cartCubitHome
                                                            .removeItem(dish);
                                                        cartCubitHome
                                                            .cartlistCount();

                                                        cartCubit
                                                            .removeItem(dish);
                                                      },
                                                      child: SizedBox(
                                                        height: 50,
                                                        width: 50,
                                                        child: Icon(
                                                          Icons.remove,
                                                          size: 24,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          dish.addons.isNotEmpty
                                              ? SizedBox()
                                              : Text(
                                                  "Customisation Available",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 12),
                                                ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is MenuError) {
                    return const Text("Error");
                  } else {
                    return const Text("Failed");
                  }
                },
              ),
            )),
      ),
    );
  }
}
