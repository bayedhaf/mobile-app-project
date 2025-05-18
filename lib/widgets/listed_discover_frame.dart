import 'package:fitlife2/backend_control/app_dataB_control.dart';
import 'package:fitlife2/pages/workout_showing_page.dart';
import 'package:fitlife2/theme/theme_dataShip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../network_control/exercise_object.dart';

class ListedDiscoverFrame extends StatefulWidget {
  ListedDiscoverFrame({super.key, required this.exerciseObject});
  ExerciseObject exerciseObject;

  @override
  createState() => _ListedDiscoverFrameState(exerciseObject);
}

class _ListedDiscoverFrameState extends State<ListedDiscoverFrame> {
  ExerciseObject exerciseObject;

  _ListedDiscoverFrameState(this.exerciseObject) {
    _isFavorite = dooo();
  }

  String truncateString(String given) {
    String rw = "";
    given.split(" ").forEach((word) {
      rw += (given.split(" ").indexOf(word) < 2) ? " $word" : "";
    });
    return rw;
  }

  bool dooo() {
    for (var i in favoriteDescovery) {
      if (i == exerciseObject.id) return true;
    }
    return false;
  }

  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      // scrollDirection: Axis.vertical,
      child: Container(
        margin: EdgeInsets.only(bottom: 10, left: 5),
        child: Stack(
          children: [
            Container(
              width: screenSize.width / 5.89,
              height: screenSize.width / 5.89,
              margin: EdgeInsets.only(top: 9, left: 10),
              decoration: BoxDecoration(
                color: mainBlackGenerator(1),
                border: Border.all(
                  width: 5,
                  style: BorderStyle.solid,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: secondGreenGenerator(1),
                    spreadRadius: 9,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
              ),
            ),
            Container(
              // width: screenSize.width-20,
              height: screenSize.width / 4.58,
              margin: EdgeInsets.only(
                left: screenSize.width / 11.78,
                right: 10,
              ),
              decoration: BoxDecoration(
                color: mainBlackGenerator(0.5),
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: mainGreenGenerator(0.4)),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: screenSize.width / 6.87),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,

                          child: Text(
                            truncateString(exerciseObject.name),
                            style: TextStyle(
                              color: mainWhiteGenerator(1),
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Text(
                          "Targets ${exerciseObject.target}",
                          style: TextStyle(
                            color: mainGreyGenerator(1),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isFavorite = !_isFavorite;
                        });
                        controlFavoriteDescovery(
                          exerciseObject.id,
                          _isFavorite,
                        );
                      },
                      icon: Icon(
                        (_isFavorite)
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        color: mainGreenGenerator(1),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => WorkoutShowingPage(
                                  name: exerciseObject.name,
                                  imgUrl: exerciseObject.gifUrl,
                                  steps: exerciseObject.instructions,
                                  isLocal: false,
                                ),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          secondGreenGenerator(1),
                        ),
                      ),
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        color: mainBlackGenerator(1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: screenSize.width / 5.89,
              height: screenSize.width / 5.89,
              margin: EdgeInsets.only(top: 9, left: 10),
              decoration: BoxDecoration(
                color: secondGreenGenerator(1),
                shape: BoxShape.circle,
              ),
              child: Align(child: Icon(CupertinoIcons.app_badge_fill)),
            ),
          ],
        ),
      ),
    );
  }
}
