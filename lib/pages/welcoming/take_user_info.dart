import 'package:fitlife2/pages/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitlife2/theme/theme_dataShip.dart';
import 'package:fitlife2/backend_control/app_state_control.dart';
import 'package:fitlife2/backend_control/app_dataB_control.dart';

import '../../widgets/popup_alert.dart';

class TakeRegistry extends StatelessWidget {
  const TakeRegistry({super.key});
  // DateTime? agePicked;

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppStateControl>(context);
    Size screenSize = MediaQuery.sizeOf(context);
    return Theme(
      data: themeDataBoot,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: screenSize.width,
          height: screenSize.height,
          child: SingleChildScrollView(
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                Container(color: mainBlackGenerator(1)),
                Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    width: screenSize.width,
                    height: screenSize.height + 50,
                    "assets/images/manOn_stance.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: screenSize.width / 1.5,
                  height: screenSize.height,
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: secondGreenGenerator(0.4),
                    borderRadius: BorderRadius.circular(5),
                    border: Border(
                      left: BorderSide(
                        style: BorderStyle.solid,
                        width: 3,
                        color: mainGreenGenerator(1),
                      ),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        mainBlackGenerator(0.9),
                        mainGreenGenerator(0.8),
                        mainGreenGenerator(0.7),
                        mainBlackGenerator(0.5),
                        mainBlackGenerator(0.3),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: screenSize.width / 2,
                        height: screenSize.height / 9.15,
                        child: Image.asset("assets/images/appLogo.png"),
                      ),
                      SizedBox(height: 20),
                      // Spacer(),
                      Text(
                        "Fill the following to get Started!  ",
                        style: TextStyle(
                          color: mainWhiteGenerator(1),
                          fontSize: screenSize.width / 20.6,
                        ),
                      ),
                      // SizedBox(height: 20),
                      Spacer(),
                      TextField(
                        style: TextStyle(color: mainWhiteGenerator(0.85)),
                        decoration: InputDecoration(
                          errorText:
                              (appProvider.isUserNameSet)
                                  ? "*Please Enter userName!"
                                  : null,
                          hintText: "User Name",
                          hintStyle: TextStyle(color: mainGreenGenerator(0.4)),
                        ),
                        onChanged: (value) {
                          appProvider.userName = value;
                        },
                        onTap: () {
                          appProvider.changeUserNameError(false);
                        },
                        onSubmitted: (value) {
                          appProvider.addUserNameToMap();
                        },
                      ),

                      // SizedBox(height: 20),
                      Spacer(),
                      SliderSelection(),
                      Spacer(),
                      DatePickerCalender(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:
                            (!appProvider.ageNotSet)
                                ? Text(
                                  "  *Please Enter birth date!",
                                  style: TextStyle(
                                    color: Colors.red.shade400,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w100,
                                  ),
                                )
                                : null,
                      ),
                      Spacer(),
                      GenderSelection(),
                      // SizedBox(height: 10),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          appProvider.addUserNameToMap();

                          if (appProvider.checkUserProfileData()) {
                            // for (var item in userProfileInfo.entries) {
                            //   print(item.value);
                            // }
                            if (userProfileInfo["weight"] == null) {
                              userProfileInfo["weight"] = 70;
                            }
                            if (userProfileInfo["height"] == null) {
                              userProfileInfo["height"] = 120;
                            }
                            if (userProfileInfo["gender"] == null) {
                              userProfileInfo["gender"] = "male";
                            }
                            storeToPreferences(userProfileInfo);
                            // getFromPreferences("userName");

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => popUPAlert(
                                      context,
                                      "Data",
                                      ["Saved successfully!", "Not Saved!"],
                                      [MainPage(), TakeRegistry()],
                                      true,
                                    ),
                              ),
                            );
                          }
                          appProvider.changeUserNameError(
                            appProvider.userName == "",
                          );
                          appProvider.changeAgeSet(
                            userProfileInfo["age"] != -1,
                          );
                        },
                        child: Text("Save"),
                      ),
                      Spacer(),
                      SizedBox(height: 10),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GenderSelection extends StatefulWidget {
  const GenderSelection({super.key});

  @override
  _GenderSelection createState() => _GenderSelection();
}

class _GenderSelection extends State<GenderSelection> {
  String _selectedGender = "male";
  void changeGender(value) {
    setState(() {
      _selectedGender = value!;
      userProfileInfo["gender"] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);

    return SizedBox(
      width: screenSize.width / 2.5,
      child: Column(
        children: [
          RadioListTile<String>(
            title: Text(
              "Male",
              style: TextStyle(
                color:
                    (_selectedGender == "male")
                        ? mainWhiteGenerator(0.85)
                        : mainGreyGenerator(1),
              ),
            ),
            value: "male",
            groupValue: _selectedGender,
            onChanged: (value) {
              changeGender(value);
            },
          ),
          RadioListTile<String>(
            title: Text(
              "Female",
              style: TextStyle(
                color:
                    (_selectedGender == "female")
                        ? mainWhiteGenerator(0.85)
                        : mainGreyGenerator(1),
              ),
            ),
            value: "female",
            groupValue: _selectedGender,
            onChanged: (value) {
              changeGender(value);
            },
          ),
        ],
      ),
    );
  }
}

class SliderSelection extends StatefulWidget {
  const SliderSelection({super.key});

  @override
  _SliderSelection createState() => _SliderSelection();
}

class _SliderSelection extends State<SliderSelection> {
  double _userHeight = 120;
  double _userWeight = 70;

  void changNumberData(value, bool isWeight) {
    setState(() {
      if (isWeight) {
        _userWeight = value;
        userProfileInfo["weight"] = value;
      } else {
        _userHeight = value;
        userProfileInfo["height"] = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Weight $_userWeight kg",
          style: TextStyle(color: mainWhiteGenerator(0.8)),
        ),
        Slider(
          value: _userWeight,
          thumbColor: mainGreenGenerator(1),
          activeColor: mainGreenGenerator(0.5),
          label: "Weight",
          min: 20,
          max: 200,
          divisions: 180,
          onChanged: (value) {
            changNumberData(value, true);
          },
        ),
        Text(
          "Height $_userHeight cm",
          style: TextStyle(color: mainWhiteGenerator(0.8)),
        ),
        Slider(
          value: _userHeight,
          thumbColor: mainGreenGenerator(1),
          activeColor: mainGreenGenerator(0.5),
          divisions: 200,
          label: "Height",
          min: 50,
          max: 250,
          onChanged: (value) {
            changNumberData(value, false);
          },
        ),
      ],
    );
  }
}

class DatePickerCalender extends StatefulWidget {
  const DatePickerCalender({super.key});

  @override
  _DatePickerCalender createState() => _DatePickerCalender();
}

class _DatePickerCalender extends State<DatePickerCalender> {
  DateTime? agePicked;

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppStateControl>(context);
    return Row(
      children: [
        Text(
          "Age  ${(agePicked != null) ? DateTime.now().year - agePicked!.year : "not Set"} ",
          style: TextStyle(color: mainWhiteGenerator(1)),
        ),
        SizedBox(width: 20),
        ElevatedButton(
          onPressed: () async {
            agePicked = await showDatePicker(
              context: context,
              initialDatePickerMode: DatePickerMode.year,
              firstDate: DateTime(1945),
              lastDate: DateTime(2015, DateTime.december, 31),
              switchToInputEntryModeIcon: Icon(
                CupertinoIcons.keyboard,
                color: mainGreenGenerator(1),
              ),
              switchToCalendarEntryModeIcon: Icon(
                CupertinoIcons.calendar_circle_fill,
                color: mainGreenGenerator(1),
              ),
              errorInvalidText: "Please input a valid date",
              barrierColor: mainGreenGenerator(0.37),
              barrierLabel: "Choose your birth date",
            );
            setState(() {
              userProfileInfo["age"] =
                  (agePicked != null)
                      ? DateTime.now().year - agePicked!.year
                      : -1;
              appProvider.changeAgeSet(userProfileInfo["age"] != -1);
            });
          },
          child: Icon(
            CupertinoIcons.calendar_badge_plus,
            color: mainBlackGenerator(1),
          ),
        ),
      ],
    );
  }
}
