import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive/note/view.dart';

import '../Home.dart';
import '../widgets/CustumAlign.dart';
import '../widgets/custumTextFeild.dart';

class editNote extends StatefulWidget {
  final oldnote;
  final decId;
  final subdicID;
  final categoryname;
  const editNote({super.key,required this.decId,required this.oldnote,required this.subdicID,this.categoryname});

  @override
  State<editNote> createState() => _editNoteState();
}

class _editNoteState extends State<editNote> {
  GlobalKey<FormState> formstate=GlobalKey();
  TextEditingController name=TextEditingController();




  Future<void> editCategory() async{
    CollectionReference categories = FirebaseFirestore.instance.collection('categories').doc(widget.decId).collection('note');
    // Call the user's CollectionReference to add a new user
    await categories.doc(widget.subdicID).update(
        {
          "note" :name.text,
        }
    )
        .then((value) { AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Done',
      desc: "Note was Updated",
      btnOkOnPress: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => veiwNotes(docID:widget.decId,Categoryname: widget.categoryname,)),
        );
      },
    ).show();
    }
    )
        .catchError((error) => print("Failed to add Category: $error"));
  }

  @override
  void initState() {
    name.text = widget.oldnote;
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
                custumTextFeild(hint:"${widget.oldnote}",controller: name ,validator: (val) {
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
