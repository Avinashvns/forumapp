

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:email_validator/email_validator.dart';
import 'package:flag/flag.dart';
//import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:forumapp/login/login.dart';

import 'package:forumapp/widget/textfield.dart';
import 'package:forumapp/widget/textwidget.dart';

//import 'package:email_auth/email_auth.dart';

import 'package:pin_code_fields/pin_code_fields.dart';




class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController nameController =TextEditingController();
  TextEditingController mobileController =TextEditingController();
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  TextEditingController confirmpasswordController =TextEditingController();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  

  bool? displayFlagPicker;

  @override
  void initState(){
    super.initState();
    //firebaseinIt();
  }

  // void firebaseinIt()async{
  //   try{
  //     _firestore;

  //     Map<String, dynamic> newuserData={
  //       "name" : "Avi",
  //       "phone": "8585858585",
  //       "email": "avin@gmail.com"
  //     };
  //     // default documnets in collection
  //     await _firestore.collection("users").add(newuserData);
  //     log("new user created");

  //     //{
  //     // with name documents in collection
  //     // await _firestore.collection("user").doc("your id name").set(newuserData);
  //     // log("new user saved with documents name");

  //     // update with name documents in collection

  //     // await _firestore.collection("user").doc("your id name").update({
  //     //   "email": "Avinashg@gmail.com"
  //     // });
  //     // log("UPDATE user saved with documents name");

  //     // Delete
  //     // await _firestore.collection("user").doc("your id name").delete();
  //     // log("Delete user saved with documents name");

  //     //}

      

  //   }
  //   catch(ex){

  //   }
  // }

  void saveUser()async{
    String email=emailController.text.trim();
    String phone=mobileController.text.trim();
    String name=nameController.text.trim();

    if(email!="" || name!="" || phone!=""){
      Map<String,dynamic> newuserData={
        "name": name,
        "phone" : phone,
        "email": email,
      };
      _firestore.collection('users').add(newuserData);
      log("user created");
    }
    
    else {
      log("Please fill all the fields");
    }
  }
  

  void createAccount()async{
    String email=emailController.text.trim();
    String password=passwordController.text.trim();
    String cpassword=confirmpasswordController.text.trim();

    if(email=="" || password=="" || cpassword==""){
      log("please fill all the details");
    }
    else if(password !=cpassword){
      log("password do not match");
    }
    else {
      try{
        UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password);
        log("user create");
        // if(userCredential.user !=null){
        //   Navigator.pop(context);
        // }
      }
      on FirebaseAuthException catch(ex){
        log(ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50,),
      
            const Center(
              child: CircleAvatar(
                radius: 70,
                //backgroundColor: Colors.indigoAccent,
                backgroundImage: AssetImage("asset/images/c2.JPG"),
              ),
            ),
            
                  
              Padding(
                padding: const EdgeInsets.all(20),
                child: MyTextField(
                  maxLine: 1, 
                  controller: nameController, 
                  hintText: "Name", 
                  obscureText: false, 
                  type: false, 
                  //icon: Icons.add, 
                  isIcon: true
                  ),
                ),
      
                Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                child: Row(
                  children: [
                    Flag.fromCode(
                      FlagsCode.IN,
                      height: 20,
                      width: 30,
                    ),
      
                    SizedBox(width: 20,),
                    Expanded(
                      flex: 1,
                      child: MyTextField(
                        maxLine: 1, 
                        controller: mobileController, 
                        hintText: "Phone", 
                        obscureText: false, 
                        type: true, 
                        //icon: Icons.add, 
                        isIcon: false
                        ),
                    ),
                  ],
                ),
                ),
      
                 Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                child: 
                // TextFormField(
                //   controller: emailController,
                //   cursorColor: Colors.black,
                //   textInputAction: TextInputAction.next,
                //   decoration: InputDecoration(
                //     labelText: "Email"
                //   ),
                //   autovalidateMode: AutovalidateMode.onUserInteraction,
                //   validator: (email)=> email != null && !EmailValidator.validate(email)
                //   ? "enter a valid email" : null,
                // ),
                MyTextField(
                  maxLine: 1, 
                  controller: emailController, 
                  hintText: "Email", 
                  obscureText: false, 
                  type: false, 
                  //icon: Icons.add, 
                  isIcon: true
                  ),
                ),
               
               Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                child: MyTextField(
                  maxLine: 1, 
                  controller: passwordController, 
                  hintText: "Password", 
                  obscureText: true, 
                  type: false, 
                  //icon: Icons.add, 
                  isIcon: true
                  ),
                ),
                Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                child: MyTextField(
                  maxLine: 1, 
                  controller: confirmpasswordController, 
                  hintText: "Confirm Password", 
                  obscureText: true, 
                  type: false, 
                  //icon: Icons.add, 
                  isIcon: true
                  ),
                ),

               
                
      
                
      
                Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
                child: GestureDetector(
                  onTap: ()async{
                    saveUser();
                    createAccount();
                    //await Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                  },
                  child: Container(
                    height: 40,
                    //padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blue.shade800,
                    ),
                    child: Center(
                      child: TextWidget(
                        text: "REGISTRATION", 
                        textSize: 16, 
                        textweight: FontWeight.bold, 
                        textcolor: Colors.white, 
                        textAlign: TextAlign.start
                        ),
                    ),
                  ),
                ),
                ),
      
               
                
          ],
        ),
      ),
    );
  }
  Future signup() async{
    showDialog(context: context, 
    barrierDismissible: false,
    builder: (context)=> Center(
      child: CircularProgressIndicator(color: Colors.blue,),
    ),
    );
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(), 
        password: passwordController.text.trim(),
        );
    }
    on FirebaseAuthException catch(e){
      print(e);
    }
  }
}