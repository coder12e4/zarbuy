import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:zarbuy/features/home/Data/Models/homeModel.dart';
import 'package:http/http.dart' as http;
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> fetchMenu() async {
    try {
      emit(MenuLoading());
      final response = await http.get(Uri.parse(
          "https://mocki.io/v1/a66ea122-20f9-40df-8f27-d82b7340510e"));
      if (response.statusCode == 200) {
        Menu menulist = Menu.fromJson(json.decode(response.body));
        emit(MenuLoaded(menu: menulist));
      } else {
        emit(MenuError("Failed to load menu"));
      }
    } catch (e) {
      emit(MenuError("An error occurred: $e"));
    }
  }
}
