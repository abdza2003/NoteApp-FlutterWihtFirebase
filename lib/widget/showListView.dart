import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sampleproject/Locale/localeController.dart';
import 'package:sampleproject/Theme/ThemeController.dart';
import 'package:sampleproject/Theme/Themes.dart';
import 'package:sampleproject/main.dart';
import 'package:sampleproject/screen/descriptionScreen.dart';
import 'package:sampleproject/widget/bottoSheatItem.dart';
import 'package:sampleproject/widget/emtyNoteList.dart';

class showListView extends StatefulWidget {
  @override
  State<showListView> createState() => _showListViewState();
}

class _showListViewState extends State<showListView> {
  ThemeController s1 = Get.find();
  LocaleControllar s3 = Get.find();
  String? idKey = pref.getString('key');
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await FirebaseFirestore.instance
            .collection('/newAccount/${idKey}/note')
            .snapshots();
      },
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('/newAccount/${idKey}/note')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<DocumentSnapshot> s1 = snapshot.data!.docs;

          return !s1.isEmpty
              ? ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: s1.length,
                  itemBuilder: ((context, index) {
                    var itemcount = (s1.length - 1) - index;
                    // var getInf = s2.note[itemcount];
                    // print('---------- ${s2.note[0]}');
                    return GestureDetector(
                      onTap: () async {
                        await Get.bottomSheet(
                          Container(
                            height: MediaQuery.of(context).size.height / (3.2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:
                                  ThemeController().themeApp == ThemeMode.dark
                                      ? Color.fromARGB(207, 53, 52, 52)
                                      : Color.fromARGB(207, 255, 255, 255),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  bottomSheetItem(
                                    func: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          duration: Duration(milliseconds: 300),
                                          child: descriptionScreen(
                                            inf:
                                                '${s1[itemcount]['date']} |${s1[itemcount]['title']} |${s1[itemcount]['note']} |  ${s1[itemcount]['color']}',
                                          ) as Widget,
                                          type: PageTransitionType.bottomToTop,
                                        ),
                                      );
                                    },
                                    title: '24'.tr,
                                  ),
                                  bottomSheetItem(
                                    func: () async {
                                      await FirebaseFirestore.instance
                                          .collection('newAccount')
                                          .doc('$idKey')
                                          .collection('note')
                                          .doc('${s1[itemcount]['id']}')
                                          .delete();
                                      Get.back();
                                    },
                                    title: '25'.tr,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    // height: 50,
                                    width: 200,
                                    child: Divider(
                                      color: ThemeController().themeApp ==
                                              ThemeMode.dark
                                          ? Colors.white
                                          : Colors.black,
                                      thickness: 2,
                                    ),
                                  ),
                                  bottomSheetItem(
                                    func: () {
                                      Get.back();
                                    },
                                    title: '26'.tr,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: AnimationConfiguration.staggeredList(
                        duration: Duration(milliseconds: 1500),
                        position: index,
                        child: SlideAnimation(
                          horizontalOffset: 300,
                          child: FadeInAnimation(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: s1[itemcount]['color'] == '0'
                                      ? Colors.redAccent
                                      : s1[itemcount]['color'] == '1'
                                          ? Colors.orange
                                          : Colors.indigo,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${s1[itemcount]['title']}",
                                        style: Themes()
                                            .headLine1
                                            .copyWith(fontSize: 22),
                                      ),
                                      SizedBox(
                                        height: 2.5,
                                      ),
                                      Text(
                                        "${s1[itemcount]['date']}",
                                        style: Themes().headLine1.copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                      SizedBox(
                                        width: 120,
                                        child: Divider(
                                          color: Colors.white,
                                          thickness: 1.2,
                                        ),
                                      ),
                                      Container(
                                        margin: s3.getLoclae == Locale('en')
                                            ? EdgeInsets.only(right: 40)
                                            : EdgeInsets.only(left: 40),
                                        child: Text(
                                          s1[itemcount]['note'].length < 65
                                              ? "${s1[itemcount]['note']}"
                                              : '${s1[itemcount]['note'].toString().substring(0, 65)} ... ',
                                          style: Themes()
                                              .headLine1
                                              .copyWith(fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                )
              : isEmptyList();
        },
      ),
    );
  }
}
