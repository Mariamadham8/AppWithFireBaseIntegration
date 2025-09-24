import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Home.dart';
import '../widgets/CustumAlign.dart';
import '../widgets/custumTextFeild.dart';
import 'MailVerfication.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController MailController=TextEditingController();
  TextEditingController PassController=TextEditingController();
  bool PassState=true;
  TextEditingController PassController2=TextEditingController();
  bool PassState2=true;
  GlobalKey<FormState> formstate=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back_ios_new_rounded),
      ),
      body: Form(
        key: formstate,
        child:SingleChildScrollView(
        child: Padding (
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
         custumTextFeild(hint:"Enter your name" ,validator: (val) {
           if(val=="")
             {
               SnackBar(content: Text("cant be empty"));
               return"cant be empty";

             }
         },),
        CustomAlign(
              label: "Email",
              color: Colors.black,
              fontsize: 15,
             ),
        SizedBox(height: 5.h,),
         custumTextFeild(hint:"Enter your mail" ,controller: MailController,validator: (val) {
           if(val=="")
           {
             SnackBar(content: Text("cant be empty"));
             return"cant be empty";

           }
         },),
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
                      onPressed: () async{
                       if(formstate.currentState!.validate()){
                         try {
                           final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                             email: MailController.text,
                             password: PassController.text,
                           );
                           Navigator.push(context, MaterialPageRoute(builder: (context) => verfy(),));
                         } on FirebaseAuthException catch (e) {
                           String errorMessage='An unexpected error occurred. Please try again.';
                           if (e.code == 'weak-password') {
                             print('The password provided is too weak.');
                             errorMessage = 'The password provided is too weak.';
                           } else if (e.code == 'email-already-in-use') {
                             print('The account already exists for that email.');
                             errorMessage = 'The account already exists for that email.';
                           }
                           AwesomeDialog(
                             context: context,
                             dialogType: DialogType.error,
                             animType: AnimType.rightSlide,
                             title: 'ERROR',
                             desc: errorMessage,
                           ).show();

                         } catch (e) {
                           print(e);
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
        
        ]
            ),
          ),
      ),
      ),
 );
  }
}
