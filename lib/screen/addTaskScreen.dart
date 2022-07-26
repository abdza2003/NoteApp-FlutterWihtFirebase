import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:sampleproject/Theme/ThemeController.dart';
import 'package:sampleproject/Theme/Themes.dart';

import 'package:sampleproject/main.dart';
import 'package:sampleproject/screen/homePageScreen.dart';
import 'package:sampleproject/widget/inputFaild.dart';
import 'package:sampleproject/widget/myButton.dart';

class addTaskScreen extends StatefulWidget {
  @override
  State<addTaskScreen> createState() => _addTaskScreenState();
}

class _addTaskScreenState extends State<addTaskScreen> {
  ThemeController s1 = Get.find();

  TextEditingController _TextTitle = new TextEditingController();
  TextEditingController _TextNote = new TextEditingController();
  ////
  late DateTime savedDateTime;
  late String getSavedDateTime;
  ////
  late int selectedColor;
  late List<int> ListColor;
  Random a = new Random();
  late final noteId;
  String? idKey = pref.getString('key');

///////////

  @override
  void initState() {
    noteId = a.nextInt(999);
    savedDateTime = DateTime.now();
    getSavedDateTime =
        formatDate(savedDateTime, [mm, '/', dd, ' ', hh, ':', nn, ' ', am]);

    ListColor = [0, 1, 2];
    selectedColor = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '2'.tr,
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedOpacity(
            duration: Duration(microseconds: 300),
            opacity: isLoading == true ? .4 : 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${DateFormat.yMMMEd().format(DateTime.now())}',
                      style: Themes().headLine3.copyWith(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    inputFaild(
                      maxLength: 50,
                      title: '5'.tr,
                      hintText: '10'.tr,
                      textEditingController: _TextTitle,
                      maxLines: 1,
                    ),
                    inputFaild(
                      maxLines: 3,
                      maxLength: 200,
                      title: '6'.tr,
                      hintText: '11'.tr,
                      textEditingController: _TextNote,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '8'.tr,
                              style: Themes().headLine3,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: List.generate(
                                ListColor.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.all(2.4),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedColor = index;
                                      });
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: index == 0
                                              ? Colors.red
                                              : index == 1
                                                  ? Colors.orange
                                                  : Colors.indigo,
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              (39.5),
                                        ),
                                        index == selectedColor
                                            ? Icon(Icons.done)
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        MyButton(func: submit, title: '9'.tr)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isLoading == true)
            Stack(
              alignment: Alignment.center,
              children: [
                AnimatedOpacity(
                  opacity: .6,
                  duration: Duration(milliseconds: 300),
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.cyan[800],
                    child: SvgPicture.asset(
                      'images/task-6.svg',
                      height: MediaQuery.of(context).size.height / (6.2),
                      width: MediaQuery.of(context).size.width / (6.2),
                      color: Colors.white,
                    ),
                  ),
                ),
                CircularProgressIndicator(
                  color: Colors.cyan[700],
                ),
              ],
            )
        ],
      ),
    );
  }

  bool isLoading = false;
  submit() async {
    if (_TextNote.text.isEmpty && _TextTitle.text.isEmpty) {
      getSnackBar('17'.tr);
    } else if (_TextNote.text.isEmpty) {
      getSnackBar('19'.tr);
    } else if (_TextTitle.text.isEmpty) {
      getSnackBar('19'.tr);
    } else {
      setState(() {
        isLoading = true;
      });
      var res = await FirebaseFirestore.instance
          .collection('newAccount')
          .doc('$idKey')
          .collection('note')
          .doc('${noteId}')
          .set({
        'title': '${_TextTitle.text}',
        'note': '${_TextNote.text}',
        'color': '${selectedColor}',
        'date': '${getSavedDateTime}',
        'id': '${noteId}',
      });
      setState(() {
        isLoading = false;
      });
      Get.off(() => homePageScreen());
    }
  }

  getSnackBar(String title) {
    Get.snackbar(
      '16'.tr,
      '$title',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.cyan[800],
      colorText: Colors.white,
      icon: Icon(Icons.error),
      margin: EdgeInsets.all(15),
    );
  }
}
