import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Home.dart';
import '../widgets/CustumAlign.dart';
import '../widgets/custumTextFeild.dart';

class add extends StatefulWidget {
  const add({super.key});

  @override
  State<add> createState() => _addState();
}

class _addState extends State<add> {
  GlobalKey<FormState> formstate=GlobalKey();
  TextEditingController name=TextEditingController();


  // Create a CollectionReference called users that references the firestore collection
  CollectionReference categories = FirebaseFirestore.instance.collection('categories');
  Future<void> addCategory() {
    // Call the user's CollectionReference to add a new user
    return categories
        .add({
      'name':name.text,
       'id':FirebaseAuth.instance.currentUser!.uid,
    }
    )
        .then((value) { AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Done',
      desc: "Category was Added",
      btnOkOnPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      },
        ).show();

       }
    )
        .catchError((error) => print("Failed to add Category: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Add Category"),
      ),
      body:Form(
        key: formstate,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(17),
              ),
              CustomAlign(
                label: "Add Category",
                color: Colors.black,
                fontsize: 20,
              ),
              custumTextFeild(hint:"Enter name",controller: name ,validator: (val) {
                if(val=="")
                {
                  SnackBar(content: Text("cant be empty"));
                  return"cant be empty";

                }
              },),
              SizedBox(height: 5.h,),

              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {
                    if(formstate.currentState!.validate()){
                      addCategory();
                    }

                  },
                  color: Colors.blueAccent,
                  padding: EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text("ADD",style: TextStyle(color: Colors.white),),
                ),
              ),

            ],
          ),
        ),
      )
    );
  }
}
