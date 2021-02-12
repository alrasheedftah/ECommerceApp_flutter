import 'package:ECommerceTask/MyWidget/CustomeTextField.dart';
import 'package:ECommerceTask/provider/ModelHud.dart';
import 'package:ECommerceTask/screen/suplier/PanelSuplier.dart';
import 'package:ECommerceTask/screen/user/ShopPage.dart';
import 'package:ECommerceTask/services/Auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Home.dart';
import '../constants.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SignupScreen.dart';

class SinginScreen extends StatefulWidget{
  static final String id="SigninScreen";
  @override
  State<StatefulWidget> createState() => _SinginScreen();

}

class _SinginScreen extends State<SinginScreen>{
  final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();
  bool KeepMeLoggin=false;
     String _email,_password;
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
                            'Sign In',
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
                      Text("New user? ",
                      style: TextStyle(
                        color: Color(0xFF1C2126),
                        fontSize: 18,
                        // fontStyle: FontStyle.italic
                      ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, SignupScreen.id);
                        },
                        child: Text("Create an account",
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
                SizedBox(
                    height: hieght * .03,
                ),
                CustomeTextField(
                  onSavedCustom: (value){
                    print(value);
                      _email = value;
                  },
                  hint : " UserName or Email ",
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
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: <Widget>[
                                Checkbox(
                                  value: KeepMeLoggin,
                                  activeColor: KbgButtonColor,
                                  checkColor: MainColor,
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  onChanged: (value){
                                    print(KeepMeLoggin);
                                    setState(() {
                                      KeepMeLoggin =value;
                                    });
                                  },
                                ),
                                Text(
                                  "Keep Me Signed In",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF1C2126),
                                    fontWeight: FontWeight.w700  
                                  ),
                                )
                              ],
                              
                            ),
                            
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
                                              'Sign In',
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

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text('--------',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16
                                          ),
                                          ),
                                          GestureDetector(
                                           onTap: (){
                                            //  Navigator.pushNamed(context, ShopPage.id);
                                           }, 
                                           child: Text(' or Sing In With  ------- ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16
                                            ),
                                            ),
                                          ),
                          
                                        ],
                                      ),
                                     SizedBox(
                                          height: hieght * .04,
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10),
                                              child: CircleAvatar(
                                                maxRadius: 30,
                                                backgroundColor: SecondaryColor,
                                                child: Icon(
                                                  Icons.alternate_email,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10),
                                              child: CircleAvatar(
                                                maxRadius: 30,
                                                backgroundColor: SecondaryColor,
                                                child: Image(
                                                  image: AssetImage('images/icons/facebook.png'),
                                                  height: hieght * .09,
                                                  width: MediaQuery.of(context).size.width * .09,

                                                ),

                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10),
                                              child: CircleAvatar(
                                                maxRadius: 30,
                                                backgroundColor: SecondaryColor,
                                                child: Image(
                                                  image: AssetImage('images/icons/linkIn.png'
                                                    
                                                  ),
                                                  height: hieght * .09,
                                                  width: MediaQuery.of(context).size.width * .07,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10),
                                              child: CircleAvatar(
                                                maxRadius: 30,
                                                backgroundColor: SecondaryColor,
                                                child: Image(
                                                  image: AssetImage('images/icons/google.png'),
                                                
                                                  height: hieght * .07,
                                                  width: MediaQuery.of(context).size.width * .07,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
    
                                      // Padding(
                                      //  padding: EdgeInsets.symmetric(horizontal: 30 , vertical: 30), 
                                      //  child: Row(
                                      //     children: <Widget>[
                                      //       Expanded(
                                      //      child: GestureDetector(
                                      //       onTap: () {
                                      //       // Provider.of<AdminMode>(context,listen: false).changeISAdmin(true);
                                      //         // print(Provider.of<AdminMode>(context,listen: false).isAdmin);
                                            
                                      //       }, 
                                      //       child: Text(
                                      //           'I\'m Is Admin ',
                                      //           textAlign: TextAlign.center,
                                      //           style: TextStyle(
                                      //               color: Provider.of<AdminMode>(context).isAdmin ? MainColor : Colors.white 
                                      //           ),                      
                                      //         ),
                                      //            ),
                                      //       ),
                                      //       Expanded(
                                      //          child: GestureDetector(
                                      //            onTap: (){
                                      //               Provider.of<AdminMode>(context,listen: false).changeISAdmin(false);
                                      //              print(Provider.of<AdminMode>(context,listen: false).isAdmin);

                                      //            },
                                      //           child: Text(
                                      //             '\'m Is User ',
                                      //             textAlign: TextAlign.center,
                                      //             style: TextStyle(
                                      //               color: Provider.of<AdminMode>(context).isAdmin ?  Colors.white: MainColor  
                                      //             ),                      
                          
                                      //         ),
                                      //          ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // )
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
        if(roleAdmin == _password)
        {
        //     if(roleAdmin == _password){
         try{ 
           print(_email);
          await _auth.signIn(_email, _password);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isAdmin', true);
 
          modelud.changeIsLoadein(false);
          Navigator.pushNamedAndRemoveUntil(context, PanelSuplier.id,(route)=>false);
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

        //     }else{
        //   modelud.changeIsLoadein(false);

        //        Scaffold.of(context).showSnackBar(
        //          SnackBar(
        //            content: Text(
        //              'Somthing Is Wrong '
        //            ),
        //          )
        //        ); 

        //     }

        }
        else{
         try{ 
          await _auth.signIn(_email, _password);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isAdmin', false);
          modelud.changeIsLoadein(false);
          Navigator.pushNamedAndRemoveUntil(context, Home.id, (route) => false);
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
        }
      }
          modelud.changeIsLoadein(false);

    }

  // }

}