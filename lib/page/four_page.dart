import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../language_controller.dart';
import '../main.dart';
import 'globals.dart' as globals;
import 'package:easy_localization/easy_localization.dart';

class FourPage extends StatefulWidget {
 
  @override
  _FourPageState createState() =>
      _FourPageState();
}

class  _FourPageState extends State<FourPage> {
  TextEditingController _commentController = TextEditingController();
  // Create a global key that uniquely identifies the Form widget  
  // and allows validation of the form.  
  final _formKey = GlobalKey<FormState>();  
  final CollectionReference _feedbacks =
      FirebaseFirestore.instance.collection('feedbacks');
  
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
                  image: AssetImage('assets/images/newcomment.gif'),
                  child: InkWell(
                    ),
                ),
       Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('four_page_text'.tr(), style: TextStyle(fontSize: 35)),
          SizedBox(height: 30),
          Form(
      key: _formKey,  
      child: Column(  
        crossAxisAlignment: CrossAxisAlignment.start,  
        children: <Widget>[  

          SizedBox( // <-- SEE HERE
          width: 650,
          child: TextFormField( 
            controller: _commentController, 
            decoration: InputDecoration(  
              icon: const Icon(Icons.comment),  
              hintText: 'leave_a_comment_text'.tr(),  
              labelText: 'comment_text1'.tr(),  
            ),  
            validator: (value) {  
              if (value!.isEmpty) {  
                return 'comment_text2'.tr();  
              }  
              return null;  
            },  
          ),  
          ),   

         
          new Container(  
              padding: const EdgeInsets.only(left: 150.0, top: 40.0),  
              child: new ElevatedButton(  
                child: Text('text_button'.tr()),  
                onPressed: () async {   
                  if (_formKey.currentState!.validate()) { 
                    globals.globalComment =  _commentController.text;
                    final int face = globals.globalface;
                    final String comment = globals.globalComment;
                    //  here is my code to submit the data to database
                         if(globals.globalface != 0 && globals.globalComment != ''){
                      
                     await _feedbacks.add({"face": face, "comment": comment});
                          globals.globalface = 0;
                          globals.globalComment = '';
                          _commentController.text = '';
                          _showMessageDialog(context);
                         }
                    
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
  _showMessageDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('thanks_text1'.tr()),
            content: Column(
              children: <Widget>[
                Ink.image(
                  width: 300,
                  height: 300,
                  image: AssetImage('assets/images/thankYou.gif'),
                  child: InkWell(
                    /* onTap: () => {
                        Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MyApp(), 
                        ),
                        ),
                    },
                    */
                    ),
                ),
                Text('thanks_text2'.tr()),
              ],
            ),
            
            actions: [
              TextButton(
                child: Text('button_text_back'.tr()),
                onPressed: () => {
                       Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MainPage(), 
                        ),
                        ),
                       
                } 
              )
            ],
          ));   
}  
     