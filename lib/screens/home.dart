import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/screens/add_new_task.dart';
import 'package:todo_app/todoitem.dart';
import 'package:todo_app/constans/color.dart';
import 'package:todo_app/database_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//List<String> todo = ["Study Lessons", "Run 5K", "Go to part"];
//List<String> completed = ["Game meetup", "Take out trash"];

class _HomeScreenState extends State<HomeScreen> {
  List<Task> todo = [];
  List<Task> completed = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    List<Task> tasks = await _databaseHelper.queryAllRows();
    setState(() {
      todo = tasks.where((task) => !task.isCompleted).toList();
      completed = tasks.where((task) => task.isCompleted).toList();
    });
  }

  Future<void> _deleteCompletedTasks() async {
    for (var task in todo.where((task) => task.isCompleted).toList()) {
      await _databaseHelper.delete(task.id);
    }
    _loadTasks(); // Reload tasks after deletion
  }

  void _addNewTask(Task newTask) {
    setState(() {
      todo.add(newTask);
    });
    _databaseHelper.insert(newTask); // Save to database
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: HexColor(backgroundColor),
          body: Column(
            children: [
              Container(
                width: deviceWidth,
                height: deviceHeight / 3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("lib/assests/images/Header.png"),
                      fit: BoxFit.cover),
                ),
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 40.0),
                      child: Text("11 Kasım, 2024",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "My Project",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: todo.length,
                      itemBuilder: (context, index) {
                        return TodoItem(
                          task: todo[index],
                        );
                      },
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 25),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Completed",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: completed.length,
                    itemBuilder: (context, index) {
                      return TodoItem(task: completed[index]);
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddNewTaskScreen(
                          addNewTask: (newTask) => _addNewTask(newTask),
                        ),
                      ));
                    },
                    child: const Text("Add New Task"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _deleteCompletedTasks,
                    child: const Text("Delete Completed Tasks"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
