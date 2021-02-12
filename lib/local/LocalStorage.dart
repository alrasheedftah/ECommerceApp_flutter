import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage{

storeUserList(_key,_userStory) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(_key))
    await prefs.setString(_key,jsonEncode( _userStory));
}

updateStoryStatus(_key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userEncoded =prefs.getString(_key);
}

}