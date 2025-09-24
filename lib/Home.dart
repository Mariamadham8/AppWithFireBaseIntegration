import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Categories/Edit.dart';
import 'auth/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> KEY = GlobalKey();

  List data=[];
  bool isLoading=true;
  getdata() async{
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection("categories").where("id",isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
    data.addAll(querySnapshot.docs);
    isLoading=false;
    setState(() {

    });
  }

  deletedata(int i) async{
     await FirebaseFirestore.instance.collection("categories").doc(data[i].id).delete();
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
          Navigator.pushNamed(context, "category");
        },
        child: Icon(Icons.add,color: Colors.white,),
      ),
      key:KEY,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Text("hello"),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: (){
              KEY.currentState!.openDrawer();
            },
            child: CircleAvatar(
              radius: 30,
            ),
          ),
        ),
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
      body:isLoading?Center(child: CupertinoActivityIndicator(color: Colors.blueAccent),):GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => edit(decId:data[index].id,oldname:data[index]['name'] ,),));
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
                  Image(image: AssetImage("assets/data-exchange_7859254.png"),height: 120,),
                  Text("${data[index]['name']}"),
                ]
              )
            ),
          );
        },
      ) ,

    );
  }
}
