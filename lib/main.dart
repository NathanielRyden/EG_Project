import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/change_notifier.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode)
      exit(1);
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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

class _ProfilePageState extends State<ProfilePage> {
  var tags = <String>["NodeJS", "Rust", "Haskell", "C++"];
  var name = "Tom Cruise";
  var oneLiner = "Full Stack Developer";
  var skills = ["NodeJS", "Rust", "Haskell", "UML Diagramming", "Kotlin", "Python"];
  var exp = ["Started Google", "Developed C#", "Ran a company that made \$8 Billion.", "Graduated from MIT with a doctorate in CS"];
  var mainFont = 'Montserrat';
  var mainColor = Color(0xbbf7c9aa);
  var mainColorAccent = Color(0xfff7c9aa);
  var secondaryColor = Color(0xbbc58796);
  var secondaryColorAccent = Color(0xffc58796);
  var showExpShadow = true;
  var showTagShadow = true;
  ValueNotifier<bool> showExperienceCard = ValueNotifier(false);
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

  void toggleExpCard() {
    setState(() {
      if (showExperienceCard.value) {
        showExperienceCard.value = false;
      } else {
        showExperienceCard.value = true;
      }
    });
  }

  void contactCard() {}

  void passOnCard() {}

  @override
  void initState() {
    super.initState();
    sController.addListener(onScroll);
  }

  void onScroll() {
    setState(() {
      //bgOpacity = sController.position.pixels / 110.0;
    });
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
          //alignment: Alignment.topCenter,
          children: <Widget>[
            /*ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(
                  child: ClipPath(
                    child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://media.istockphoto.com/photos/blue-binary-code-picture-id661931620?k=6&m=661931620&s=612x612&w=0&h=jMa-Ba32AFAYJ-99wAQLYk_Po67EmQQZ7h-XoRyWNvY='),
                            fit: BoxFit.fill,
                          ),
                        )
                    ),
                    clipper: getClipper(),
                  ),
                ),
              ],
            ),*/
            ClipPath(
              child: Container(/*color: Colors.black.withOpacity(0.8)*/
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://media.istockphoto.com/photos/blue-binary-code-picture-id661931620?k=6&m=661931620&s=612x612&w=0&h=jMa-Ba32AFAYJ-99wAQLYk_Po67EmQQZ7h-XoRyWNvY='),
                    fit: BoxFit.fill,
                    colorFilter: new ColorFilter.mode(Colors.black.withOpacity(bgOpacity), BlendMode.dstATop),
                  ),
                )
              ),
              clipper: getClipper(),
            ),
            //Positioned(
            new NotificationListener<ScrollUpdateNotification>(
              child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: sController,
                  scrollDirection: Axis.vertical,
                  //width: MediaQuery.of(context).size.width, //Maybe this is incorrect, that's why it looked funky?
                  //top: MediaQuery.of(context).size.height / 8,
                  //child: Column(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.11, left: mainEdgeInsets, right: mainEdgeInsets),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                            width: 150.0,
                            height: 150.0,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'
                                    ),
                                    fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(75.0)),
                                boxShadow: [
                                  BoxShadow(color: glowColor, blurRadius: 20.0, spreadRadius: 5.0)
                                ]
                            )
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            color: mainBGColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
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
                                Row(
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
                                ),
                              ]
                          ),
                        ),


                        /*Text(
                      oneLiner,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic,
                          fontFamily: mainFont),
                    ),*/
                        SizedBox(height: 5.0),
                        Container(
                          height: (tags.length.toDouble() / 3.0) * 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Wrap(
                                direction: Axis.horizontal,
                                children: <Widget>[
                                  for (var tag in tags) tagBlockContainer(tag, tags),
                                ],
                              ),
                            ],
                          ),

                        ),

                        /*SizedBox(height: 5.0),*/
                        Container(
                            margin: EdgeInsets.only(left: 0.0, right: 0.0, top: 6.0, bottom: 6.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: mainColor,
                              border: Border.all(
                                color: mainColorAccent,
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
                                                "Experience",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: mainFont,
                                                  fontSize: 20.0,
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
                                                    child: showExperienceCard.value ? Text("-") : Text("+"),
                                                    onPressed: () {
                                                      toggleExpCard();
                                                    },
                                                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0))
                                                )
                                            )
                                          ]
                                      )

                                  ),
                                  if (showExperienceCard.value) Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start, //This only puts them as far left as the longest one is when it's centered.
                                      children: <Widget>[
                                        for (var e in exp) experience(e),
                                      ],
                                    ),
                                  ),
                                  if (showExperienceCard.value) Container(
                                    margin: EdgeInsets.only(left: 12.0, right: 12.0),
                                    child: Divider(
                                      color: Colors.black,
                                      height: 26,
                                    ),
                                  ),
                                ]
                            )
                        ),
                        SizedBox(height: 10.0),
                        Container(
                            padding: EdgeInsets.only(left: 0.0, right: 0.0),
                            //width: skills.length * 100.0,
                            height: 25.0,
                            child: ListView(
                              //mainAxisAlignment: MainAxisAlignment.start,
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  Text(
                                    "Skills",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 5.0),
                                  skillsLine(),
                                  /*Wrap(
                            runSpacing: 6.0,
                            children: <Widget>[
                              for (var i in skills) tagBlockContainer(i, skills, backCol: secondaryColor, borderCol: secondaryColorAccent, textCol: secondaryColorAccent),
                            ]
                          )*/
                                ]
                            )
                        )
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
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.86),
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, right: MediaQuery.of(context).size.width * 0.1),
                  child: Row(
                    children: <Widget>[
                      Center(
                        child: Ink(
                          decoration: ShapeDecoration(
                            color: Colors.red[300],
                            shape: CircleBorder(),
                            shadows: [BoxShadow(
                              color: shadowGray,
                              blurRadius: 30.0,
                              spreadRadius: 2.0,
                            )]
                          ),
                          child: IconButton(
                            icon: Icon(Icons.autorenew),
                            color: Colors.white,
                            onPressed: () { passOnCard(); },
                          )
                        )
                      ),
                      Spacer(),
                      Center(
                        child: Ink(
                          decoration: ShapeDecoration(
                            color: Colors.blue[300],
                            shape: CircleBorder(),
                            shadows: [BoxShadow(
                              color: shadowGray,
                              blurRadius: 30.0,
                              spreadRadius: 2.0,
                            )]
                          ),
                          child: IconButton(
                            icon: Icon(Icons.textsms),
                            color: Colors.white,
                            onPressed: () { contactCard(); }
                          )
                        )
                      )
                    ],
                  )
                )

              ],
            ));
          //],
        //));
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 3.6);
    path.lineTo(size.width + 225, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
