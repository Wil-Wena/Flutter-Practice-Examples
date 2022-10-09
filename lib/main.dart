import 'package:flutter/material.dart';
import 'package:flutter_practice_examples/Examples/DateRangePicker.dart';
import 'package:flutter_practice_examples/Examples/Search_a_List.dart';
import 'package:flutter_practice_examples/Examples/StepperWidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const SearchPage(),
    );
  }
}
