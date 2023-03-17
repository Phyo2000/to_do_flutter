import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todo_app/models/todo_model.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (context) => ListTodoItem(),
  ),
];
