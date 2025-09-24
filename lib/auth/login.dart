import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive/auth/signup.dart';

import '../Home.dart';
import '../widgets/CustumAlign.dart';
import '../widgets/custumContainer.dart';
import '../Home.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../widgets/custumTextFeild.dart';
import 'package:google_sign_in/google_sign_in.dart';




class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool PassState=true;
  TextEditingController PassController=TextEditingController();
  TextEditingController MailController=TextEditingController();
  GlobalKey<FormState> formstate2= GlobalKey();


  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

     if(googleUser ==null){
       return;
     }
    final GoogleSignInAuthentication? googleAuth = await googleUser
        ?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
     await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(17),
        child: Form(
          key: formstate2,
          child: Column(
           // mainAxisAlignment:MainAxisAlignment.spaceAround,
            children: [
              Padding(padding: EdgeInsets.all(15)),
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
              custumTextFeild(hint:"Enter your mail" ,controller: MailController,validator: (val) {
                if(val=="")
                {
                  return"cant be empty";
                }
              },),
              SizedBox(height: 10.h,),
              CustomAlign(
                label: "Password",
                color: Colors.black,
                fontsize: 20,
              ),
              SizedBox(height: 5.h,),
              TextFormField(
                validator: (val) {
                  if(val=="")
                  {
                    return"cant be empty";
                  }
                },
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

              InkWell(
              onTap:() async{
                if(MailController.text ==""){
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'ERROR',
                    desc: "Please fill the  Email",
                  ).show();
                  return ;

                }
                try{

                  await FirebaseAuth.instance.sendPasswordResetEmail(email:MailController.text);
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.rightSlide,
                    title: 'ERROR',
                    desc: "Rest Password has been sent to your Email",
                  ).show();
                }
                catch(e){

                  print("Error: $e");
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'ERROR',
                    desc: "Enter avalid Email ",
                  ).show();
                }
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Text("Forget Password?",style: TextStyle(color: Colors.grey),),
              ),
              ),

              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () async {
                   if(formstate2.currentState!.validate())
                     {
                       try {
                         final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                           email: MailController.text.trim(),
                           password: PassController.text.trim(),
                         );
                         FirebaseAuth.instance.currentUser!.emailVerified?
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => Home()),
                         ): AwesomeDialog(
                           context: context,
                           dialogType: DialogType.error,
                           animType: AnimType.rightSlide,
                           title: 'ERROR',
                           desc: "Email must be verified or genually sign up :)",
                         ).show();
                       } on FirebaseAuthException catch (e) {
                         String errorMessage;
                         if (e.code == 'user-not-found') {
                           errorMessage = 'No user found for that email.';
                         } else if (e.code == 'wrong-password') {
                           errorMessage = 'Wrong password provided for that user.';
                         } else if (e.code == 'invalid-email') {
                           errorMessage = 'The email address is not valid.';
                         } else {
                           errorMessage = e.message ?? 'An unexpected error occurred';
                         }

                         AwesomeDialog(
                           context: context,
                           dialogType: DialogType.error,
                           animType: AnimType.rightSlide,
                           title: 'ERROR',
                           desc: errorMessage,
                         ).show();
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
                  InkWell(
                    onTap: (){
                      signInWithGoogle();
                    },
                    child:  custuMcontainer(icon: Icon(FontAwesomeIcons.google, color: Colors.red, size: 30),),
                  ),

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
      ),
    );
  }
}


