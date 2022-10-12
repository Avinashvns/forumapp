

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forumapp/homepage/homepage.dart';
import 'package:forumapp/login/otp.dart';
import 'package:forumapp/signup/signup.dart';
import 'package:forumapp/widget/textfield.dart';

import 'package:forumapp/widget/textwidget.dart';
import 'package:flag/flag.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController=TextEditingController();

  bool? displayFlagPicker;

  void signInAccount()async{
    String email=emailController.text.trim();
    String password=passwordController.text.trim();
    

    if(email=="" || password=="" ){
      log("please fill all the details");
    }
    
    else {
      try{
        UserCredential userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password);
        log("user loggin");
        if(userCredential.user !=null){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
        }
      }
      on FirebaseAuthException catch(ex){
        log(ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black,size: 50),
        backgroundColor: Colors.white,
        actions: [
          PopupMenuButton(
            
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Row(
                      children: [
                         Flag.fromCode(
                          FlagsCode.IN,
                          height: 20,
                          width: 30,
                        ),
                       //Icon(Icons.flag,color: Colors.black,),
                        SizedBox(width: 20,),
                        TextWidget(
                            text: "हिन्दी", 
                            textSize: 20, 
                            textweight: FontWeight.bold, 
                            textcolor: Colors.black87, 
                            textAlign: TextAlign.start
                            ),
                        
                      ],
                    ),
                    value: 1,
                  ),

                  PopupMenuItem(
                    child: Row(
                      children: [
                        Flag.fromCode(
                          FlagsCode.US,
                          height: 20,
                          width: 30,
                        ),
                        const SizedBox(width: 20,),
                        TextWidget(
                            text: "English", 
                            textSize: 20, 
                            textweight: FontWeight.bold, 
                            textcolor: Colors.black87, 
                            textAlign: TextAlign.start
                            ),
                        
                      ],
                    ),
                    value: 2,
                  ),
                  
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Flag.fromCode(
                          FlagsCode.PK,
                          height: 20,
                          width: 30,
                        ),
                        const SizedBox(width: 20,),
                        TextWidget(
                            text: "اردو", 
                            textSize: 20, 
                            textweight: FontWeight.bold, 
                            textcolor: Colors.black87, 
                            textAlign: TextAlign.start
                            ),
                        
                      ],
                    ),
                    value: 3,
                  ),
                ]
            )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            const SizedBox(height: 80,),
            const Center(
              child: TextWidget(
                text: "Forum", 
                textSize: 40, 
                textweight: FontWeight.w400, 
                textcolor: Colors.black, 
                textAlign: TextAlign.start
                ),
            ),
        
              Padding(
                padding: const EdgeInsets.all(20),
                child: MyTextField(
                  maxLine: 1, 
                  controller: emailController, 
                  hintText: "Email", 
                  obscureText: false, 
                  type: false, 
                  
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
                padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
                child: GestureDetector(
                  onTap: (){
                    signInAccount();
                    //signin();
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                  },
                  child: Container(
                    height: 40,
                    //padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blue,
                    ),
                    child: const Center(
                      child: TextWidget(
                        text: "LOGIN", 
                        textSize: 16, 
                        textweight: FontWeight.w500, 
                        textcolor: Colors.white, 
                        textAlign: TextAlign.start
                        ),
                    ),
                  ),
                ),
                ),
      
                Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                    }, child: const TextWidget(
                      text: "New user ?", 
                      textSize: 15, 
                      textweight: FontWeight.bold, 
                      textcolor: Colors.black, 
                      textAlign: TextAlign.start
                      ),),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpScreen()));
      
                    }, child: const TextWidget(
                      text: "Forget Password ?", 
                      textSize: 15, 
                      textweight: FontWeight.bold, 
                      textcolor: Colors.black, 
                      textAlign: TextAlign.start
                      ),),
                  ],
                ),
                ),
                
          ],
        ),
      ),
    );
  }
  Future signin() async{
    showDialog(context: context, 
    barrierDismissible: false,
    builder: (context)=> Center(
      child: CircularProgressIndicator(color: Colors.blue,),
    ),
    );
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(), 
        password: passwordController.text.trim(),
        );
    }
    on FirebaseAuthException catch(e){
      print(e);
    }
  }
}