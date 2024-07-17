import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubits/cart/cart_cubit.dart';
import 'package:flutter_application_1/cubits/todo/todo_cubit.dart';
import 'package:flutter_application_1/examples/counter/counter_cubit.dart';
import 'package:flutter_application_1/ui/screens/todo_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (ctx) => CounterCubit(),
          ),
          BlocProvider(
            create: (ctx) => TodoCubit(),
          ),
          BlocProvider(
            create: (ctx) => CartCubit(),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: TodoScreen(),
        ));
  }
}
