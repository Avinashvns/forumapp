import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  //final String valText;
  final bool obscureText;
  final bool type;
  final bool isIcon;
 // final IconData icon;
  final int maxLine;

  const MyTextField({
    Key? key,
    required this.maxLine,
    required this.controller,
    required this.hintText,
   // required this.valText,
    required this.obscureText,
    required this.type,
    //required this.icon,
    required this.isIcon,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool oText = false;

  @override
  void initState() {
    oText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: oText,
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     return widget.valText;
      //   }
      //   return null;
      // },
      style: Theme.of(context).textTheme.headline5!.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      cursorColor: Colors.black,
      controller: widget.controller,
      maxLines: widget.maxLine,
      //maxLength: widget.type ? 10 : 100,
      keyboardType: widget.type ? TextInputType.phone : TextInputType.text,
      decoration: InputDecoration(
        
        filled: true,
        fillColor: Colors.grey.shade300,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black,),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, ),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black,),
        ),
        errorStyle: TextStyle(color: Colors.red),
        counterText: "",
        contentPadding: const EdgeInsets.only(top: 14, left: 16,bottom: 10),
        //hintText: widget.hintText,
        labelText: widget.hintText,
        labelStyle: Theme.of(context).textTheme.headline5!.copyWith(
          color: Colors.black54,
            fontSize: 18,
            fontWeight: FontWeight.w500
        ),
        // hintStyle: Theme.of(context).textTheme.headline5!.copyWith(
        //     color: Colors.black54,
        //     fontSize: 18,
        //     fontWeight: FontWeight.w500),
        prefix: widget.isIcon == true
            ? null
            : Text("+91"),
      ),
    );
  }
}

