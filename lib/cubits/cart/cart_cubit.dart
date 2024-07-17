import 'package:flutter_application_1/data/models/todo.dart';
import 'package:flutter_application_1/services/todo_http_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_application_1/cubits/cart/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final cartHttpServices = TodoHttpServices();

  CartCubit() : super(CartInitialState());

  Future<void> getCart() async {
    try {
      emit(CartLoadingState());
      var carts = await cartHttpServices.getTodos();
      print(carts);
      emit(CartLoadedState(carts.cast<Todo>()));
    } catch (e) {
      print("Xatolik yuz berdi");
      emit(CartErrorState("Rejalarni olib bo'lmadi"));
    }
  }

  Future<void> cartDelete(String id) async {
    emit(CartLoadingState());
    await cartHttpServices.addDelete(id);
    var carts = await cartHttpServices.getTodos();
    emit(CartLoadedState(carts));
  }
}
