

import 'package:ECommerceTask/MyWidget/CustomeTextField.dart';
import 'package:ECommerceTask/provider/ModelHud.dart';
import 'package:ECommerceTask/screen/user/ShopPage.dart';
import 'package:ECommerceTask/services/Auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Home.dart';
import '../constants.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'SinginScreen.dart';

class SignupScreen extends StatefulWidget{
  static final String id="SignupScreen";
  @override
  State<StatefulWidget> createState() => _SignupScreen();

}

class _SignupScreen extends State<SignupScreen>{
  final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();
  bool KeepMeLoggin=false;
     String _email,_password,_name;
     bool isAdmin=false;
     final roleAdmin="admin@123";
     final _auth=Auth();

  @override
  Widget build(BuildContext context) {
  final hieght = MediaQuery.of(context).size.height;
    // TODO: implement build
          return Scaffold(
      backgroundColor: MainColor,
      // body: ModalProgressHUD(
      // inAsyncCall: Provider.of<ModelHud>(context).isLoading,
              body: ModalProgressHUD(
      inAsyncCall: Provider.of<ModelHud>(context).isLoading,
                child: Form(
           key: _globalKey, 
           child: ListView(
            children: <Widget>[
                Padding(
                 padding: EdgeInsets.only(top:  40), 
            child: Container(
                  padding: EdgeInsets.only(top: 30),
                  height: MediaQuery.of(context).size.height * .2,
                   child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage('images/icons/logo.png'),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontFamily: 'Pacifico',
                              fontSize: 24
                            ),
                          ),
                        ),
                        
                      ],
                      
                    ),
                      
                  ),
                
                ),          
                SizedBox(
                    height: hieght * .03,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
                    child: Row(
                    children: <Widget>[
                      Text("Already SingUp? ",
                      style: TextStyle(
                        color: Color(0xFF1C2126),
                        fontSize: 18,
                        // fontStyle: FontStyle.italic
                      ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, SinginScreen.id);
                        },
                        child: Text("Login",
                        style: TextStyle(
                          color: Color(0xFF4525F2),
                          fontSize: 16,
                          // fontStyle: FontStyle.italic
                        )
                        ),
                      ),                    

                    ],
                  ),
                ),

                CustomeTextField(
                  onSavedCustom: (value){
                    print(value);
                      _name = value;
                  },
                  hint : " UserName ",
                  iconData : Icons.person
                ),

                SizedBox(
                    height: hieght * .03,
                ),
                CustomeTextField(
                  onSavedCustom: (value){
                    print(value);
                      _email = value;
                  },
                  hint : "  Email ",
                  iconData : Icons.email
                ),

                SizedBox(
                    height: hieght * .02,
                ),

             CustomeTextField(
                  onSavedCustom: (value){
                      _password = value;
                  },
                  hint : " Password ",
                  iconData : Icons.lock
                ),
                
            SizedBox(
                  height: hieght * .02,
                ),

                Padding(
                
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Builder(
                    builder:(context)=> FlatButton(
                      
                      shape: RoundedRectangleBorder(
                      
                        borderRadius: BorderRadius.circular(20)
                      ),
                      onPressed: () async{
                          _validate(context);
                      },padding: EdgeInsets.all(15),
                                            color: KbgButtonColor,
                                            child: Text(
                                              'Sign Up',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16
                                              ),
                                            ),
                                          ),
                                      ),
                                      ),
                          
                                         SizedBox(
                                          height: hieght * .01,
                                      ),

    
                                    ],
                                  ),
                                ),
              ),
      );
    
  }   
    
    
    void _validate(BuildContext context) async{

      final modelud = Provider.of<ModelHud>(context,listen: false);
          modelud.changeIsLoadein(true);
      if(_globalKey.currentState.validate()){
        _globalKey.currentState.save();
         try{ 
          await _auth.signUp(_email, _password,_name);
          modelud.changeIsLoadein(false);
          Navigator.pushNamed(context, Home.id);
         }catch(e){
          modelud.changeIsLoadein(false);
           Scaffold.of(context).showSnackBar(
             SnackBar(
                content: Text(
                  e.message
                ), 
             )
           );
         }
      //   }
      }
          modelud.changeIsLoadein(false);

    }

  // }

}