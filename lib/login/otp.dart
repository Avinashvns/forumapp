

import 'dart:developer';

import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forumapp/login/login.dart';
import 'package:forumapp/widget/textfield.dart';
import 'package:forumapp/widget/textwidget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  TextEditingController emailotpController =TextEditingController();
  TextEditingController otpController= TextEditingController();

  bool submitValid=false;

  String currentText = "";
  EmailAuth emailAuth=EmailAuth(sessionName: "sessionName");

  

  @override
  void initState(){
    super.initState();
    emailAuth;
  }

  void verify(){
    print(emailAuth.validateOtp(
      recipientMail: emailotpController.value.text, 
      userOtp: otpController.value.text));
  }
  void sendOtp()async{
    //bool result= await emailAuth.sendOtp(recipientMail: emailotpController.value.text, otpLength: 4);
    bool result =await emailAuth.sendOtp(recipientMail: emailotpController.value.text,otpLength: 2);
    
    if(result){
      setState(() {
        submitValid=true;
      });
    }
  }

  void signInAccount()async{
    String emailotp=emailotpController.text.trim();

    if(emailotp=="" ){
      log("please fill all the details");
    }
    
    else {
      try{
        // UserCredential userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(
        // email: email, password: password);
        // log("user loggin");
        // if(userCredential.user !=null){
        //   Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          
          
          const Center(
            child: TextWidget(
              text: "Enter Email to Recieve OTP", 
              textSize: 20, 
              textweight: FontWeight.w400, 
              textcolor: Colors.lightBlue, 
              textAlign: TextAlign.start
              ),
          ),
      
            Padding(
              padding: const EdgeInsets.all(20),
              child: MyTextField(
                maxLine: 1, 
                controller: emailotpController, 
                hintText: "Email", 
                obscureText: false, 
                type: false, 
                //icon: Icons.add, 
                isIcon: true
                ),
              ),

             

              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                child: GestureDetector(
                  onTap: ()async{
                    
                    sendOtp();
                      
                      await showDialog(context: context, builder: (context)=> AlertDialog(         
                        title: Center(child: const TextWidget(
                          text: "Enter OTP", 
                          textSize: 16, 
                          textweight: FontWeight.bold, 
                          textcolor: Colors.black, 
                          textAlign: TextAlign.start
                          ),),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Padding(
                    padding: const EdgeInsets.all(2),
                    child: SizedBox(
                      height: 50,
                      width: 140,
                      child: PinCodeTextField(
                        
                        appContext: context,
                        length: 6,
                        obscureText: false,                     
                        // validator: (v) {
                        //   // if (v!.length < 3) {
                        //   //   return "I'm from validator";
                        //   // } else {
                        //   //   return null;
                        //   // }
                        // },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(1),
                          fieldHeight: 50,
                          fieldWidth: 30,
                          activeFillColor: Colors.white,
                          activeColor: Colors.black,
                          inactiveColor: Colors.black,
                          selectedColor: Colors.black,
                        ),
                        cursorColor: Colors.black,                     
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        
                        onCompleted: (v) {
                          debugPrint("Completed");
                        },
                        // onTap: () {
                        //   print("Pressed");
                        // },
                        onChanged: (value) {
                          debugPrint(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          debugPrint("Allowing to paste $text");
                          
                          return true;
                        },
                      ),
                    )),
                              
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.lightBlue,
                                  padding: const EdgeInsets.only(left: 20,right: 20)
                                ),
                                child: const TextWidget(
                                  text: "SUBMIT OTP", 
                                  textSize: 16, 
                                  textweight: FontWeight.bold, 
                                  textcolor: Colors.black, 
                                  textAlign: TextAlign.start
                                  ),
                                onPressed: () async {
                                  verify();
                                  Navigator.popUntil(context, (route) => route.isFirst);
                                  await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    );
                    //createAccount();
                    //signup();
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
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
                        text: "SEND OTP", 
                        textSize: 16, 
                        textweight: FontWeight.bold, 
                        textcolor: Colors.white, 
                        textAlign: TextAlign.start
                        ),
                    ),
                  ),
                ),
                ),

              // Padding(
              // padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
              // child: GestureDetector(
              //   onTap: (){
              //     Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
              //   },
              //   child: Container(
              //     height: 40,
              //     //padding: const EdgeInsets.symmetric(horizontal: 20),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(5),
              //       color: Colors.blue.shade800,
              //     ),
              //     child: const Center(
              //       child: TextWidget(
              //         text: "SEND OTP", 
              //         textSize: 16, 
              //         textweight: FontWeight.bold, 
              //         textcolor: Colors.white, 
              //         textAlign: TextAlign.start
              //         ),
              //     ),
              //   ),
              // ),
              // ),

             
              
        ],
      ),
    );
  }
}