import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:money_tracker/data_entry.dart';
import 'package:money_tracker/file_handler.dart';
import 'package:money_tracker/text_analysis.dart';
import 'package:money_tracker/visuals.dart';

List<Widget> screens = [DataEntry(), Visuals(), TextAnalysis()];
late Map<dynamic, dynamic> currentFileData;

void main() {
  runApp(
    Main(),
  );
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int navIndex = 0;
  bool processRunning = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      processRunning = true;
    });
    WidgetsBinding.instance.addPostFrameCallback(
      (d) async {
        if (!(await FileManager.checkFilePresent("data.txt")) ||
            DateTime.now().day == 1) {
          await Get.to(
            Setup(),
          );
        }
        // Get data and decode
        currentFileData = jsonDecode(await FileManager.readFile("data.txt"));
      },
    );
    setState(() {
      processRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SafeArea(
        child: ModalProgressHUD(
            inAsyncCall: processRunning,
            child: Scaffold(
              body: screens[navIndex],
              appBar: AppBar(
                title: Text("Money Tracker"),
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: navIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.edit_note,
                      color: Colors.black,
                    ),
                    label: "New expense",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.bar_chart,
                      color: Colors.black,
                    ),
                    label: "Charts",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.table_chart,
                      color: Colors.black,
                    ),
                    label: "Analysis",
                  ),
                ],
                onTap: (v) {
                  setState(() {
                    navIndex = v;
                  });
                },
              ),
            )),
      ),
    );
  }
}

class Setup extends StatefulWidget {
  const Setup({super.key});

  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Setup goals",
            textAlign: TextAlign.center,
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          ),
        ),
      ),
    );
  }
}
