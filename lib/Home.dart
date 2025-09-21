import 'package:firebase_auth/firebase_auth.dart';
import'package:flutter/material.dart';

import 'auth/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> KEY = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
            await FirebaseAuth.instance.signOut();
            Navigator.push(context, MaterialPageRoute(builder: (context) => login(),));
          },
              icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body:Center(

      ) ,

    );
  }
}
