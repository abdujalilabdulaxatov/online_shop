import 'dart:convert';

import 'package:flutter_application_1/data/models/todo.dart';
import 'package:http/http.dart' as http;

class CartsHttpServices {
  Future<List> getCarts() async {
    List<Todo> carts = [];

    Uri url = Uri.parse(
        "https://todobloc-f4cb8-default-rtdb.firebaseio.com/carts.json");
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    if (data != null) {
      data.forEach((key, value) {
        carts.add(Todo(
            id: key,
            title: value["title"],
            image_url: value["image_url"],
            isDone: value["isDone"]));
      });
      print("$carts bbbb");
      return carts;
    }
    return [];
  }

  Future<void> cartDelete(String id) async {
    Uri url = Uri.parse(
        "https://todobloc-f4cb8-default-rtdb.firebaseio.com/carts/$id.json");
    await http.delete(url);
  }
}
