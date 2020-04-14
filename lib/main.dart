import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:animated_size_and_fade/animated_size_and_fade.dart';
//import 'package:flutter/src/foundation/change_notifier.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode)
      exit(1);
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  //var tags = <String>["NodeJS", "Rust", "Haskell", "C++"];
  var tags = ["Hard Working", "Self Starter", "Team Builder"];
  var name = "Tom Cruise";
  var oneLiner = "Full Stack Developer";
  var skills = ["NodeJS", "Rust", "Haskell", "UML Diagramming", "Kotlin", "Python"];
  var exp = ["Started Google", "Developed C#", "Ran a company that made \$8 Billion.", "Graduated from MIT with a doctorate in CS"];
  var industries = ["Manufacturing", "iOS Programming", "Cybersecurity"];
  var education = ["BS in CS from Harvard", "Masters in Systems Engineering from MIT"];
  var mainFont = 'Montserrat';
  var backgroundImageURL = 'https://i.pinimg.com/originals/de/6c/93/de6c93815e68c3b00da1d76eb36e25d1.jpg';
  var profileImageURL = 'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg';
  var mainColor = Color(0xbbf7c9aa);
  var mainColorAccent = Color(0xfff7c9aa);
  var secondaryColor = Color(0xbbc58796);
  var secondaryColorAccent = Color(0xffc58796);
  var showExpShadow = false;
  var showTagShadow = true;
  ValueNotifier<bool> showExperienceCard = ValueNotifier(false);
  ValueNotifier<bool> showIndustriesCard = ValueNotifier(false);
  ValueNotifier<bool> showEducationCard = ValueNotifier(false);
  var glowColor = Colors.blue;
  var shadowGray = Colors.grey[400];
  var mainEdgeInsets = 12.0;
  var mainBGColor = ThemeData().scaffoldBackgroundColor;
  ScrollController sController = ScrollController();
  var bgOpacity = 1.0;

  Widget tagBlock(String tag, {Color backCol = Colors.white, Color borderCol = Colors.grey, Color textCol = Colors.grey}) {
    return  Container(
      padding: EdgeInsets.only(left: 8.0, top: 2.0, right: 8.0, bottom: 2.0),

      height: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        //color: backCol,
        border: Border.all(
          color: borderCol,
          width: 2,
        ),
        boxShadow: [

        ]
      ),
      child: Material(
        child: Center(
          child: Text(
            tag,
            style: TextStyle(color: textCol, fontFamily: 'Montserrat', fontSize: 15.0),
          ),
        ),
      ),
    );
  }

  Widget tagBlockContainer(String tag, List<String> array, {Color backCol = Colors.white, Color borderCol = Colors.grey, Color textCol = Colors.grey}) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          tagBlock(tag, backCol: backCol, borderCol: borderCol, textCol: textCol),
          if (tag != array[array.length - 1]) SizedBox(width: 5.0)
        ],
      )
    );
  }

  Widget experience(String e) {
    return Text(
      "• " + e,
      style: TextStyle(
        fontSize: 16.0,
        fontFamily: mainFont,
      ),
      textAlign: TextAlign.start,
    );
  }

  Widget skillsLine() {
    return Flex(
      direction: Axis.horizontal,
      children: List<Widget>.generate(skills.length, (int index) {
        return tagBlockContainer(
          skills[index],
          skills,
          backCol: index % 2 == 0 ? mainColor : secondaryColor,
          borderCol: index % 2 == 0 ? mainColorAccent : secondaryColorAccent,
          textCol: Colors.black,
        );
      })
    );
  }

  Widget coloredBoxClosed(List<String> vars, String title, Color backgroundColor, Color borderColor, ValueNotifier<bool> listenerVar) {
    return Container(
        margin: EdgeInsets.only(left: 0.0, right: 0.0, top: 6.0, bottom: 6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
            width: 3,
          ),
          boxShadow: <BoxShadow>[
            if (showExpShadow) BoxShadow(
                color: shadowGray,
                blurRadius: 24.0,
                spreadRadius: 3.0
            )
          ],

        ),
        child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(4.0),
                  child: Row(
                      children: <Widget>[
                        Text(
                            title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: mainFont,
                              fontSize: 18.0,
                              color: Colors.lightBlue,
                            )
                        ),
                        Expanded(
                            child: new Container(
                              margin: EdgeInsets.only(left: 10.0, top: 2.0, right: 10.0),
                              child: Divider(
                                color: Colors.black,
                                height: 26,
                              ),
                            )
                        ),
                        Container(
                            width: 40.0,
                            height: 26.0,
                            child: OutlineButton(
                                child: Text("+"),
                                onPressed: () {
                                  toggleCard(listenerVar);
                                },
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0))
                            )
                        )
                      ]
                  )

              ),
            ]
        )
    );
  }

  Widget coloredBoxOpen(List<String> vars, String title, Color backgroundColor, Color borderColor, ValueNotifier<bool> listenerVar) {
    return Container(
        margin: EdgeInsets.only(left: 0.0, right: 0.0, top: 6.0, bottom: 6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
            width: 3,
          ),
          boxShadow: <BoxShadow>[
            if (showExpShadow) BoxShadow(
                color: shadowGray,
                blurRadius: 24.0,
                spreadRadius: 3.0
            )
          ],

        ),
        child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(4.0),
                  child: Row(
                      children: <Widget>[
                        Text(
                            title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: mainFont,
                              fontSize: 18.0,
                              color: Colors.lightBlue,
                            )
                        ),
                        Expanded(
                            child: new Container(
                              margin: EdgeInsets.only(left: 10.0, top: 2.0, right: 10.0),
                              child: Divider(
                                color: Colors.black,
                                height: 26,
                              ),
                            )
                        ),
                        Container(
                            width: 40.0,
                            height: 26.0,
                            child: OutlineButton(
                                child: Text("-"),
                                onPressed: () {
                                  toggleCard(listenerVar);
                                },
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0))
                            )
                        )
                      ]
                  )

              ),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, ///This only puts them as far left as the longest one is when it's centered.
                  children: <Widget>[
                    for (var e in vars) experience(e),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 12.0, right: 12.0),
                child: Divider(
                  color: Colors.black,
                  height: 26,
                ),
              ),
            ]
        )
    );
  }

  Widget bottomButton(IconData mainIcon, Color backgroundColor, Function func) {
    return Material(
        elevation: 4.0,
        shape: CircleBorder(),
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        child: Ink(
            height: 50.0,
            width: 50.0,
            decoration: ShapeDecoration(
                color: backgroundColor,
                shape: CircleBorder(),
                shadows: [BoxShadow(
                  color: shadowGray,
                  blurRadius: 30.0,
                  spreadRadius: 2.0,
                )]
            ),
            child: IconButton(
              icon: Icon(mainIcon),
              color: Colors.white,
              onPressed: () { func(); },
            )
        )
    );
  }

  Widget imageButton(String imageUrl, Color backgroundColor, Function func) {
    return Material(
        elevation: 4.0,
        shape: CircleBorder(),
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        child: Ink(
            height: 50.0,
            width: 50.0,
            decoration: ShapeDecoration(
                color: backgroundColor,
                shape: CircleBorder(),
                shadows: [BoxShadow(
                  color: shadowGray,
                  blurRadius: 30.0,
                  spreadRadius: 2.0,
                )]
            ),
            child: FlatButton(
              child: Image.asset(imageUrl),
              color: Colors.white,
              onPressed: () { func(); },
            )
        )
    );
  }

  Widget deets() {
    return Center(
      child: Container(
          alignment: Alignment(0.0, -0.5),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.2,
          child: Row(
            children: <Widget> [
              Column(
                children: <Widget>[
                  imageButton('assets/linkedin_uncropped.png', Colors.transparent, navigateToLinkedIn),
                  SizedBox(height: 2),
                  Text(
                    "LinkedIn",
                    style: TextStyle(
                      fontFamily: mainFont,
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ]
              ),
              Spacer(),
              Column(
                children: <Widget>[
                  bottomButton(Icons.rate_review, Colors.brown[200], showReviews),
                  SizedBox(height: 2),
                  Text(
                    "Recommendations",
                    style: TextStyle(
                      fontFamily: mainFont,
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ]
              ),
              Spacer(),
              Column(
                children: <Widget>[
                  bottomButton(Icons.collections_bookmark, Colors.cyan, showPortfolio),
                  SizedBox(height: 2),
                  Text(
                    "Portfolio",
                    style: TextStyle(
                      fontFamily: mainFont,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ]
              ),
            ],
          )
      )
    );
  }

  void toggleCard(ValueNotifier<bool> listenerVar) {
    setState(() {
      if (listenerVar.value) {
        listenerVar.value = false;
      } else {
        listenerVar.value = true;
      }
    });
  }

  void showDeets() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return deets();
      }
    );
  }

  void navigateToLinkedIn() {} /// TODO: Make this bad boi

  void showReviews() {} /// TODO: Make this bad boi

  void showPortfolio() {} /// TODO: Make this bad boi

  void contactCard() {} /// TODO: Make this bad boi

  void passOnCard() {} /// TODO: Make this bad boi

  @override
  void initState() {
    super.initState();
    sController.addListener(onScroll);
  }

  void onScroll() {
    setState(() {});
  }

  @override
  void dispose() {
    sController.removeListener(onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
          children: <Widget>[
            ClipPath(
              child: AnimatedOpacity(
                opacity: bgOpacity,
                duration: Duration(seconds: 0),
                child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(backgroundImageURL),
                        fit: BoxFit.fill,
                        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(bgOpacity), BlendMode.dstATop),
                      ),
                    )
                ),
              ),
              clipper: getClipper(),
            ),
            new NotificationListener<ScrollUpdateNotification>(
              child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: sController,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08, left: mainEdgeInsets, right: mainEdgeInsets),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width * 0.32,
                            height: MediaQuery.of(context).size.width * 0.32,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                image: DecorationImage(
                                    image: NetworkImage(profileImageURL),
                                    fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(75.0)),
                                boxShadow: [
                                  BoxShadow(color: glowColor, blurRadius: 20.0, spreadRadius: 5.0)
                                ]
                            ),
                            child: GestureDetector(
                              onTap: () => showDeets(),
                            ),
                        ),
                        SizedBox(height: 16.0),
                        Container(
                          padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(
                              children: <Widget>[
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        name,
                                        style: TextStyle(
                                            fontSize: 30.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: mainFont),
                                      ),
                                    ]
                                ),
                                SizedBox(height: 0.0),
                                /*Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        oneLiner,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontStyle: FontStyle.italic,
                                            fontFamily: mainFont),
                                      ),
                                    ]
                                ),*/
                              ]
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          height: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Wrap( ///Maybe at a later date get rid of this wrap and make it work better.
                                direction: Axis.horizontal,
                                children: <Widget>[
                                  for (var tag in tags) Container(
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          tag
                                        ),
                                        SizedBox(width: 5),
                                        if (tag != tags.last) Container(
                                          height: 18,
                                          child: VerticalDivider(color: Colors.black),
                                        ),
                                        SizedBox(width: 5),
                                      ]
                                    )
                                  )
                                ],
                              ),
                            ],
                          ),

                        ),
                        SizedBox(height: 20),
                        AnimatedSizeAndFade(
                          vsync: this,
                          child: showExperienceCard.value ? coloredBoxOpen(exp, "Experience", Colors.transparent, Colors.transparent, showExperienceCard) : coloredBoxClosed(exp, "Experience", Colors.transparent, Colors.transparent, showExperienceCard),
                          fadeDuration: const Duration(milliseconds: 300),
                          sizeDuration: const Duration(milliseconds: 300),
                        ),
                        //coloredBox(exp, "Experience", mainColor, mainColorAccent, showExperienceCard),
                        SizedBox(height: 10.0),
                        Container(
                          alignment: Alignment(-1.0, -1.0),
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Skills",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlue,
                            ),
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          child: Wrap(
                            children: skills.map((skill) {
                              return Container(
                                padding: EdgeInsets.only(bottom: 5),
                                child: tagBlockContainer(skill, skills, backCol: Colors.transparent, borderCol: Colors.grey, textCol: Colors.grey,),
                              );
                            }).toList(),
                          )
                        ),
                        SizedBox(height: 10.0),
                        AnimatedSizeAndFade(
                          vsync: this,
                          child: showIndustriesCard.value ? coloredBoxOpen(industries, "Industries", Colors.transparent, Colors.transparent, showIndustriesCard) : coloredBoxClosed(industries, "Industries", Colors.transparent, Colors.transparent, showIndustriesCard),
                          fadeDuration: const Duration(milliseconds: 300),
                          sizeDuration: const Duration(milliseconds: 300),
                        ),
                        //coloredBox(industries, "Industries", secondaryColor, secondaryColorAccent, showIndustriesCard),
                        AnimatedSizeAndFade(
                          vsync: this,
                          child: showEducationCard.value ? coloredBoxOpen(education, "Education", Colors.transparent, Colors.transparent, showEducationCard) : coloredBoxClosed(education, "Education", Colors.transparent, Colors.transparent, showEducationCard),
                          fadeDuration: const Duration(milliseconds: 300),
                          sizeDuration: const Duration(milliseconds: 300),
                        ),
                        //coloredBox(education, "Education", mainColor, mainColorAccent, showEducationCard),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.13),
                      ],
                    ),
                  ]//),
              ),
              onNotification: (t) {
                if (t is ScrollUpdateNotification) {
                  var temp = sController.position.pixels  / 120;
                  if (temp >= 0.5) {
                    if (temp >= 1.0) {
                      bgOpacity = 0.0;
                    } else {
                      bgOpacity = temp - ((temp - 0.5) * 2);
                    }
                  } else {
                    if (temp <= 0) {
                      bgOpacity = 1.0;
                    } else {
                      bgOpacity = temp + ((0.5 - temp) * 2);
                    }
                  }
                }
              },
            ),

                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.89),
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, right: MediaQuery.of(context).size.width * 0.1),
                  child: Row(
                    children: <Widget>[
                      bottomButton(Icons.autorenew, Colors.red[300], passOnCard),
                      Spacer(),
                      bottomButton(Icons.textsms, Colors.blue[300], contactCard),
                    ],
                  )
                )

              ],
            ));
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 4);
    path.lineTo(size.width + 225, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
