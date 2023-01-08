import 'package:chatrooms/screen/chatpage.dart';
import 'package:chatrooms/widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController controller=TextEditingController();
  final String loggedin="isloggedin";
  final String username="username";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [ Colors.black,Color(0xff0d5250)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 100, 15),
              child: Text("Create a username",
                style:TextStyle(
                  fontSize: 20,
                  color: Colors.white,

                ),),
            ),
            buildTextField("enter username", controller , Icon(Icons.person_outline_outlined,color: Colors.black,), false),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: SizedBox(
                width: 250,

                child: Builder(
                  builder: (context) {
                    return ElevatedButton(
                        onPressed: ()async{
                          final SharedPreferences sf= await SharedPreferences.getInstance();
                          setState(() {
                            sf.setString(username, controller.text);
                            sf.setBool(loggedin, true);
                          });

                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Chatpage()));
                        },
                        style: ButtonStyle(
                          side: MaterialStateProperty.resolveWith((states) => BorderSide(color: Colors.white54)),
                          backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
                          elevation: MaterialStateProperty.resolveWith((states) => 0),
                        ),

                        child: Text(
                      "Continue",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ));
                  }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
