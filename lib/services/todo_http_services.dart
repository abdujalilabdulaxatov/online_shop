import 'dart:convert';

import 'package:flutter_application_1/data/models/todo.dart';
import 'package:http/http.dart' as http;

class TodoHttpServices {
  Future<List<Todo>> getTodos() async {
    List<Todo> todos = [];
    Uri url = Uri.parse(
        "https://todobloc-f4cb8-default-rtdb.firebaseio.com/todos.json");
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    if (data != null) {
      data.forEach((key, value) {
        todos.add(Todo(
            id: key,
            title: value["title"],
            image_url: value["image_url"],
            isDone: value["isDone"]));
      });
      print("$todos aaaa");
      return todos;
    }
    return [];
  }

  Future<void> addTodo(String title, String image_url) async {
    Uri url = Uri.parse(
        "https://todobloc-f4cb8-default-rtdb.firebaseio.com/todos.json");
    await http.post(url,
        body: jsonEncode(
            {"title": title, "image_url": image_url, "isDone": false}));
  }

  Future<void> addDelete(String id) async {
    Uri url = Uri.parse(
        "https://todobloc-f4cb8-default-rtdb.firebaseio.com/todos/$id.json");
    await http.delete(url);
  }

  Future<void> addEdit(String id, String title, String imageUrl) async {
    Uri url = Uri.parse(
        "https://todobloc-f4cb8-default-rtdb.firebaseio.com/todos/$id.json");
    await http.patch(url,
        body: jsonEncode(
            {"title": title, "image_url": imageUrl, "isDone": false}));
  }

  Future<void> addIsDone(String id, bool isDone) async {
    Uri url = Uri.parse(
        "https://todobloc-f4cb8-default-rtdb.firebaseio.com/todos/$id.json");
    await http.patch(url, body: jsonEncode({"isDone": !isDone}));
  }

  Future<void> addToCart(String title, String imageUrl, bool isDone) async {
    Uri url = Uri.parse(
        "https://todobloc-f4cb8-default-rtdb.firebaseio.com/carts.json");
    await http.post(url,
        body: jsonEncode(
            {"title": title, "image_url": imageUrl, "isDone": isDone}));
  }
}
