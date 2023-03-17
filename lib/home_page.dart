import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/todo_item_card.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/screens/todo_add_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.watch<ListTodoItem>();
    debugPrint(
        "----------------------context is watching you----------------------");
  }

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<ListTodoItem>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Consumer<ListTodoItem>(builder: (context, list, _) {
        return SingleChildScrollView(
          controller: controller,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 15,
              right: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEFF5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const TextField(
                    //onChanged: (value),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      prefixIcon: Icon(
                        Icons.menu,
                        color: Colors.deepPurple,
                        size: 25,
                      ),
                      prefixIconConstraints: BoxConstraints(
                        maxHeight: 24,
                        minWidth: 25,
                      ),
                      border: InputBorder.none,
                      hintText: 'Search Activity',
                      hintStyle: TextStyle(
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ),

                const Text(
                  "Choose Activity",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  controller: controller,
                  itemCount: list.todoItemList.length,
                  itemBuilder: (context, index) => TodoItemCard(
                    item: list.todoItemList[index],
                  ),
                ),

                // todoItemList
                //     .map((item) => TodoItemCard(
                //         foregroundIcon: item.icon,
                //         title: item.title,
                //         description: item.description))
              ],
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.of(context)
          //     .pushNamed("/todo_add_screen", arguments: todoItemList);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const TodoAddScreen(),
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
