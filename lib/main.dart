import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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
  //var bio = "I'm from Orem Utah, and I love coding. I'm looking to start a small company focused on streamlining Rest API creation. If you're interested or think you could be a help, let me know!";
  var exp = ["Started Google", "Developed C#", "Ran a company that made \$8 Billion.", "Graduated from MIT with a doctorate in CS"];
  var mainFont = 'Montserrat';
  var mainColor = Colors.cyan[200];
  var mainColorAccent = Colors.cyanAccent[700];
  var secondaryColor = Colors.deepPurple[300];
  var secondaryColorAccent = Colors.deepPurpleAccent[700];
  var showShadow = true;

  Widget tagBlock(String tag, {Color backCol = Colors.white, Color borderCol = Colors.grey, Color textCol = Colors.grey}) {
    return  Container(
      padding: EdgeInsets.only(left: 8.0, top: 2.0, right: 8.0, bottom: 2.0),
      //width: tag.length.toDouble() * 10,
      //width: 40,

      height: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: backCol,
        border: Border.all(
          color: borderCol,
          width: 2,
        )
      ),
      child: Material(
        color: backCol,
        borderRadius: BorderRadius.circular(20.0),
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
  /*Widget tagBlockRow() {
    List<Widget> row = new List<Widget>();
    for (var i = 0; i < tags.length; ++i) {
      row.add(new tagBlock(tags[i]))
    }
    return new Row(children: row)
  }*/

  Widget experience(String e) {
    return Text(
      "> " + e,
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
      //runSpacing: 6.0,
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
          //alignment: Alignment.topCenter,
          children: <Widget>[
            ClipPath(
              child: Container(/*color: Colors.black.withOpacity(0.8)*/
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://media.istockphoto.com/photos/blue-binary-code-picture-id661931620?k=6&m=661931620&s=612x612&w=0&h=jMa-Ba32AFAYJ-99wAQLYk_Po67EmQQZ7h-XoRyWNvY='),
                    fit: BoxFit.fill,
                  )
                )
              ),
              clipper: getClipper(),
            ),
            Positioned(
                width: MediaQuery.of(context).size.width, //Maybe this is incorrect, that's why it looked funky?
                top: MediaQuery.of(context).size.height / 8,
                child: Column(
                  children: <Widget>[
                    Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.all(Radius.circular(75.0)),
                            boxShadow: [
                              BoxShadow(blurRadius: 7.0, color: Colors.black)
                            ])),
                    SizedBox(height: 30.0),
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: mainFont),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      oneLiner,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic,
                          fontFamily: mainFont),
                    ),
                    SizedBox(height: 10.0),
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
                        ]),
                      /*child: Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.end,
                        children: <Widget> [
                          /*Expanded(
                            flex: 1,
                            child: Flex(
                               direction: Axis.horizontal,
                               children: <Widget> [*/
                                 for (var tag in tags) tagBlockContainer(tag, tags),
                               /*]
                            )
                          )*/
                        ]
                      )*/

                      ),

                    /*SizedBox(height: 5.0),*/
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: mainColor,
                        border: Border.all(
                            color: mainColorAccent,
                            width: 3,
                        ),
                        /*if (showShadow) return boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 20.0,
                            spreadRadius: 3.0,
                            offset: Offset(
                              0.0,
                              4.0,
                            ),
                          )
                        ]*/
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(left: 12.0, right: 12.0, top: 4.0),
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
                                          margin: EdgeInsets.only(left: 10.0, top: 2.0),
                                          child: Divider(
                                            color: Colors.black,
                                            height: 26,
                                          ),
                                        )
                                    ),
                                  ]
                              )

                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start, //This only puts them as far left as the longest one is when it's centered.
                              children: <Widget>[
                                for (var e in exp) experience(e),
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
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                        height: 30.0,
                        width: 95.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.greenAccent,
                          color: Colors.green,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () {},
                            child: Center(
                              child: Text(
                                'Edit Name',
                                style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),
                        SizedBox(width: 15.0),
                        Container(
                          height: 30.0,
                          width: 95.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.redAccent,
                            color: Colors.red,
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () {},
                              child: Center(
                                child: Text(
                                  'Log out',
                                  style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
                                ),
                              ),
                            ),
                          )),
                      ],
                    ),*/
                    ]),
            )],
                ));
          //],
        //));
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 3.0/*1.9*/);
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
