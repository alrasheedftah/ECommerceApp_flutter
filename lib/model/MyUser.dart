

import 'dart:convert';

class MyUser {
  String MyUserId;
  String MyUserName;
  String MyUserImage;
  String MyUserEmail;
  // String pName;
MyUser({this.MyUserId,this.MyUserName,this.MyUserImage,this.MyUserEmail});

Map<String, dynamic> toJson(){
  return {
    "MyUserId": this.MyUserId,
    "MyUserImage": this.MyUserImage,
    "MyUserEmail": this.MyUserEmail,
    "MyUserName": this.MyUserName
  };
}

factory MyUser.fromJson(Map<String, dynamic> parsedJson){
         return MyUser(
         MyUserId: parsedJson['id'].toString(),
         MyUserEmail : parsedJson['MyUserEmail'].toString(),
         MyUserImage: parsedJson['MyUserImage'].toString() ,
         MyUserName: parsedJson['MyUserName'].toString()
         );
       }

}