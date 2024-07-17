import 'package:flutter_application_1/data/models/todo.dart';

sealed class CartState {}

final class CartInitialState extends CartState {}

final class CartLoadingState extends CartState {}

final class CartLoadedState extends CartState {
  List<Todo> carts = [];

  CartLoadedState(this.carts);
}

final class CartErrorState extends CartState {
  String message;

  CartErrorState(this.message);
}
