import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';
import '../language_controller.dart';

class SettingsPage extends StatefulWidget {

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
// text fields' controllers
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance; 
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');
       bool _passwordVisible = false;
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }
      
/*void _signUpUser(String email, String password, BuildContext context, String fullName) async {
    try {
      String? _returnString = await Auth().signUpUser(email, password, fullName);
      if (_returnString == "success") {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_returnString!),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  } */
  Future<void> _create() async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _fullNameController,
                  decoration:  InputDecoration(labelText: 'users_table_text1'.tr()),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'login_page_text3'.tr(),
                  ),
                ),
                TextFormField(
            keyboardType: TextInputType.text,
            //controller: _userPasswordController,
            obscureText: !_passwordVisible,
            controller: _pwdController, 
            decoration:  InputDecoration(   
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
          ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text('users_table_button1'.tr()),
                  onPressed: () async {
                    final String name = _fullNameController.text;
                    final String email = _emailController.text;
                    final String pwd = _pwdController.text;
      if(name.length <= 4 || name.isEmpty){
               showDialog(
               context: context,
               builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Ooops_text'.tr()),
              content: Text('name_wrong_text'.tr()),
              actions: [
                TextButton(
                  child: Text('alert_button'.tr()),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                    )
                     ],
                       );
                       });
                    } else 
    if(!isEmail(email) || name.isEmpty){
              showDialog(
               context: context,
               builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Ooops_text'.tr()),
              content: Text('name_email_text'.tr()),
              actions: [
                TextButton(
                  child: Text('alert_button'.tr()),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                    )
                     ],
                       );
                       });
                    }else 
  if(pwd.length <= 6 || name.isEmpty) {
                    showDialog(
               context: context,
               builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Ooops_text'.tr()),
              content: Text('name_pwd_text'.tr()),
              actions: [
                TextButton(
                  child: Text('alert_button'.tr()),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                    )
                     ],
                       );
                       });  

                    }
  else{
                    await _auth.createUserWithEmailAndPassword(email: email, password: pwd); 
                    await _users.add({"full_name": name, "email": email, "pwd": pwd});
                      _fullNameController.text = '';
                      _emailController.text = '';
                      _pwdController.text = '';
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("User added succesfly"),
                    duration: Duration(seconds: 2),
                  ),
                );
                }
                  },
                )
              ],
            ),
          );

        });
  }
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _fullNameController.text = documentSnapshot['full_name'];
      _emailController.text = documentSnapshot['email'];
      _pwdController.text = documentSnapshot['pwd'];
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _fullNameController,
                  decoration: InputDecoration(labelText: 'users_table_text1'.tr()),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'login_page_text3'.tr(),
                  ),
                ),
                TextField(
                  controller: _pwdController,
                  decoration: InputDecoration(
                    labelText: 'login_page_text6'.tr(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text( 'users_table_button2'.tr()),
                  onPressed: () async {
                    final String name = _fullNameController.text;
                    final String email = _emailController.text;
                    final String pwd = _pwdController.text;
                    User? updateUser = await _auth.currentUser;
                    if (name.isEmpty || email.isEmpty || pwd.isEmpty) {
                      showDialog(
               context: context,
               builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Ooops_text'.tr()),
              content: Text('all_fields_wrong'.tr()),
              actions: [
                TextButton(
                  child: Text('alert_button'.tr()),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                    )
                     ],
                       );
                       });  
                    } else {
                      await updateUser?.updateEmail(email);
                      await updateUser?.updatePassword(pwd);
                       await _users.doc(documentSnapshot!.id)
                            .update({"full_name": name, "email": email, "pwd": pwd});
                      _fullNameController.text = '';
                      _emailController.text = '';
                      _pwdController.text = '';
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('user_updated'.tr()),
                    duration: Duration(seconds: 2),
                  ),
                );
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String userId) async {
    User? deletUser = await _auth.currentUser;
    await deletUser?.delete();
    await _users.doc(userId).delete();
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content: Text('users_table_text2'.tr())));
  }

  @override
  Widget build(BuildContext context) {
    context.watch<LanguageController>();
    return Scaffold(
      appBar: AppBar(
        title:  Center(child: Text('users_table_title'.tr())),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
        stream: _users.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['full_name']),
                    subtitle: Text(documentSnapshot['email']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _update(documentSnapshot)),
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  _delete(documentSnapshot.id)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
// Add new product
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        child: const Icon(Icons.add),

      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
}
