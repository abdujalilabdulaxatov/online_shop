// ignore_for_file: public_member_api_docs, sort_constructors_first
class Todo {
  final String id;
  String title;
  String image_url;
  bool isDone;
  Todo({
    required this.id,
    required this.title,
    required this.image_url,
    this.isDone = false,
  });
}
