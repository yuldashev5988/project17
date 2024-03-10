import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:project17/pages/user_page.dart';
import 'package:project17/services/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project17/services/toast.dart';

import '../model/cat.dart';
import '../model/user.dart';

class HomePage extends StatefulWidget {
  static const String id="home_page";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var logger = Logger();

  TextEditingController nameController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String? name;

  String? color;

  int? age;

  Future<void> saveObj() async {
    String name = nameController.text.trim();
    String color = colorController.text.trim();
    int age = int.parse(ageController.text.trim());
    if (name.isNotEmpty && color.isNotEmpty) {
      Cat cat = Cat(name: name, color: color, age: age);
      bool isSaved =
          await SharedPrefs.saveObject(object: cat, objectKey: "cat");
      logger.w(isSaved.toString());
      Toast2222.showToast();
    } else{
      Toast2222.showToast2();
    }
  }

  Future<void> getObj() async {
    Cat cat = await SharedPrefs.getObject("cat");
    setState(() {
      name = cat.name;
      color = cat.color;
      age = cat.age;
    });
    logger.e(cat.name);
    logger.e(cat.color);
    logger.e(cat.age);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getObj();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [IconButton(onPressed: (){
          Navigator.pushReplacementNamed(context, UserPage.id);
        }, icon: Icon(Icons.arrow_forward_ios,color: Colors.white,))],
        title: Text(
          "Shared Preferences",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Name",
                  labelStyle: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                controller: colorController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Color",
                  labelStyle: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                controller: ageController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Age",
                  labelStyle: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        saveObj();
                      });
                    },
                    child: Text("Save")),
                ElevatedButton(
                    onPressed: () async {
                      await getObj();
                    },
                    child: const Text("Get Infos")),
                ElevatedButton(
                    onPressed: () {
                      SharedPrefs.removeObject("cat");
                    },
                    child: const Text("Remove")),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Name:",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      name ?? "None",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Color:",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      color ?? "None",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Age:",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    Text(
                      age!=null? age.toString():"None",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
