import 'package:chatrooms/screen/Codingmessage_page.dart';
import 'package:chatrooms/screen/footballmessage_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget buildTextField(String hintText,TextEditingController controller,Widget prefixIcon,bool Ispassword){
  return Center(
    child: SizedBox(
      width: 300,
      height: 45,
      child: TextField(
        style: TextStyle(
        ),
        cursorColor: Colors.black87,
        enableSuggestions: !Ispassword,
        obscureText: Ispassword,
        controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 2),
            label: Text(hintText),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelStyle: TextStyle(fontFamily: "Montserrat"),
            filled: true,
            fillColor: Color(0xffdfecea).withOpacity(0.5),
            prefixIcon: prefixIcon,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(style: BorderStyle.none,width: 0)
            )
        ),
      ),
    ),
  );
}
Widget messageTextField(TextEditingController controller,String group){
  Future createMessage({required String message})async{
    final time=DateTime.now();
    final _db=FirebaseFirestore.instance;
    final sf= await SharedPreferences.getInstance();
    final uname=sf.getString("username");
    final json={
      "username":uname,
      "message":message,
      "time":time,
    };
    _db.collection(group).add(json);
  }
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
    width: double.infinity,
    height: 45,
    child: TextField(
      style: TextStyle(
      ),
      cursorColor: Colors.black87,
      controller: controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(13, 0, 0, 2),
          label: Padding(
            padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
            child: Text("enter your message"),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: TextStyle(fontFamily: "Varela round"),
          filled: true,
          fillColor: Color(0xffdfecea).withOpacity(0.5),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(style: BorderStyle.none,width: 0)
          ),
        suffixIcon: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: FaIcon(FontAwesomeIcons.solidPaperPlane,color: Colors.black87,),
            ),
          onTap: ()async{
            final sf= await SharedPreferences.getInstance();
            final message=controller.text;
            createMessage(message:message);
            controller.clear();
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
      ),

    ),
  );
}
Widget buildGroup(String name,Widget icon){
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
    height: 50,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(29),
      child: Builder(
        builder: (context) {
          return ElevatedButton.icon(
            onPressed: () {
              if(name=="Football"){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> messagepageFootball()));
              }
              else{
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> messagepageCoding()));
              }

            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.white54.withOpacity(0.1)),
              elevation: MaterialStateProperty.resolveWith((states) => 0),
            ),
            icon: icon,
            label: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: "Varela Round"
                ), // <-- Text
              ),
            ),

          );
        }
      ),
    ),
  );
}
Widget text(String usr,String msg, String username){
  print(msg);
  if(usr==username){
    return Container(
      margin: EdgeInsets.fromLTRB(100, 5, 5, 5),
      child: ListTile(
        tileColor: Colors.white.withOpacity(0.1),
        title:Text(usr,
          style: TextStyle(
              color:Colors.white,
              fontSize: 12,
              fontFamily: "Varela Round"
          ),textAlign: TextAlign.right,

        ),
        subtitle: Text(msg,
          style: TextStyle(
              color:Colors.white,
              fontSize: 20,
              fontFamily: "Lobster"
          ),textAlign: TextAlign.right,
        ),
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(29)),
      ),
    );
  }
  return Container(
    margin: EdgeInsets.fromLTRB(5,5, 100, 5),
    child: ListTile(
      tileColor: Colors.white.withOpacity(0.1),
      title:Text(usr,
        style: TextStyle(
            color:Colors.white,
            fontSize: 12,
            fontFamily: "Varela Round"
        ),textAlign: TextAlign.left,
      ),
      subtitle: Text(msg,
        style: TextStyle(
            color:Colors.white,
            fontSize: 20,
            fontFamily: "Lobster"
        ),textAlign: TextAlign.left,
      ),
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(29)),
    ),
  );
}