import 'package:flutter/material.dart';
import 'four_page.dart';
import 'globals.dart' as globals;
//import 'package:navigation_rail_example/page/notifiers.dart';
//import 'package:provider/provider.dart';

class SecondPage extends StatefulWidget {
 
  @override
  _SecondPageState createState() =>
      _SecondPageState();
}
class _SecondPageState extends State<SecondPage> {
  TextEditingController _sourceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Row(
            children: <Widget>[
              Ink.image(
                  width: 500,
                  height: 400,
                  image: AssetImage('assets/images/select.gif'),
                  child: InkWell(
                    ),
                ),

              Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Text('How did you discover our Center ? ', style: TextStyle(fontSize: 35)),
            SizedBox(
              width:650,
              child: ListView(
          shrinkWrap: true,
          children: ListTile.divideTiles(tiles: [
            ListTile(
              title: Text('Recommendation from a friend',style: TextStyle(fontSize: 20)),
              onTap: () => {
                       globals.globalSource = 'Recommendation from a friend',
                        Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FourPage(), 
                        ),
                        ),
                    },
            ),
            ListTile(
              title: Text('Social media (Twitter, facebook, Instgrame, ect.)',style: TextStyle(fontSize: 20)),
              onTap: () => {
                        globals.globalSource = 'Social media (Twitter, facebook, Instgrame, ect.)',
                        Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FourPage(), 
                        ),
                        ),
                    },
            ),
            ListTile(
              title: Text('Search engine',style: TextStyle(fontSize: 20)),
             onTap: () => {
                        globals.globalSource = 'Search engine',
                        Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FourPage(), 
                        ),
                        ),
                    },
            ),
            ListTile(
              title: Text('Recommendation from A Doctor',style: TextStyle(fontSize: 20)),
              onTap: () => {
                        globals.globalSource = 'Recommendation from A Doctor',
                        Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FourPage(), 
                        ),
                        ),
                    },
            ),
            ListTile(
              title: Text('Ad',style: TextStyle(fontSize: 20)),
              onTap: () => {
                         globals.globalSource = 'Ad',
                        Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FourPage(), 
                        ),
                        ),
                    },
            ),
            ListTile(
                title: Text('other',style: TextStyle(fontSize: 20)),
                onTap: () => _showAddNoteDialog(context))
          ], context: context)
              .toList(),
        )
            ),
          ],
          )
           
           ],
           
          
          ),
          
          )
        );
  }

 /*_showMessageDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to delete all items'),
            actions: [
              TextButton(
                child: Text('Yes'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          )); 

  _showSingleChoiceDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) {
          final _singleNotifier = Provider.of<SingleNotifier>(context);
          return AlertDialog(
            title: Text('Select one country'),
            content: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: countries
                      .map((e) => RadioListTile(
                            title: Text(e),
                            value: e,
                            groupValue: _singleNotifier.currentCountry,
                            selected: _singleNotifier.currentCountry == e,
                            onChanged: (value) {
                              _singleNotifier.updateCountry(value);
                              Navigator.of(context).pop();
                            },
                          ))
                      .toList(),
                ),
              ),
            ),
          );
        },
      );
  _showMultipleChoiceDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        final _multipleNotifier = Provider.of<MultipleNotifier>(context);
        return AlertDialog(
          title: Text('Select one country or many countries'),
          content: SingleChildScrollView(
            child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: countries
                      .map((e) => CheckboxListTile(
                            title: Text(e),
                            onChanged: (value) {
                              value
                                  ? _multipleNotifier.addItem(e)
                                  : _multipleNotifier.removeItem(e);
                            },
                            value: _multipleNotifier.isHaveItem(e),
                          ))
                      .toList(),
                )),
          ),
          actions: [
            TextButton(
              child: Text('Yes'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });
*/
  _showAddNoteDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add your note"),
            content: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _sourceController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Enter your note',
                          icon: Icon(Icons.note_add)),
                    )
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                child: Text("Submit"),
                onPressed: () {
                   globals.globalSource = _sourceController.text;
                   Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FourPage(), 
                        ),
                        );
                },
              ),
              TextButton(
                child: Text("Cancel"),
                onPressed: () {
                   Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
}