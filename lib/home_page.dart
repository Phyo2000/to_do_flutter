import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/todo_item_card.dart';
import 'package:todo_app/screens/todo_add_screen.dart';
import 'package:todo_app/models/todo_model.dart';
//import 'package:http/http.dart' as https;

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
      body: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: const Color(0xFFEEEFF5),
            child: Row(
              children: [
                SizedBox(
                  width: 250,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Good Morning John",
                          style: TextStyle(fontSize: 19),
                        ),
                        const Text(
                          "Today",
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "28 Feb, 2023",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      Text(
                        "Completed",
                        style: TextStyle(color: Colors.green, fontSize: 16),
                      ),
                      Text("1/4"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Consumer<ListTodoItem>(builder: (context, list, _) {
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
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEEFF5),
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
                          hintStyle: TextStyle(color: Colors.deepPurple),
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // pic = await https.get(Uri.parse(
          //     "https://random.imagecdn.app/v1/image?width=500&height=500&category=people"));
          // print("pass");

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
