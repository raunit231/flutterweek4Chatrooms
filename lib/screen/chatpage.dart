import 'package:chatrooms/screen/homepage.dart';
import 'package:chatrooms/widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chatpage extends StatefulWidget {
  const Chatpage({Key? key}) : super(key: key);

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  final String loggedin="isloggedin";
  final String username="username";

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [ Colors.black,Color(0xff0d5250)])),
        child: Column(

          children: [
            SizedBox(height: 50,),
        SizedBox(
          width: double.infinity,

          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Chat Room",
                  style: TextStyle(
                    color:Colors.white,
                    fontSize: 28,
                    fontFamily: "Lobster"
                ),textAlign: TextAlign.left,
                ),
              ),
              Positioned(
                right: 20,
                child: GestureDetector(
                    onTap: ()async{
                      final sf=await SharedPreferences.getInstance();
                      sf.setBool(loggedin, false);
                      sf.setString(username, "");
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Homepage()));
                    },
                    child: FaIcon(FontAwesomeIcons.rightFromBracket,color: Colors.white,)
                ),
              ),
            ],
          ),
        ),
            Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                      color: Colors.white54.withOpacity(0.1),
                  ),
                  child: ListView(
                    children: [
                      buildGroup("Football",FaIcon(FontAwesomeIcons.futbol,size: 30)),
                      buildGroup("Coding",FaIcon(FontAwesomeIcons.code,size: 30,)),
                    ],
                  ),
            )
            )
          ],
        ),
      )
    );
  }

}
