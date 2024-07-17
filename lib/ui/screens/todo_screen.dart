import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubits/todo/todo_cubit.dart';
import 'package:flutter_application_1/cubits/todo/todo_state.dart';
import 'package:flutter_application_1/ui/screens/cart_screen.dart';
import 'package:flutter_application_1/ui/widgets/add_todo.dart';
import 'package:flutter_application_1/ui/widgets/edit_todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<TodoCubit>().getTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
            child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => const CartScreen()));
              },
              child: const ListTile(
                title: Text("Carts"),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => const TodoScreen()));
              },
              child: const ListTile(
                title: Text("Home"),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            )
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () async {
          var data = await showDialog(
              context: context,
              builder: (ctx) {
                return const AddTodo();
              });
          if (data != null) {
            context.read<TodoCubit>().addTodo(data["title"], data["image_url"]);
          }
        },
        child: const CircleAvatar(
          backgroundColor: Colors.green,
          radius: 30,
          child: Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Products"),
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state is InitialState) {
            return const Center(
              child: Text("Ma'lumotlar yuklanmoqda"),
            );
          } else if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ErrorState) {
            return Center(child: Text(state.message));
          }
          final todos = (state as LoadedState).todos;
          return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: todos.length,
              itemBuilder: (ctx, index) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black)),
                  margin: const EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  height: 170,
                  child: Row(
                    children: [
                      Container(
                        width: 175,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15)),
                          image: DecorationImage(
                              image: NetworkImage(todos[index].image_url),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              todos[index].title,
                              style: const TextStyle(fontSize: 18),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<TodoCubit>()
                                        .addDelete(todos[index].id);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    var data = await showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return const EditTodo();
                                        });
                                    if (data != null) {
                                      context.read<TodoCubit>().addEdit(
                                          todos[index].id,
                                          data["title"],
                                          data["image_url"]);
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                ),
                                IconButton(
                                  color:
                                      todos[index].isDone ? Colors.red : null,
                                  onPressed: () async {
                                    context.read<TodoCubit>().addIsDone(
                                        todos[index].id, todos[index].isDone);
                                  },
                                  icon: Icon(todos[index].isDone
                                      ? CupertinoIcons.heart_fill
                                      : CupertinoIcons.heart),
                                ),
                                IconButton(
                                    onPressed: () {
                                      context.read<TodoCubit>().addToCart(
                                          todos[index].title,
                                          todos[index].image_url,
                                          todos[index].isDone);
                                    },
                                    icon: const Icon(
                                        Icons.shopping_cart_outlined))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
