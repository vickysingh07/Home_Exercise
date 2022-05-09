import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home_exercise/Screens/WorkOutDet.dart';
import 'package:home_exercise/model/model.dart';

import 'package:provider/provider.dart';

class BreakTime extends StatelessWidget {
  List<Yoga> ListOfYoga;
  int yogaindex;

  BreakTime({
    required this.ListOfYoga,
    required this.yogaindex,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerModelSec>(
      create: (context) => TimerModelSec(context, ListOfYoga, yogaindex),
      child: Scaffold(
          body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1558017487-06bf9f82613a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=470&q=80"))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              "Break Time",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Consumer<TimerModelSec>(
              builder: (context, myModel, child) {
                return Text(
                  myModel.countdown.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 55,
                      color: Colors.black),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                  child: Text(
                    "SKIP",
                    style: TextStyle(fontSize: 19),
                  ),
                )),
            Spacer(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Previous",
                        style: TextStyle(fontSize: 16),
                      )),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Next",
                        style: TextStyle(fontSize: 16),
                      ))
                ],
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text(
                    "Next: ${yogaindex >= ListOfYoga.length - 1 ? "FINISH" : ListOfYoga[yogaindex].YogaTitle}EEE",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ),
      )),
    );
  }
}

class TimerModelSec with ChangeNotifier {
  TimerModelSec(context, List<Yoga> ListOfYoga, int yogaindex) {
    MyTimerSec(context, ListOfYoga, yogaindex);
  }
  int countdown = 3;

  MyTimerSec(context, List<Yoga> ListOfYoga, int yogaindex) async {
    Timer.periodic(Duration(seconds: 1), (timer) {
      countdown--;
      notifyListeners();
      if (countdown == 0) {
        timer.cancel();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => WorkOutDet(
                      ListOfYoga: ListOfYoga,
                      yogaindex: yogaindex,
                    )));
      }
    });
  }
}
