import 'package:fitlife2/backend_control/app_dataB_control.dart';
import 'package:fitlife2/pages/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitlife2/theme/theme_dataShip.dart';
import 'package:fitlife2/pages/welcoming/take_user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartWelcomePage extends StatelessWidget {
  // const StartWelcomePage({super.key});
  bool _isNewUser = true;
  Future<void> isNewUserPref() async {
    final prefer = await SharedPreferences.getInstance();
    // print(prefer.get("isNewUser"));
    _isNewUser = prefer.getBool("isNewUser")!;
  }

  StartWelcomePage({super.key}) {
    // print("User first time checked");
    isNewUserPref();
    fillFromSharedPref();
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(color: mainBlackGenerator(1)),
          Image.asset(
            "assets/images/StartPageBackground.jpg",
            // width: screenSize.width,
            // height: screenSize.height,
            fit: BoxFit.cover,
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: screenSize.height / 3.67,
                    width: 2,
                    color: mainGreenGenerator(1),
                  ),
                  Text(
                    "WELCOME",
                    style: TextStyle(
                      color: mainWhiteGenerator(0.9),
                      fontSize: screenSize.width / 6.86,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "to",
                    style: TextStyle(
                      color: secondGreenGenerator(1),
                      fontSize: screenSize.width / 10.3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "FitLife !",
                    style: TextStyle(
                      color: mainGreenGenerator(1),
                      fontSize: screenSize.width / 10.3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: screenSize.height / 3,
                    width: 2,
                    color: mainGreenGenerator(1),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // checking if user is using for 1st time
                      _isNewUser
                          ? Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => TakeRegistry()),
                          )
                          : Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => MainPage()),
                          );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        mainGreenGenerator(1),
                      ),
                      foregroundColor: WidgetStateProperty.all(
                        mainBlackGenerator(1),
                      ),
                      shadowColor: WidgetStateProperty.all(
                        mainWhiteGenerator(1),
                      ),
                      elevation: WidgetStateProperty.all(10),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          side: BorderSide(style: BorderStyle.none),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    child: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          Text("Get started   "),
                          Icon(
                            CupertinoIcons.arrow_right_circle_fill,
                            color: mainBlackGenerator(1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
