import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/constans/color.dart';
import 'package:todo_app/constans/taskType.dart';
import 'package:todo_app/model/task.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key, required this.addNewTask});
  final void Function(Task neewtask) addNewTask;

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTaskScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  TextEditingController timeController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TaskType taskType = TaskType.note;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          backgroundColor: HexColor(backgroundColor),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: deviceHeight,
                  height: deviceHeight / 10,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "lib/assests/images/add_new_language_header.png"),
                          fit: BoxFit.cover)),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 40,
                            color: Colors.white,
                          )),
                      const Expanded(
                          child: Text(
                        "Add new task",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ))
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: deviceHeight / 70),
                    child: Text("Task title")),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 231, 197, 197)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight / 70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Category"),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Category selected"),
                          ));
                          setState(() {
                            taskType = TaskType.note;
                          });
                        },
                        child: Image.asset("lib/assests/images/Category.png"),
                      ),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Category selected"),
                          ));
                          setState(() {
                            taskType = TaskType.calender;
                          });
                        },
                        child: Image.asset("lib/assests/images/Category1.png"),
                      ),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Category selected"),
                          ));
                          setState(() {
                            taskType = TaskType.contest;
                          });
                        },
                        child: Image.asset("lib/assests/images/Category2.png"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight / 80),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Date",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              TextField(
                                controller: dateController,
                                decoration: InputDecoration(
                                    label: Text("Date"),
                                    hintText: 'Enter',
                                    suffixIcon: Image.asset(
                                        "lib/assests/images/date_icon.png"),
                                    border: OutlineInputBorder()),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Time",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextField(
                              controller: timeController,
                              decoration: InputDecoration(
                                label: Text("Time"),
                                suffixIcon: Image.asset(
                                    "lib/assests/images/time_icon.png"),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: deviceHeight / 70),
                    child: Text("Description")),
                SizedBox(
                  height: deviceHeight / 3,
                  child: TextField(
                    controller: descriptionController,
                    expands: true,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder()
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Task newTask = Task(
                          type: taskType,
                          title: titleController.text,
                          description: descriptionController.text,
                          isCompleted: false);

                      widget.addNewTask(newTask);
                      Navigator.pop(context);
                    },
                    child: Text("Save"))
              ],
              //ahmetbutun
            ),
          )),
    );
  }
}
