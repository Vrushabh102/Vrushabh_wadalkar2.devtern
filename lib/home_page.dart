import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State {
  int sec = 0;
  int min = 0;
  int hrs = 0;
  String digitSec = "00", digMin = "00", digHr = "00";
  Timer? timer;
  bool started = false;

  List Laps = [];

  // stop Function

  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  // reset Function

  void reset() {
    timer!.cancel();
    setState(() {
      sec = 0;
      min = 0;
      hrs = 0;
      digitSec = "00";
      digMin = "00";
      digHr = "00";
      Laps.clear();
      started = false;
    });
  }

  // adding Laps Function

  void addlap() {
    String lap = "$digHr:$digMin:$digitSec";
    setState(() {
      Laps.add(lap);
    });
  }

  //  start Function

  void start() {
    started = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int localsec = sec + 1;
      int localmin = min;
      int localhours = hrs;
      if (localsec > 59) {
        if (localmin > 59) {
          localhours++;
          localmin = 0;
        } else {
          localmin++;
          localsec = 0;
        }
      }

      setState(() {
        sec = localsec;
        min = localmin;
        hrs = localhours;

        digitSec = (sec >= 10) ? "$sec " : "0$sec";
        digMin = (min >= 10) ? "$min" : "0$min";
        digHr = (hrs >= 10) ? "$hrs" : "0$hrs";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 75, 93),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'StopWatch App',
                  style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Expanded(
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 31, 75, 93), shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      '$digHr:$digMin:$digitSec',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 55.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 400.0,
                  decoration: BoxDecoration(
                      // color: Color(0xFF313E66),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: ListView.builder(
                      itemCount: Laps.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Lap ${index + 1}",
                                style: const TextStyle(
                                    fontSize: 16.0, color: Colors.white),
                              ),
                              Text(
                                "${Laps[index]}",
                                style: const TextStyle(
                                    fontSize: 16.0, color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: RawMaterialButton(
                    onPressed: () {
                      (!started) ? start() : stop();
                    },
                    shape: const StadiumBorder(
                        side: BorderSide(color: Colors.blue)),
                    child: Text(
                      (!started) ? "Start" : "Stop",
                      style: const TextStyle(color: Colors.white),
                    ),
                  )),
                  const SizedBox(
                    width: 6.0,
                  ),
                  IconButton(
                    onPressed: () {
                      addlap();
                    },
                    icon: const Icon(
                      Icons.flag,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  Expanded(
                      child: RawMaterialButton(
                    onPressed: () {
                      reset();
                    },
                    fillColor: Colors.blue,
                    shape: const StadiumBorder(),
                    child: const Text(
                      'Restart',
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
