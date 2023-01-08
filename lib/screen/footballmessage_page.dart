import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget.dart';
class messagepageFootball extends StatefulWidget {
  const messagepageFootball( {Key? key}) : super(key: key);

  @override
  State<messagepageFootball> createState() => _messagepageFootballState();
}

class _messagepageFootballState extends State<messagepageFootball> {
  TextEditingController controller=TextEditingController();
  final String loggedin="isloggedin";
  final String username="username";
  String usr="";
  @override
  void initState() {
    getuserusername();
    super.initState();
  }
  getuserusername() async{
    final SharedPreferences sf=await SharedPreferences.getInstance();
    final uname=sf.getString("username");
    setState(() {
      if(uname!=null) {
        usr=uname;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [ Colors.black,Color(0xff0d5250)])),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Football",),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body:  Column(
          children: [
            Expanded(
                child:Container(
                  width: double.infinity,
                  child:StreamBuilder <List<User>>(
                    stream: readUser(),
                    builder:(context, snapshot) {
                      if(snapshot.hasData){
                        final users=snapshot.data!;
                        return ListView(
                          reverse: true,
                          children: users.map(buildUser).toList(),
                        );
                      }
                      return CircularProgressIndicator();
                    },
                  ) ,
                )
            ),
            messageTextField(controller,"Football"),
          ],
        ),
      ),
    );
  }
  Widget buildUser(User user){
    String us=usr;
    return text(user.username,user.message,us);
  }
  Stream<List<User>> readUser()=> FirebaseFirestore.instance.collection("Football").orderBy("time",descending: true
  ).snapshots().map((event) =>
      event.docs.map((doc) => User.fromjson(doc.data())).toList()
  );
}

class User{
  final String username;
  final String message;
  User({
    required this.message,
    required this.username
  });
  static User fromjson(Map<String,dynamic> json){
    return User(username:json["username"],message:json["message"]);
  }
}
