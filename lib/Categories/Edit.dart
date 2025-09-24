import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Home.dart';
import '../widgets/CustumAlign.dart';
import '../widgets/custumTextFeild.dart';

class edit extends StatefulWidget {
  final oldname;
  final decId;
  const edit({super.key,required this.decId,required this.oldname});

  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  GlobalKey<FormState> formstate=GlobalKey();
  TextEditingController name=TextEditingController();



  CollectionReference categories = FirebaseFirestore.instance.collection('categories');
  Future<void> editCategory() async{
    // Call the user's CollectionReference to add a new user
    await categories.doc(widget.decId).update(
     {
       "name" :name.text,
     }
    )
        .then((value) { AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Done',
      desc: "Category was Updated",
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
  void initState() {
    name.text = widget.oldname;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Edit Category"),
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
                  label: "Edit Category",
                  color: Colors.black,
                  fontsize: 20,
                ),
                custumTextFeild(hint:"${widget.oldname}",controller: name ,validator: (val) {
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
                        editCategory();
                        setState(() {

                        });
                      }

                    },
                    color: Colors.blueAccent,
                    padding: EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text("Edit",style: TextStyle(color: Colors.white),),
                  ),
                ),

              ],
            ),
          ),
        )
    );
  }
}
