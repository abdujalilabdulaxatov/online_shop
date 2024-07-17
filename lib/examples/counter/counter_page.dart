import 'package:flutter/material.dart';
import 'package:flutter_application_1/examples/counter/counter_cubit.dart';
import 'package:flutter_application_1/examples/counter/counter_stream.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final counterStream = CounterStream();
  @override
  Widget build(BuildContext context) {
    final counterCubit = context.watch<CounterCubit>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                counterCubit.increment();
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () {
                counterCubit.decrement();
              },
              icon: const Icon(Icons.remove)),
        ],
      ),
      body: Center(
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, state) {
            return Text(state.toString());
          },
        ),
      ),
    );
  }
}
