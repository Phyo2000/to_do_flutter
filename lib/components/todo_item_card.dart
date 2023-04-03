// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/screens/todo_add_screen.dart';
import 'package:provider/provider.dart';

class TodoItemCard extends StatefulWidget {
  final TodoItem item;

  TodoItemCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<TodoItemCard> createState() => _TodoItemCardState();
}

class _TodoItemCardState extends State<TodoItemCard> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: GlobalKey(),
      background: Container(
        color: Colors.green,
        child: const Icon(Icons.done),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        child: const Icon(Icons.delete),
      ),
      confirmDismiss: (direction) async {
        print(direction);
        if (direction == DismissDirection.startToEnd) {
          //widget.item.isDone = true;
          Provider.of<ListTodoItem>(context, listen: false)
              .setDone(widget.item);
          //Provider.of<ListTodoItem>(context, listen: false)
          // .removeTodoItem(widget.item);
          return true;
        } else if (direction == DismissDirection.endToStart) {
          Provider.of<ListTodoItem>(context, listen: false)
              .removeTodoItem(widget.item);
        }
        return true;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFEEEFF5),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Text(
                        widget.item.date,
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Text(
                      //   widget.item.time,
                      //   style: TextStyle(
                      //     color: Colors.deepPurple,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      //   // size: 20,
                      //   // color: Colors.deepPurple,
                      // ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.title,
                      style: const TextStyle(
                        fontSize: 17.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(widget.item.description),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: widget.item.userColor,
                ),
                width: 25,
                height: 25,
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TodoAddScreen(
                      item: widget.item,
                    ),
                  ),
                ),
                child: const SizedBox(
                  width: 60,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Colors.deepPurple,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
