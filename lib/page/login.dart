import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../language_controller.dart';
import 'globals.dart' as globals;
import '../main.dart';
import 'package:easy_localization/easy_localization.dart';
class FavouritesPage extends StatefulWidget {
  FavouritesPage() : super();

  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
   final FirebaseAuth _auth = FirebaseAuth.instance; 
 final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();  
   bool _passwordVisible = false;
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }
  @override  
  Widget build(BuildContext context) {  
    context.watch<LanguageController>();
    return Scaffold(
      body:Center(
        child: Row(
          children: <Widget>[
          Ink.image(
                  width: 500,
                  height: 500,
                  image: AssetImage('assets/images/data.gif'),
                  child: InkWell(
                    ),
                ),

          Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('login_page_text1'.tr(), style: TextStyle(fontSize: 35)),
          SizedBox(height: 25),
          Form(
      key: _formKey,  
      child: Column(  
        crossAxisAlignment: CrossAxisAlignment.start,  
        children: <Widget>[  

          SizedBox( // <-- SEE HERE
          width: 500,
          child: TextFormField(  
            controller: _emailController,
            decoration: InputDecoration(  
              icon: const Icon(Icons.person_outline),  
              hintText: 'login_page_text2'.tr(),
              labelText: 'login_page_text3'.tr(),  
            ),  
            validator: (value) { 
              if(value != null) {
               if (!isEmail(value)) {  
                return 'login_page_text4'.tr();  
              }
              }
              return null;  
            },   
          ),  
          ),   
         SizedBox( // <-- SEE HERE
          width: 500, 
          child: TextFormField(
            keyboardType: TextInputType.text,
            //controller: _userPasswordController,
            obscureText: !_passwordVisible,
            controller: _pwdController, 
            decoration:  InputDecoration(  
            icon: const Icon(Icons.lock_outline),  
            hintText: 'login_page_text5'.tr(),  
            labelText: 'login_page_text6'.tr(), 
           suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
               _passwordVisible
               ? Icons.visibility
               : Icons.visibility_off,
               color: Theme.of(context).primaryColorDark,
               ),
            onPressed: () {
               // Update the state i.e. toogle the state of passwordVisible variable
               setState(() {
                   _passwordVisible = !_passwordVisible;
               });
             },
            ),
                    ),  
            validator: (value) {  
              if ( value!.isEmpty ) {  
                return 'login_page_text7'.tr();  
              }  
              return null;  
            },  
           ),  
         ),
          new Container(  
              padding: const EdgeInsets.only(left: 150.0, top: 40.0),  
              child: new ElevatedButton(  
                child: Text('text_button'.tr()),  
                onPressed: () {  
                  // It returns true if the form is valid, otherwise returns false  
                  if (_formKey.currentState!.validate()) { 
                  _auth.signInWithEmailAndPassword(email:_emailController.text, password: _pwdController.text)
                      .then((value) => {
                          globals.isLoggedIn = true, 
                           Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MainPage(), 
                        ),
                        ),
                        } 
                        ).catchError((err) {
         showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('alert_wrong_cred1'.tr()),
              content: Text('alert_wrong_cred2'.tr()),
              actions: [
                TextButton(
                  child: Text('alert_button'.tr()),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }); });
                        
                        
                  }  
                },  
              )),  
        ],  
      ), 
      ),
        ],
      ),
          ],
        ),
      
      )
      );
    
  }  
}  
     