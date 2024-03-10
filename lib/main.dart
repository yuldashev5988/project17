import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project17/pages/home_page.dart';
import 'package:project17/pages/user_page.dart';
import 'package:toast/toast.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('login');
  await Hive.openBox('user');


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
      routes: {
        HomePage.id:(context)=>HomePage(),
        UserPage.id:(context)=>UserPage(),
      }
    );
  }
}

