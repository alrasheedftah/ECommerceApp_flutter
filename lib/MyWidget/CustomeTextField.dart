

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CustomeTextField extends StatelessWidget {
  final String hint ;
  final IconData iconData;
  final Function onSavedCustom;  
  CustomeTextField({@required this.onSavedCustom ,@required this.iconData , @required this.hint});
  // const CustomeTextField({
  //   Key key,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        // ignore: missing_return
        validator: (value) {
          if(value.isEmpty)
              return hint+' Is Required ';
          // return '';    
        },
        onSaved: onSavedCustom,
        cursorColor: MainColor,
        obscureText: hint == ' Password ' ? true:false,
        decoration: InputDecoration(
          hintText: ""+hint,
          prefixIcon:Icon(
            iconData,
            color: KbgButtonColor,
          ) ,
          filled: true,
          fillColor: SecondaryColor,
          enabledBorder: OutlineInputBorder(
            borderRadius:  BorderRadius.circular(20),
            borderSide: BorderSide(
              color:  Colors.white
            )
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:  BorderRadius.circular(20),
            borderSide: BorderSide(
              color:  Colors.white
            )
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.white
            )
          )
        ),
      ),
    );
  }
}