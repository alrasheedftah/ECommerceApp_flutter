import 'package:ECommerceTask/model/MyUser.dart';
import 'package:ECommerceTask/services/Store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth 
{
final _auth= FirebaseAuth.instance;
Store _store=Store();
 Future<UserCredential> signUp(String email,String password,String name) async
  {
    
    try{
    final authResult= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    _store.addUserData(MyUser(
      MyUserId: authResult.user.uid,
      MyUserName: name,
      MyUserEmail: email,

    ));
      return authResult;
    }catch (ex){

    }
  }

  Future<UserCredential> signIn(String email,String password) async
  {
    final authResult= await _auth.signInWithEmailAndPassword(email: email, password: password);
    _store.addUserData(MyUser(
      MyUserId: authResult.user.uid,
      MyUserEmail: email,
    ));

    return authResult;
  }

  Future<User> getCurrentUser() async{
      User UserData=await FirebaseAuth.instance.currentUser;
      print(UserData.toString()+"UserData");
      return UserData;
  }

  logout() async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        print("outIsAdmin"+prefs.getBool('isAdmin').toString());
    await prefs.clear();
  return await _auth.signOut();

  }

}