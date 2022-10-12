
import 'package:flutter/material.dart';
import 'package:forumapp/homepage/homepage.dart';
import 'package:forumapp/login/login.dart';
import 'package:splashscreen/splashscreen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';



void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Forum App",
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 14,
      navigateAfterSeconds: (FirebaseAuth.instance.currentUser !=null) ?
      HomePage() : LoginPage(),
      // navigateAfterSeconds: StreamBuilder<User?>(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     if(snapshot.hasData){
      //       return HomePage();
      //     } else{
      //       return LoginPage();
      //     }
      //   }
      // ),
      // //LoginPage(),

      
      image: new Image.asset('asset/images/c1.JPG'),
      backgroundColor: Colors.black,
      
      photoSize: 100.0,
      useLoader: false,
     
    );
  }
}