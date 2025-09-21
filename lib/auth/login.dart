import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive/auth/signup.dart';

import '../Home.dart';
import '../widgets/CustumAlign.dart';
import '../widgets/custumContainer.dart';
import '../Home.dart';


class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool PassState=true;
  TextEditingController PassController=TextEditingController();
  TextEditingController MailController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(17),
        child: Column(
         // mainAxisAlignment:MainAxisAlignment.spaceAround,
          children: [
            Padding(padding: EdgeInsets.all(30)),
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFFEEEEEE),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/jinx.jpg"),
                ),
              ),
            ),
            CustomAlign(
              label: "Login",
              color: Colors.black,
              fontsize: 25,
            ),
            CustomAlign(
              label: "Longin to continue using app",
              color: Colors.grey,
              fontsize: 15,
            ),
            SizedBox(height: 5.h,),
            CustomAlign(
              label: "Email",
              color: Colors.black,
              fontsize: 20,
            ),
            SizedBox(height: 5.h,),
            TextField(
              controller: MailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFEEEEEE),
                hintText: "Enter Your Mail",
               border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 10.h,),
            CustomAlign(
              label: "Password",
              color: Colors.black,
              fontsize: 20,
            ),
            SizedBox(height: 5.h,),
            TextField(
              controller:PassController ,
              obscureText: PassState,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                splashRadius: 20,
                icon: Icon(
                  PassState? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    PassState = !PassState;
                  });
                },
              ),
                filled: true,
                fillColor: Color(0xFFEEEEEE),
                hintText: "Enter Your password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text("Forget Password?",style: TextStyle(color: Colors.grey),),
            ),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                onPressed: () async{
                  try {
                    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: MailController.text,
                        password: PassController.text
                    );
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                    }
                  }

                },
                color: Colors.blueAccent,
                padding: EdgeInsets.all(5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text("login",style: TextStyle(color: Colors.white),),
              ),
            ),
            SizedBox(height: 10.h,),
            Row(
              children: [
                Container(
                  width: 115.w,
                  height: 1.h,
                  color: Color(0xFFBDBDBD),
                ),
                Text("Or Login with",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                Container(
                  width: 110.w,
                  height: 1.h,
                  color: Color(0xFFBDBDBD),
                ),
              ],
            ),
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                custuMcontainer(icon: Icon(FontAwesomeIcons.facebook, color: Colors.blue, size: 30),),
                custuMcontainer(icon: Icon(FontAwesomeIcons.google, color: Colors.red, size: 30),),
                custuMcontainer(icon:Icon(FontAwesomeIcons.apple, color: Colors.black, size: 30), )
              ],
            ),
            SizedBox(height: 40.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                InkWell(
                    onTap:(){
                      Navigator.push(context,MaterialPageRoute(builder: (context) => signup(),));
                    },
                    child: Text("Register",style: TextStyle(color: Colors.blueAccent),),
                )

              ],
            ),

          ],
        ),
      ),
    );
  }
}


