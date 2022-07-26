import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sampleproject/Locale/localeController.dart';
import 'package:sampleproject/Theme/ThemeController.dart';
import 'package:sampleproject/Theme/Themes.dart';

import 'package:sampleproject/controller/showStyle.dart';
import 'package:sampleproject/main.dart';
import 'package:sampleproject/screen/addTaskScreen.dart';
import 'package:sampleproject/widget/getDrawer.dart';
import 'package:sampleproject/widget/myButton.dart';
import 'package:sampleproject/widget/showGridView.dart';
import 'package:sampleproject/widget/showListView.dart';

class homePageScreen extends StatefulWidget {
  @override
  State<homePageScreen> createState() => _homePageScreenState();
}

class _homePageScreenState extends State<homePageScreen> {
  ThemeController s1 = Get.find();
  LocaleControllar s3 = Get.find();
  String? idKey = pref.getString('key');
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('=========================${MediaQuery.of(context).size.height}');
    print('=========================${MediaQuery.of(context).size.width}');
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              ShowStyle().getshowStyle == 0
                  ? Icons.grid_view
                  : Icons.filter_list,
            ),
            onPressed: () {
              setState(() {
                ShowStyle().changeStyle();
              });
            },
          ),
          IconButton(
            icon: Icon(
              s1.themeApp == ThemeMode.dark ? Icons.sunny : Icons.dark_mode,
            ),
            onPressed: () {
              setState(() {
                s1.ChangeTheme();
              });
            },
          ),
        ],
        title: Text(
          '1'.tr,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / (19.6),
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: s1.themeApp != ThemeMode.dark
            ? Color.fromARGB(255, 223, 226, 228)
            : Color.fromARGB(255, 53, 52, 52),
        child: drawer(),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                _nowDate(),
                SizedBox(
                  height: 20,
                ),
                getNotes(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _nowDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '3'.tr,
              style: Themes().headLine3.copyWith(
                    fontSize: MediaQuery.of(context).size.width / (16.6),
                  ),
            ),
            Text(
              '${DateFormat.yMMMEd().format(DateTime.now())}',
              style: Themes().headLine3.copyWith(
                    fontSize: MediaQuery.of(context).size.width / (24.6),
                  ),
            ),
          ],
        ),
        MyButton(
          func: () async {
            await Navigator.push(
              context,
              PageTransition(
                duration: Duration(milliseconds: 300),
                child: addTaskScreen(),
                type: PageTransitionType.rightToLeft,
              ),
            );
          },
          title: '2'.tr,
        ),
      ],
    );
  }

  _NotesIsEmpty() {
    return AnimationConfiguration.staggeredGrid(
      columnCount: 0,
      position: 0,
      child: ScaleAnimation(
        duration: Duration(milliseconds: 1500),
        child: FadeInAnimation(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: RefreshIndicator(
              onRefresh: () async {
                await FirebaseFirestore.instance
                    .collection('/newAccount/${idKey}/note')
                    .snapshots();
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'images/addNote.svg',
                      height: MediaQuery.of(context).size.height / (5.2),
                      width: MediaQuery.of(context).size.width / (5.2),
                      color: Colors.cyan[700],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      // color: Colors.red,
                      width: MediaQuery.of(context).size.width / (1.4),
                      child: Text(
                        '27'.tr,
                        style: Themes().headLine3.copyWith(
                              fontSize:
                                  MediaQuery.of(context).size.width / (22.6),
                              color:
                                  ThemeController().themeApp == ThemeMode.light
                                      ? Colors.black.withOpacity(.6)
                                      : Colors.white.withOpacity(.6),
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _NotesIsNotEmpty() {
    return ShowStyle().getshowStyle == 0 ? showListView() : showGridView();
  }

  getNotes() {
    /*  return Obx(() {
      if (s2.note.isEmpty) {
        return _NotesIsEmpty();
      } else {
        return Expanded(
          child: _NotesIsNotEmpty(),
        );
      }
    }); */
    return Expanded(
      child: _NotesIsNotEmpty(),
    );
  }
}
