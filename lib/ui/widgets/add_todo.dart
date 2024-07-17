import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final _globalKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  final _imageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add Product"),
      actions: [
        Form(
            key: _globalKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter product name";
                    }
                    return null;
                  },
                  controller: _textController,
                  decoration: const InputDecoration(
                    hintText: "Add product name",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter product image url";
                    }
                    return null;
                  },
                  controller: _imageController,
                  decoration: const InputDecoration(
                    hintText: "Add product image url",
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        )),
                    GestureDetector(
                      onTap: () {
                        if (_globalKey.currentState!.validate()) {
                          Navigator.of(context).pop({
                            "title": _textController.text,
                            "image_url": _imageController.text
                          });
                        }
                      },
                      child: Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(30)),
                        child: const Center(
                          child: Text(
                            "Save",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ))
      ],
    );
    ;
  }
}
