import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var pickedImageURL = "assets/defprofile.png";
  var selectedImage;
  var shadowGray = Colors.grey[400];
  var imageHasBeenPicked = false;

  Future pickImageCamera() async {
    imageHasBeenPicked = false;
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      selectedImage = image;
    });
    imageHasBeenPicked = true;
  }

  Future pickImageGallery() async {
    imageHasBeenPicked = false;
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = image;
    });
    imageHasBeenPicked = true;
  }

  void nextSlide() { }

  Widget iconButton(IconData mainIcon, Color backgroundColor, Function func) {
    return Material(
        elevation: 4.0,
        shape: CircleBorder(),
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        child: Ink(
            height: MediaQuery.of(context).size.width * 0.32,
            width: MediaQuery.of(context).size.width * 0.32,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: CircleBorder(),
                shadows: [BoxShadow(
                  color: shadowGray,
                  blurRadius: 30.0,
                  spreadRadius: 2.0,
                )]
            ),
            child: IconButton(
              icon: Icon(mainIcon),
              iconSize: 40,
              color: Colors.grey[700],
              onPressed: () { func(); },
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text(widget.title),
      ),*/
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (imageHasBeenPicked) Material(
                elevation: 3.0,
                shape: CircleBorder(),
                color: Colors.white,
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  child: Image.file(selectedImage,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width * 0.7,
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                  onTap: () { pickImageCamera(); },
                )
            ),
            if (imageHasBeenPicked) SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                iconButton(Icons.add_a_photo, Colors.transparent, pickImageCamera),
                SizedBox(width: 60),
                iconButton(Icons.collections, Colors.transparent, pickImageGallery),
              ],
            ),
            SizedBox(height: 20),
            Text(
              pickedImageURL == "assets/defprofile.png" ? 'Tap the icon to pick an image!' : "Picked an Image!",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 60),
            Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.blue,
                ),
                child: Material(
                    color: Colors.transparent,

                    child: InkWell(

                        child: Text(
                            "Next",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            )
                        )
                    )
                )
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
