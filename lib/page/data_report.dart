import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../language_controller.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage() : super();

  @override
  _ProfilePageState createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
 // text fields' controllers
 // final TextEditingController _faceController = TextEditingController();
 // final TextEditingController _sourceController = TextEditingController();
 // final TextEditingController _commentController = TextEditingController();
  final CollectionReference _feedbacks =
      FirebaseFirestore.instance.collection('feedbacks');

  @override
  Widget build(BuildContext context) {
    context.watch<LanguageController>();
    return Scaffold(
      appBar: AppBar(
        title:  Center(child: Text('data_report_title'.tr())),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
        stream: _feedbacks.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card( 
                  margin: const EdgeInsets.all(10),
                  child: 
                 ListTile( 
                  title: getMyFace(documentSnapshot['face']),
                  subtitle: Text(documentSnapshot['comment']),
                  trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                         // IconButton(
                              //icon: const Icon(Icons.edit),
                              //onPressed: () =>
                                 // _update(documentSnapshot)),
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  _delete(documentSnapshot.id)),
                        ],
                      ),
                    ),
                  )    
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
        onPressed: () {

        },
        child: const Icon(Icons.create_new_folder_outlined),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
  // create function
/*  Future<void> _create() async {

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
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _faceController,
                  decoration: const InputDecoration(labelText: 'Enter Face'),
                ),
               /* TextField(
                  controller: _sourceController,
                  decoration: const InputDecoration(
                    labelText: 'Source',
                  ),
                ),*/
                TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    labelText: 'Comment',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    final int? face =
                    int.tryParse(_faceController.text);
                    //final String source = _sourceController.text;
                    final String comment = _commentController.text;
                    if (face != null && comment != null) {
                        await _feedbacks.add({"face": face, "comment": comment});

                      _faceController.text = '';
                     // _sourceController.text = '';
                      _commentController.text = '';
                        Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );

        });
  }*/
  
  // update function
 /* Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {

      _faceController.text = documentSnapshot['face'].toString();
     // _sourceController.text = documentSnapshot['source'];
      _commentController.text = documentSnapshot['comment'];
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
                  controller: _faceController,
                  decoration: const InputDecoration(labelText: 'Face'),
                ),
               /* TextField(
                  controller: _sourceController,
                  decoration: const InputDecoration(
                    labelText: 'Source',
                  ),
                ),*/
                TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    labelText: 'Comment',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text( 'Update'),
                  onPressed: () async {
                    final int? face =
                    int.tryParse(_faceController.text);
                    //final String source = _sourceController.text;
                    final String comment = _commentController.text;
                    if (face != null && comment != null) {
                       await _feedbacks
                            .doc(documentSnapshot!.id)
                            .update({"face": face, "comment": comment});
                      _faceController.text = '';
                     // _sourceController.text = '';
                      _commentController.text = '';
                        Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }*/

  // delete function
  Future<void> _delete(String feedbackId) async {
    await _feedbacks.doc(feedbackId).delete();

    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content: Text('data_report_text'.tr())));
  }

  Ink getMyFace(int faceIndex) {
 if (faceIndex == 1) {
    return Ink.image(
                  width: 30,
                  height: 30,
                  image: AssetImage('assets/images/wow.gif'),
                );
 } else
  if (faceIndex == 2) {
   return Ink.image(
                  width: 30,
                  height: 30,
                  image: AssetImage('assets/images/happy.gif'),
                );
  } else 
    if(faceIndex == 2) {
      return Ink.image(
                  width: 30,
                  height: 30,
                  image: AssetImage('assets/images/quitehappy.gif'),
                );
    } else {
      return Ink.image(
                  width: 30,
                  height: 30,
                  image: AssetImage('assets/images/sad.gif'),
                );
    }
}
}

     