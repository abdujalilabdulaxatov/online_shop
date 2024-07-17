import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubits/cart/cart_cubit.dart';
import 'package:flutter_application_1/cubits/cart/cart_state.dart';
import 'package:flutter_application_1/ui/screens/todo_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<CartCubit>().getCart();
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
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Carts"),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartInitialState) {
            return const Center(
              child: Text("Ma'lumotlar yuklanmoqda"),
            );
          } else if (state is CartLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartErrorState) {
            return Center(child: Text(state.message));
          }
          final carts = (state as CartLoadedState).carts;
          return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: carts.length,
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
                              image: NetworkImage(carts[index].image_url),
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
                              carts[index].title,
                              style: const TextStyle(fontSize: 18),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<CartCubit>()
                                        .cartDelete(carts[index].id);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
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
