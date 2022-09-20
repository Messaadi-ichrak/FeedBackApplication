import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StatisticPage extends StatefulWidget {
  //final Widget child;

  //StatisticPage({required Key key, required this.child}) : super(key: key);

  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  // text fields' controllers
  final CollectionReference _feedbacks =
      FirebaseFirestore.instance.collection('feedbacks');
 
 double face2Val = 0 ;
 double face3Val = 0 ;
 double face4Val = 0 ;
  List<charts.Series<Task, String>> _seriesPieData = [];

  _generateData() async {
    var piedata = [
      new Task('excellent_face_text'.tr(), await getValueFace1(), Color(0xff3366cc)),
      new Task('good_face_text'.tr(), await getValueFace2(), Color(0xff990099)),
      new Task('average_face_text'.tr(), await getValueFace3(), Color(0xff109618)),
      new Task('poor_face_text'.tr(), await getValueFace4(), Color(0xfffdbe19)),
    ];
    _seriesPieData.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air Pollution',
        data: piedata,
         labelAccessorFn: (Task row, _) => '${row.taskvalue}',
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    _seriesPieData = <charts.Series<Task, String>>[];
    _generateData();
    getValueFace1();
    getValueFace2();
    getValueFace3();
    getValueFace4();
  }

// part for feedback 
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
// part for feedback
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff1976d2),
            automaticallyImplyLeading: false,
            bottom: TabBar(
              indicatorColor: Color(0xff9962D0),
              tabs: [
                Tab(icon: Icon(FontAwesomeIcons.solidChartBar),),
                Tab(icon: Icon(FontAwesomeIcons.chartPie)),
                Tab(icon: Icon(FontAwesomeIcons.chartLine)),
              ],
            ),
            title: Center(child: Text('data_report_title'.tr())),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: StreamBuilder(
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
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                            'chart_title'.tr(),style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                            SizedBox(height: 10.0,),
                        Expanded(
                          child: charts.PieChart<String>(
                            _seriesPieData,
                            animate: true,
                            animationDuration: Duration(seconds: 5),
                             behaviors: [
                            new charts.DatumLegend(
                              outsideJustification: charts.OutsideJustification.endDrawArea,
                              horizontalFirst: false,
                              desiredMaxRows: 2,
                              cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                              entryTextStyle: charts.TextStyleSpec(
                                  color: charts.MaterialPalette.purple.shadeDefault,
                                  fontFamily: 'Georgia',
                                  fontSize: 11),
                            )
                          ],
                           defaultRenderer: new charts.ArcRendererConfig(
                              arcWidth: 100,
                             arcRendererDecorators: [
          new charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.inside)
        ])),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: StreamBuilder(
        stream: _feedbacks.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                return Card( 
                  margin: const EdgeInsets.all(10),
                  child: fetchComment(documentSnapshot['comment'])
                 ? ListTile( 
                  //title: getMyFace(documentSnapshot['face']),
                  subtitle: Text(documentSnapshot['comment']),
                  ): null,
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
            },
             ),
               ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

Future<double> getValueFace1() async {
    double face1Val = 0 ;
 await _feedbacks.get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if(doc['face'] == 1){
            face1Val = face1Val + 1;
          }       
        });
    });
    print("face1Val");
    return face1Val;    
  }
  
Future<double> getValueFace2() async {
    double face1Val = 0 ;
 await _feedbacks.get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if(doc['face'] == 2){
            face1Val = face1Val + 1;
          }       
        });
    });
    print("face1Val");
    return face1Val;    
  }
Future<double> getValueFace3() async {
    double face1Val = 0 ;
 await _feedbacks.get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if(doc['face'] == 3){
            face1Val = face1Val + 1;
          }       
        });
    });
    print("face1Val");
    return face1Val;    
  }
Future<double> getValueFace4() async {
    double face1Val = 0 ;
 await _feedbacks.get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if(doc['face'] == 4){
            face1Val = face1Val + 1;
          }       
        });
    });
    print("face1Val");
    return face1Val;    
  }

bool fetchComment(String cmnt){
  if(cmnt.length > 4){
    return true;
  }else {
    return false;
  }
}

}
class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}