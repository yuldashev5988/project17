import 'package:flutter/material.dart';
import 'package:project17/pages/home_page.dart';
import 'package:project17/services/hive.dart';
import 'package:project17/services/logger.dart';

import '../model/user.dart';
import '../services/toast.dart';

class UserPage extends StatefulWidget {
  static const String id = "user_page";

  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  late User user;


  void saveInfo() {
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email.isNotEmpty &&
        password.isNotEmpty &&
        firstName.isNotEmpty &&
        lastName.isNotEmpty) {
      User user = User(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password);
      HiveService.storeUserObj(object: user, objectKey: "user");
      Toast2222.showToast();
    } else {
      Toast2222.showToast2();
    }
    makeFieldsEmpty();
  }
  void makeFieldsEmpty(){
    firstNameController.text="";
    lastNameController.text="";
    emailController.text="";
    passwordController.text="";

  }


  void getInfo(String objectKey) {
    setState(() {
      user = HiveService.getUserObj(objKey: objectKey);
    });
  }

  bool deleteInfo(String objectKey) {
    return HiveService.removeObject(objKey: objectKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "User",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, HomePage.id);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "First Name",
                  labelStyle: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Last Name",
                  labelStyle: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Email",
                  labelStyle: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Password",
                  labelStyle: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        saveInfo();
                      });
                    },
                    child: Text("Save")),
                ElevatedButton(
                    onPressed: () {
                      getInfo("user");
                      if (user.firstName != null) {
                        Toast2222.showToast3();
                      } else {
                        Toast2222.showToast4();
                      }
                    },
                    child: Text("Get")),
                ElevatedButton(
                    onPressed: () {
                      if (deleteInfo("user")) {
                        Toast2222.showToast5();
                      } else {
                        Toast2222.showToast6();
                      }
                    },
                    child: Text("Delete")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
