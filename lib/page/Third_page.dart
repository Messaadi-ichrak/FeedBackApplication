import 'package:flutter/material.dart';

import 'four_page.dart';

class ThirdPage extends StatelessWidget {
  // Create a global key that uniquely identifies the Form widget  
  // and allows validation of the form.  
  final _formKey = GlobalKey<FormState>();  
  
  @override  
  Widget build(BuildContext context) {  
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
          Text('Please fill in the form !  ', style: TextStyle(fontSize: 35)),
          SizedBox(height: 25),
          Form(
      key: _formKey,  
      child: Column(  
        crossAxisAlignment: CrossAxisAlignment.start,  
        children: <Widget>[  

          SizedBox( // <-- SEE HERE
          width: 600,
          child: TextFormField(  
            decoration: const InputDecoration(  
              icon: const Icon(Icons.person),  
              hintText: 'Enter your full name',  
              labelText: 'Name',  
            ),  
            validator: (value) {  
              if (value!.isEmpty) {  
                return 'Please enter some text';  
              }  
              return null;  
            },  
          ),  
          ),   
          
          SizedBox( // <-- SEE HERE
          width: 600,
          child: TextFormField(  
            decoration: const InputDecoration(  
              icon: const Icon(Icons.phone),  
              hintText: 'Enter a phone number',  
              labelText: 'Phone',  
            ),  
            validator: (value) {  
              if (value!.isEmpty) {  
                return 'Please enter valid phone number';  
              }  
              return null;  
            },  
          ),  
          ),
        
         SizedBox( // <-- SEE HERE
          width: 600, 
          child: TextFormField(  
            decoration: const InputDecoration(  
            icon: const Icon(Icons.email),  
            hintText: 'Enter your Email',  
            labelText: 'Email',  
            ),  
            validator: (value) {  
              if (value!.isEmpty) {  
                return 'Please enter a valid Email';  
              }  
              return null;  
            },  
           ),  
         ),
          new Container(  
              padding: const EdgeInsets.only(left: 150.0, top: 40.0),  
              child: new ElevatedButton(  
                child: const Text('Next'),  
                onPressed: () {  
                  // It returns true if the form is valid, otherwise returns false  
                  if (_formKey.currentState!.validate()) {  
                      // for moving to next page
                        Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FourPage(), 
                        ),
                        );
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
     