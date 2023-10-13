import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: imagepick(),
    );
  }
}

class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  void moveTNextPage(){
    Future.delayed(Duration(seconds: 5),()async{
      final SharedPreferences Prefs = await SharedPreferences.getInstance();
      final bool? counter = Prefs.getBool("isLoggedin");
      if (counter == true){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> loginpage()));
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> logoutpage()));
      }
    }
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moveTNextPage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("FaceBook",style: TextStyle(color: Colors.lightBlue
      ,fontSize: 40,fontWeight: FontWeight.w700,fontStyle: FontStyle.italic),),),
    );
  }
}



class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("welcome"),
      backgroundColor: Colors.lightGreen,),
      body: Center(child: TextButton(onPressed: ()async{
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('myvalue', true);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (contex)=> logoutpage()));
      },child: Text("Login"),),),
    );
  }
}

class logoutpage extends StatefulWidget {
  const logoutpage({Key? key}) : super(key: key);

  @override
  State<logoutpage> createState() => _logoutpageState();
}

class _logoutpageState extends State<logoutpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true,title: Text("Thankyou"),
          backgroundColor: Colors.lightGreen,),
        body: Center(child: TextButton(onPressed: ()async{
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.remove('myvalue');
          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>loginpage()));
        },child: Text("Logout"),),)
    );
  }
}
//see whatsap
//epidi mam close pandrathu



class imagepick extends StatefulWidget {
  const imagepick({Key? key}) : super(key: key);

  @override
  State<imagepick> createState() => _imagepickState();
}

class _imagepickState extends State<imagepick> {
  File? PickedImage;
  Future Pickediamgefromgallery()async{
    try{ final image1= await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image1==null)return;
    final imageTemp = File(image1.path);
    setState(() {
      this.PickedImage = imageTemp;
    });
    }
    on PlatformException catch(e){print(e);}
    }
  Future Pickedimagefromcamera()async{
    try{
      final image2 = await ImagePicker().pickImage(source:ImageSource.camera );
      if (image2==null)return;
      final imageTemp = File(image2.path);
      setState(() {
        this.PickedImage = imageTemp;
      });
    }on PlatformException catch(e){ print(e); }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(centerTitle: true,title: Text("Image Picker"),),
      body: SingleChildScrollView(child: Center(child: Column
        (children: [IconButton(onPressed: (){Pickediamgefromgallery();}, icon: Icon(Icons.image)),
      IconButton(onPressed: (){Pickedimagefromcamera();}, icon: Icon(Icons.camera)),
      Container(child: PickedImage!=null?Image.file(PickedImage!): Text("No Image"),)],),),),
    );
  }
}
