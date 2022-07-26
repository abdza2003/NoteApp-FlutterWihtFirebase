import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sampleproject/Firebase/Auth.dart';
import 'package:sampleproject/Theme/ThemeController.dart';
import 'package:sampleproject/Theme/Themes.dart';
import 'package:sampleproject/main.dart';
import 'package:sampleproject/screen/homePageScreen.dart';
import 'package:sampleproject/widget/inputFaild.dart';
import 'package:shared_preferences/shared_preferences.dart';

class authScreen extends StatefulWidget {
  int pageIndex = 0;
  authScreen({required this.pageIndex});
  @override
  State<authScreen> createState() => _authScreenState();
}

class _authScreenState extends State<authScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'userName': '',
    'email': '',
    'password': '',
  };

  late PageController _controller =
      PageController(initialPage: widget.pageIndex);

  bool showPass = true;
  Color left = Colors.black;
  double isHeight = 0.0;
  double isWidth = 0.0;
  @override
  void initState() {
    super.initState();
  }

  Color right = Colors.white;
  // 350 - 450

  @override
  Widget build(BuildContext context) {
    isHeight = widget.pageIndex == 0
        ? MediaQuery.of(context).size.height / (2.16)
        : MediaQuery.of(context).size.height / (1.7);
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              padding: EdgeInsets.symmetric(horizontal: 5),
              height: MediaQuery.of(context).size.height / 14.4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 0, 132, 150).withOpacity(1),
                    Color.fromARGB(255, 0, 136, 154).withOpacity(.6),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    height: MediaQuery.of(context).size.height / 15.2,
                    width: MediaQuery.of(context).size.width / 3,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: widget.pageIndex == 0
                          ? Colors.white
                          : Colors.transparent,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _controller.animateToPage(0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.decelerate);
                        });
                      },
                      child: Text(
                        'Existing',
                        style: Themes().headLine3.copyWith(
                              fontSize: 20,
                              color: widget.pageIndex == 0
                                  ? Colors.black
                                  : Colors.white,
                            ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height / 15.2,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: widget.pageIndex == 1
                          ? Colors.white
                          : Colors.transparent,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _controller.animateToPage(1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.decelerate);
                        });
                      },
                      child: Text(
                        'New',
                        style: Themes().headLine3.copyWith(
                              fontSize: 20,
                              color: widget.pageIndex == 1
                                  ? Colors.black
                                  : Colors.white,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              constraints: BoxConstraints(
                maxHeight: isHeight,
                minHeight: isHeight,
              ),
              width: MediaQuery.of(context).size.width / 1.16,
              // 360 - 280
              child: Form(
                key: _formKey,
                child: PageView(
                  controller: _controller,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (int i) {
                    setState(() {
                      print('========= $i');
                      if (i == 0) {
                        widget.pageIndex = 0;
                        isHeight =
                            (MediaQuery.of(context).size.height) / (2.16);
                        left = Colors.black;
                        right = Colors.white;
                      } else {
                        widget.pageIndex = 1;
                        isHeight = (MediaQuery.of(context).size.height) / (1.7);

                        left = Colors.white;
                        right = Colors.black;
                      }
                    });
                  },
                  children: [
                    getContainer(),
                    getContainer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  getContainer() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                constraints: BoxConstraints(
                  minHeight: widget.pageIndex == 0
                      ? 0
                      : MediaQuery.of(context).size.height / 15.2,
                  maxHeight: widget.pageIndex == 0
                      ? 0
                      : MediaQuery.of(context).size.height / 5.8,
                ),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: TextStyle(
                        color: ThemeController().themeApp == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          FontAwesomeIcons.user,
                          color: Colors.black54,
                        ),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintText: 'User Name',
                        hintStyle: TextStyle(
                          color: Colors.black45,
                        ),
                      ),
                      validator: (val) {
                        if (val!.isEmpty && widget.pageIndex == 1) {
                          return 'invaild user name';
                        }
                      },
                      onSaved: (val) {
                        _authData['userName'] = val as String;
                        print('===========${_authData['userName']}');
                      },
                    ),
                  ],
                )),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(
                  color: ThemeController().themeApp == ThemeMode.light
                      ? Colors.black
                      : Colors.white,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.black54,
                  ),
                  border: OutlineInputBorder(),
                  hintText: 'Email Address',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.black45,
                  ),
                ),
                validator: (val) {
                  if (val!.isEmpty || !val.contains('@')) {
                    return 'invaild email';
                  }
                },
                onSaved: (val) {
                  _authData['email'] = val as String;
                  print('===========${_authData['email']}');
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(
                  color: ThemeController().themeApp == ThemeMode.light
                      ? Colors.black
                      : Colors.white,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.black54,
                  ),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Colors.black45,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      showPass == false
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      setState(() {
                        showPass = !showPass;
                      });
                    },
                  ),
                ),
                obscureText: showPass,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'invaild password';
                  } else if (val.length < 6) {
                    return 'short password';
                  }
                },
                onSaved: (val) {
                  _authData['password'] = val as String;
                  print('===========${_authData['password']}');
                },
              ),
              SizedBox(
                height: 20,
              ),
              !isLoading
                  ? ElevatedButton(
                      onPressed: () {
                        _submit();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          widget.pageIndex == 1 ? 'SIGN UP' : 'LOGIN',
                          style: Themes()
                              .headLine3
                              .copyWith(color: Colors.white, fontSize: 20),
                        ),
                      ))
                  : Center(
                      child: CircularProgressIndicator(
                        color: Colors.cyan[800],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      return;
    } else {
      FocusScope.of(context).unfocus();
      _formKey.currentState!.save();
    }

    setState(() {
      isLoading = true;
    });
    try {
      if (widget.pageIndex == 0) {
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email'] as String,
          _authData['password'] as String,
        );
        var x = Provider.of<Auth>(context, listen: false).addNewUser;
        print('================== ${x[0].Id}');
        pref.setString('key', '${x[0].Id}');
        pref.setBool('fetch', true);
        Get.off(() => homePageScreen());
      } else {
        await Provider.of<Auth>(context, listen: false).signUp(
          _authData['email'] as String,
          _authData['password'] as String,
        );
        var x = Provider.of<Auth>(context, listen: false).addNewUser;
        newAccountCreated(
          id: '${x[0].Id}',
          userName: _authData['userName'] as String,
          email: _authData['email'] as String,
          password: _authData['password'] as String,
        );
        Get.off(() => homePageScreen());
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      var errorMessage = 'Authenticatio Faild';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      getSnackBar(errorMessage);
    }
  }

  bool isLoading = false;
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
