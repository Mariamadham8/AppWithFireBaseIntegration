import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/CustumAlign.dart';
import '../widgets/custumTextFeild.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController PassController=TextEditingController();
  bool PassState=true;
  TextEditingController PassController2=TextEditingController();
  bool PassState2=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back_ios_new_rounded),
      ),
      body: Padding(
          padding: EdgeInsets.all(17),
          child: Column(
              children: [
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
        label: "Rigester",
        color: Colors.black,
        fontsize: 20,
      ),
      CustomAlign(
        label: "Longin to continue using app",
        color: Colors.grey,
        fontsize: 10,
      ),
      SizedBox(height: 5.h,),
      CustomAlign(
          label: "Username",
          color: Colors.black,
          fontsize: 15,
         ),
      SizedBox(height: 5.h,),
       custumTextFeild(hint:"Enter your name" ,),
      CustomAlign(
            label: "Email",
            color: Colors.black,
            fontsize: 15,
           ),
      SizedBox(height: 5.h,),
       custumTextFeild(hint:"Enter your mail" ,),
                CustomAlign(
                  label: "Password",
                  color: Colors.black,
                  fontsize: 15,
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
                SizedBox(height: 5.h,),
                CustomAlign(
                  label: "Confirm Password",
                  color: Colors.black,
                  fontsize: 15,
                ),
                TextField(
                  controller:PassController2 ,
                  obscureText: PassState2,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      splashRadius: 15,
                      icon: Icon(
                        PassState2? Icons.visibility_off : Icons.visibility,
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
                SizedBox(height: 5.h,),
                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: (){

                    },
                    color: Colors.blueAccent,
                    padding: EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text("login",style: TextStyle(color: Colors.white),),
                  ),
                ),

      ]
    ),
  ),
 );
  }
}
