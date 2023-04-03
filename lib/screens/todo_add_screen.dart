import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers_list.dart';

class TodoAddScreen extends StatefulWidget {
  static String name = "/todo_add_screen";

  final TodoItem? item;

  const TodoAddScreen({
    Key? key,
    this.item,
  }) : super(key: key);

  @override
  State<TodoAddScreen> createState() => _TodoAddScreenState();
}

class _TodoAddScreenState extends State<TodoAddScreen> {
  /// text editing controllers
  final titleController = TextEditingController();
  final dateTimeController = TextEditingController();
  //late String timeController;
  final descController = TextEditingController();
  Color colorController = Colors.red;
  late int idController;
  late String text;

  /// priority selection index
  ValueNotifier<int?> priorityIndex = ValueNotifier(null);

  /// For validation
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// add new todo in list of class
  void addNewTodo({required BuildContext context}) {
    final provider = Provider.of<ListTodoItem>(context, listen: false);

    provider.addTodoItem(
      item: TodoItem(
        id: idController,
        description: descController.text,
        date: dateTimeController.text,
        //time: timeController,
        title: titleController.text,
        userColor: colorController,
      ),
    );

    //idController = null;

    debugPrint(
        "----------------------------id---${idController.toString()}-----------------------------------");
    Navigator.of(context).pop();
  }

  /// tap date time controller
  void tapDateTime() async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (newDate == null)
      return;
    else {
      TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: newDate.hour, minute: newDate.minute),
      );
      if (time == null)
        return;
      else {
        final dateTime = DateTime(
            newDate.year, newDate.month, newDate.day, time.hour, time.minute);
        dateTimeController.text =
            DateFormat("MMM-dd   hh:mm   a").format(dateTime);
      }
      //dateTimeController.text = DateFormat("MMM-dd   hh:mm a").format(newDate);
      //tapTime(newDate);
    }
  }

  /// tap time controller
  // void tapTime(DateTime date) async {
  //   final time = showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay(hour: date.hour, minute: date.minute),
  //   );
  //   if (time == null) return;
  //   setState(() {
  //     timeController = time.toString();
  //   });
  // }

  @override
  void initState() {
    final provider = Provider.of<ListTodoItem>(context, listen: false);
    super.initState();
    titleController.text = widget.item?.title ?? "";
    descController.text = widget.item?.description ?? "";
    dateTimeController.text = widget.item?.date ?? "";
    text = (widget.item?.id == null) ? "Add Activity" : "Edit Activity";
    idController = widget.item?.id ?? Random.secure().nextInt(20);
    //timeController = widget.item?.time ?? TimeOfDay.now().toString();
  }

  @override
  Widget build(BuildContext context) {
    // final arguments =
    //     ModalRoute.of(context)!.settings.arguments as List<TodoItem>;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add your ToDo Activity"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.title,
                      color: Colors.deepPurple,
                    ),
                    hintText: "Enter your Activity Title"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: descController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.abc,
                    color: Colors.deepPurple,
                  ),
                  hintText: "Enter your Activity",

                  // prefix: Icon(
                  //   Icons.key,
                  //   color: Colors.red,
                  // ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
                onChanged: (value) {
                  debugPrint(
                      "----------------------$value----------------------");
                },
              ),
              TextFormField(
                controller: dateTimeController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.calendar_month,
                      color: Colors.deepPurple,
                    ),
                    hintText: "Choose Date and Time"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please select a date and time';
                  }
                  return null;
                },
                onTap: tapDateTime,
              ),
              const Text(
                "Priority",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: List.generate(
                    4,
                    (index) {
                      final random = Random.secure().nextInt(360);
                      final hslColor = HSLColor.fromColor(Colors.red);
                      final color = hslColor
                          .withHue(double.parse(random.toString()))
                          .toColor();

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ValueListenableBuilder(
                            valueListenable: priorityIndex,
                            builder: (context, priority, _) {
                              return GestureDetector(
                                onTap: () {
                                  priorityIndex.value = index;
                                  colorController = color;
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: priority == index
                                        ? color
                                        : color.withOpacity(0.3),
                                  ),
                                  width: 25,
                                  height: 25,
                                ),
                              );
                            }),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        addNewTodo(context: context);
                      }
                    },
                    child: Text(text)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
