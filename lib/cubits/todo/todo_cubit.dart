import 'package:flutter_application_1/cubits/todo/todo_state.dart';
import 'package:flutter_application_1/data/models/todo.dart';
import 'package:flutter_application_1/services/todo_http_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCubit extends Cubit<TodoState> {
  final todoHttpServices = TodoHttpServices();
  TodoCubit() : super(InitialState());

  Future<void> getTodos() async {
    try {
      emit(LoadingState());
      var todos = await todoHttpServices.getTodos();
      print(todos);
      emit(LoadedState(todos.cast<Todo>()));
    } catch (e) {
      print("Xatolik yuz berdi");
      emit(ErrorState("Rejalarni olib bo'lmadi"));
    }
  }

  Future<void> addTodo(String title, String imageUrl) async {
    emit(LoadingState());
    await todoHttpServices.addTodo(title, imageUrl);
    var todos = await todoHttpServices.getTodos();
    emit(LoadedState(todos));
  }

  Future<void> addDelete(String id) async {
    emit(LoadingState());
    await todoHttpServices.addDelete(id);
    var todos = await todoHttpServices.getTodos();
    emit(LoadedState(todos));
  }

  Future<void> addEdit(String id, String title, String imageUrl) async {
    emit(LoadingState());
    await todoHttpServices.addEdit(id, title, imageUrl);
    var todos = await todoHttpServices.getTodos();
    emit(LoadedState(todos));
  }

  Future<void> addIsDone(String id, bool isDone) async {
    emit(LoadingState());
    await todoHttpServices.addIsDone(id, isDone);
    var todos = await todoHttpServices.getTodos();
    emit(LoadedState(todos));
  }

  Future<void> addToCart(String title, String imageUrl, bool isDone) async {
    emit(LoadingState());
    await todoHttpServices.addToCart(title, imageUrl, isDone);
    var todos = await todoHttpServices.getTodos();
    emit(LoadedState(todos));
  }
}
