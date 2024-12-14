import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zarbuy/features/auth/cubit/authentication/authentication_cubit.dart';
import 'package:zarbuy/features/home/presentation/pages/homepage.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  late AuthenticationCubit authenticationCubit;
  @override
  void initState() {
    // TODO: implement initState
    authenticationCubit = AuthenticationCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AuthenticationCubit>(
        create: (context) => authenticationCubit,
        child: BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationInitial) {
            } else if (state is AuthSimNumberListLoading) {
            } else if (state is AuthSimNumberListSuccess) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: SizedBox(
                        height: 120,
                        width: 240,
                        child: Expanded(
                          child: ListView.builder(
                              itemCount: state.phoneNo.length,
                              itemBuilder: (context, i) {
                                return GestureDetector(
                                    onTap: () {
                                      /*    authenticationCubit.signInWithPhoneNumber(
                                          state.phoneNo[i]);
                                  */
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Homepage()));
                                    },
                                    child: Text(state.phoneNo[i]));
                              }),
                        ),
                      ),
                    );
                  });
            } else if (state is GoogleSignInLoading) {
            } else if (state is GoogleSignInAccountsFetched) {
              String test = state.accounts!.email;
              print(test);
              authenticationCubit.googleSignIn();
            } else if (state is GoogleSignInSuccess) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Homepage()));
            } else if (state is GoogleSignInError) {
            } else if (state is AuthSimNumberListFail) {
              AlertDialog.adaptive(
                content: Text("plase give permistions"),
              );
            }
          },
          child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationInitial) {
                return Container(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 180,
                          width: 180,
                          child: Image.asset("assets/images/firebase.png")),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // Border radius
                            ),
                            minimumSize: Size(double.infinity,
                                40), // Minimum size: width to fill the container, height 40
                          ),
                          onPressed: () {
                            authenticationCubit.googleSignIn();
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset(
                                        "assets/images/google.png")),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                                Text("Google"),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                              ],
                            ),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // Border radius
                            ),
                            minimumSize: Size(double.infinity,
                                40), // Minimum size: width to fill the container, height 40
                          ),
                          onPressed: () {
                            authenticationCubit.checkPermission();
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                    )),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                                Text("phone"),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                              ],
                            ),
                          ))
                    ],
                  ),
                );
              } else if (state is AuthSimNumberListLoading) {
                return Container(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 180,
                          width: 180,
                          child: Image.asset("assets/images/firebase.png")),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // Border radius
                            ),
                            minimumSize: Size(double.infinity,
                                40), // Minimum size: width to fill the container, height 40
                          ),
                          onPressed: () {},
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset(
                                        "assets/images/google.png")),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                                Text("Google"),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                              ],
                            ),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // Border radius
                            ),
                            minimumSize: Size(double.infinity,
                                40), // Minimum size: width to fill the container, height 40
                          ),
                          onPressed: () {},
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [CircularProgressIndicator()],
                            ),
                          ))
                    ],
                  ),
                );
              } else if (state is AuthSimNumberListSuccess) {
                return Container(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 180,
                          width: 180,
                          child: Image.asset("assets/images/firebase.png")),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // Border radius
                            ),
                            minimumSize: Size(double.infinity,
                                40), // Minimum size: width to fill the container, height 40
                          ),
                          onPressed: () {
                            authenticationCubit.googleSignIn();
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset(
                                        "assets/images/google.png")),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                                Text("Google"),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                              ],
                            ),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // Border radius
                            ),
                            minimumSize: Size(double.infinity,
                                40), // Minimum size: width to fill the container, height 40
                          ),
                          onPressed: () {
                            authenticationCubit.checkPermission();
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                    )),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                                Text("phone"),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                              ],
                            ),
                          ))
                    ],
                  ),
                );
              } else if (state is AuthSimNumberListFail) {
                return Container(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 180,
                          width: 180,
                          child: Image.asset("assets/images/firebase.png")),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // Border radius
                            ),
                            minimumSize: Size(double.infinity,
                                40), // Minimum size: width to fill the container, height 40
                          ),
                          onPressed: () {
                            authenticationCubit.googleSignIn();
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset(
                                        "assets/images/google.png")),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                                Text("Google"),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                              ],
                            ),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // Border radius
                            ),
                            minimumSize: Size(double.infinity,
                                40), // Minimum size: width to fill the container, height 40
                          ),
                          onPressed: () {
                            authenticationCubit.checkPermission();
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                    )),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                                Text("phone"),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                              ],
                            ),
                          ))
                    ],
                  ),
                );
              } else if (state is GoogleSignInLoading) {
                return Container(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 180,
                          width: 180,
                          child: Image.asset("assets/images/firebase.png")),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // Border radius
                            ),
                            minimumSize: Size(double.infinity,
                                40), // Minimum size: width to fill the container, height 40
                          ),
                          onPressed: () {},
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset(
                                        "assets/images/google.png")),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                                SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                              ],
                            ),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // Border radius
                            ),
                            minimumSize: Size(double.infinity,
                                40), // Minimum size: width to fill the container, height 40
                          ),
                          onPressed: () {
                            authenticationCubit.checkPermission();
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                    )),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                                Text("phone"),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                              ],
                            ),
                          ))
                    ],
                  ),
                );
              } else if (state is GoogleSignInAccountsFetched) {
                return Container(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 180,
                          width: 180,
                          child: Image.asset("assets/images/firebase.png")),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // Border radius
                            ),
                            minimumSize: Size(double.infinity,
                                40), // Minimum size: width to fill the container, height 40
                          ),
                          onPressed: () {
                            authenticationCubit.fetchAccounts();
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset(
                                        "assets/images/google.png")),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                                Text("Google"),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                              ],
                            ),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // Border radius
                            ),
                            minimumSize: Size(double.infinity,
                                40), // Minimum size: width to fill the container, height 40
                          ),
                          onPressed: () {
                            authenticationCubit.checkPermission();
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                    )),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                                Text("phone"),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                              ],
                            ),
                          ))
                    ],
                  ),
                );
              } else if (state is GoogleSignInSuccess) {
                return Container(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 180,
                          width: 180,
                          child: Image.asset("assets/images/firebase.png")),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // Border radius
                            ),
                            minimumSize: Size(double.infinity,
                                40), // Minimum size: width to fill the container, height 40
                          ),
                          onPressed: () {
                            authenticationCubit.fetchAccounts();
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset(
                                        "assets/images/google.png")),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                                Text("Google"),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                              ],
                            ),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // Border radius
                            ),
                            minimumSize: Size(double.infinity,
                                40), // Minimum size: width to fill the container, height 40
                          ),
                          onPressed: () {
                            authenticationCubit.checkPermission();
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                    )),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                                Text("phone"),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                              ],
                            ),
                          ))
                    ],
                  ),
                );
              } else if (state is GoogleSignInError) {
                return Container(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 180,
                          width: 180,
                          child: Image.asset("assets/images/firebase.png")),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // Border radius
                            ),
                            minimumSize: Size(double.infinity,
                                40), // Minimum size: width to fill the container, height 40
                          ),
                          onPressed: () {
                            authenticationCubit.fetchAccounts();
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset(
                                        "assets/images/google.png")),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                                Text("Google"),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                              ],
                            ),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // Border radius
                            ),
                            minimumSize: Size(double.infinity,
                                40), // Minimum size: width to fill the container, height 40
                          ),
                          onPressed: () {
                            authenticationCubit.checkPermission();
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                    )),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                                Text("phone"),
                                Expanded(
                                    child: SizedBox(
                                  height: 8,
                                )),
                              ],
                            ),
                          ))
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
