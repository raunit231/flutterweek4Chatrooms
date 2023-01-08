import 'package:chatrooms/screen/chatpage.dart';
import 'package:chatrooms/screen/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 bool isloggedin=false;

 @override
  void initState() {
    getuserloginstatus();
    super.initState();
  }
  getuserloginstatus() async{
   final SharedPreferences sf=await SharedPreferences.getInstance();
   var islog=sf.getBool("isloggedin");
   setState(() {
     if(islog!=null) {
       isloggedin = islog;
     }
   });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: isloggedin? Chatpage():Homepage(),
      ),
    );
  }
}
class login{
  final String loggedin="isloggedin";
  final String username="username";

  Future setinstance(String usrname,bool islogin) async {
    final SharedPreferences sf= await SharedPreferences.getInstance();
    sf.setBool(loggedin, islogin);
    sf.setString(username, usrname);
  }
  Future<bool?> getlogin()async{
    var sf=await SharedPreferences.getInstance();
    return sf.getBool(loggedin);
  }
}