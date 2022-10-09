// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTimeRange? selectedRange;
  void openDateRange() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000, 05, 29),
      lastDate: DateTime(2090, 12, 20),
      currentDate: DateTime.now(),
      saveText: 'Done',
    );

    if (result != null) {
      print(result.start.toString());
      setState(() {
        selectedRange = result;
      });
    }
  }

  //Pop up when delete Icon is pressed
  Widget _popUpDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      // contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 20),
      title: const Text('Delete Date Picked'),
      content: SizedBox(
        height: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text('Are you sure you want to delete date picked?')],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();

                setState(() {
                  selectedRange = null;
                });
              },
              textColor: Theme.of(context).primaryColor,
              child: Text(
                'Yes',
                style: TextStyle(color: Colors.red),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              textColor: Theme.of(context).primaryColor,
              child: Text(
                'No',
              ),
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Date Picker'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: openDateRange,
          child: const Icon(Icons.date_range),
        ),
        body: selectedRange == null
            ? Center(
                child: Text(
                  'No Date to show. Press the button to select one.',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
              )
            : SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(children: [
                  Center(
                    child: Card(
                      color: Colors.purple,
                      margin: EdgeInsets.only(top: 100, bottom: 220),
                      elevation: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Date Picked',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          SizedBox(height: 30),
                          Container(
                            width: 290,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.deepPurpleAccent,
                                borderRadius: BorderRadius.zero),
                            child: Center(
                              child: Text(
                                "Start date: ${selectedRange?.start.toString().split(' ')[0]}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 290,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.zero),
                            child: Center(
                              child: Text(
                                "End date: ${selectedRange?.end.toString().split(' ')[0]}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _popUpDialog(context),
                              );
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                  color: Colors.redAccent,
                                  shape: BoxShape.circle),
                              child: const Center(
                                  child: Icon(
                                CupertinoIcons.delete,
                                color: Colors.white,
                                size: 35,
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ));
  }
}
