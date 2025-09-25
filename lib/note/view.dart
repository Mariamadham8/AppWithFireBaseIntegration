import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Categories/Edit.dart';
import '../Home.dart';
import '../auth/login.dart';
import './addNote.dart';
import 'edit.dart';

class veiwNotes extends StatefulWidget {
  final docID;
  final Categoryname;
  const veiwNotes({super.key,required this.docID,this.Categoryname});

  @override
  State<veiwNotes> createState() => _veiwNotesState();
}

class _veiwNotesState extends State<veiwNotes> {
  GlobalKey<ScaffoldState> KEY = GlobalKey();

  List data=[];
  bool isLoading=true;
  getdata() async{
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection("categories").doc(widget.docID).collection('note').get();
    data.addAll(querySnapshot.docs);
    isLoading=false;
    setState(() {

    });
  }

  deletedata(int i) async{
    await FirebaseFirestore.instance.collection("categories").doc(widget.docID).collection('note').doc(data[i].id).delete();
    setState(() {

    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.blueAccent,
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context) => addNote(DicID: widget.docID,categoryName: widget.Categoryname,),));
        },
        child: Icon(Icons.add,color: Colors.white,),
      ),
      key:KEY,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:   Text("${widget.Categoryname}"),
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: ()async{
            GoogleSignIn googlesignin= GoogleSignIn();
            googlesignin.disconnect();
            await FirebaseAuth.instance.signOut();
            Navigator.push(context, MaterialPageRoute(builder: (context) => login(),));
          },
            icon: Icon(Icons.exit_to_app,color: Colors.blueAccent,),
          )
        ],
      ),
      body:WillPopScope(child: isLoading?Center(child: CupertinoActivityIndicator(color: Colors.blueAccent),):GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>editNote(decId: widget.docID,oldnote: data[index]['note'],subdicID:data[index].id ,categoryname:widget.Categoryname ,),));
            },
            onLongPress: (){
              AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.rightSlide,
                  title: 'Deleting Category',
                  desc: "Are you sure?",
                  btnOkOnPress: () {
                    deletedata(index);
                    Navigator.pushNamed(context, "Home");
                  },
                  btnCancelOnPress: (){

                  }
              ).show();
            },
            child: Card(
                color: Colors.white,
                child: Column(
                    children:[
                      Text("${data[index]['note']}"),
                    ]
                )
            ),
          );
        },
      ) ,
          onWillPop: (){
              Navigator.push(context,MaterialPageRoute(builder: (context) => Home(),));
              return Future.value(false);
          }
      )

    );
  }
}
