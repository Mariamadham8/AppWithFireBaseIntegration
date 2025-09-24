import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/CustumAlign.dart';
import 'login.dart';

class verfy extends StatefulWidget {
  const verfy({super.key});

  @override
  State<verfy> createState() => _VerifyState();
}

class _VerifyState extends State<verfy> {
  bool _isLoading = false;
  bool _isSent = false;

  Future<void> _sendVerificationEmail() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      setState(() {
        _isSent = true;
      });
    } catch (e) {
      print("Error sending email: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send email. Try again.")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(17),
        child: Column(
          children: [
            SizedBox(height: 40.h),
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
            SizedBox(height: 15.h),
            CustomAlign(
              label: "Verify Your Account",
              color: Colors.black,
              fontsize: 25,
            ),
            CustomAlign(
              label: "Check your mail to continue using app",
              color: Colors.grey,
              fontsize: 15,
            ),
            SizedBox(height: 25.h),


            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: _isLoading ? null : _sendVerificationEmail,
                child: _isLoading
                    ? CupertinoActivityIndicator(color: Colors.white)
                    : Text("Send Email", style: TextStyle(color: Colors.white)),
              ),
            ),


            if (_isSent) ...[
              SizedBox(height: 15.h),
              Text(
                "Verification email sent",
                style: TextStyle(color: Colors.green, fontSize: 14),
              ),
              SizedBox(height: 10.h),
              TextButton(
                onPressed: _sendVerificationEmail,
                child: Text("Send Again", style: TextStyle(color: Colors.blue)),
              ),
              SizedBox(height: 15.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => login()),
                  );
                },
                child: Text("Go to Login", style: TextStyle(color: Colors.white)),
              )
            ]
          ],
        ),
      ),
    );
  }
}
