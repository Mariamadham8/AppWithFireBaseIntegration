import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive/note/view.dart';

import '../Home.dart';
import '../widgets/CustumAlign.dart';
import '../widgets/custumTextFeild.dart';

class addNote extends StatefulWidget {
  final categoryName;
  final String? DicID;
  const addNote({super.key,this.DicID,this.categoryName});

  @override
  State<addNote> createState() => _addNoteState();
}

class _addNoteState extends State<addNote> {
  GlobalKey<FormState> formstate=GlobalKey();
  TextEditingController name=TextEditingController();


  // Create a CollectionReference called users that references the firestore collection

  Future<void> addNote() {
    CollectionReference Note = FirebaseFirestore.instance.collection('categories').doc(widget.DicID).collection('note');
    // Call the user's CollectionReference to add a new user
    return Note
        .add({
      'note':name.text,
    }
    )
        .then((value) { AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Done',
      desc: "Note was Added",
      btnOkOnPress: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => veiwNotes(docID: widget.DicID,Categoryname: widget.categoryName,)),
        );

      },
    ).show();

    }
    )
        .catchError((error) => print("Failed to add Note: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text("Add Note"),
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
                  label: "Add Note",
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
                        addNote();
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
