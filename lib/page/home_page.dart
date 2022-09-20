import 'package:flutter/material.dart';
import 'package:navigation_rail_example/language_controller.dart';
import 'package:navigation_rail_example/page/data_report.dart';
import 'package:navigation_rail_example/page/second_page.dart';
import 'package:provider/provider.dart';
import 'four_page.dart';
import 'login.dart';
import 'globals.dart' as globals;
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
   int index = 0;
  @override
  Widget build(BuildContext context) {
   context.watch<LanguageController>();
 return Scaffold(
   body: Center(
      child: Column(  
 mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    Text('home_page_text1'.tr(),style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.0)),
    Text('home_page_text2'.tr(), style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0)),
    new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Column(
          children: <Widget>[
            Material(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Ink.image(
                  width: 200,
                  height: 200,
                  fit: BoxFit.fitHeight,
                  image: AssetImage('assets/images/wow.gif'),
                  child: InkWell(
                    onTap: () => {
                      globals.globalface = 1,
                        Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FourPage(), 
                        ),
                        ),
                    },
                    
                  ),
                ),
              ),
          Text('excellent_face_text'.tr(), style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.0)),
          ],
        ),
        SizedBox(height: 350),
         SizedBox(width: 50),
        new Column(
          children: <Widget>[
            Material(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Ink.image(
                  width: 215,
                  height: 215,
                  //fit: BoxFit.fitHeight,
                  image: AssetImage('assets/images/happy.gif'),
                  child: InkWell(
                   onTap: () => {
                        globals.globalface = 2,
                        Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FourPage(), 
                        ),
                        ),
                    },
                  ),
                ),
              ),
          Text('good_face_text'.tr(), style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.0)),
          ],
        ),
       SizedBox(height: 350),
         SizedBox(width: 50),
         new Column(
          children: <Widget>[
            Material(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Ink.image(
                  width: 200,
                  height: 200,
                  //fit: BoxFit.fitHeight,
                  image: AssetImage('assets/images/quitehappy.gif'),
                  child: InkWell(
                    onTap: () => {
                      globals.globalface = 3,
                        Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FourPage(), 
                        ),
                        ),
                    },
                  ),
                ),
              ),
          Text('average_face_text'.tr(), style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.0)),
          ],
        ),
       SizedBox(height: 350),
         SizedBox(width: 50),
        new Column(
          children: <Widget>[
            Material(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Ink.image(
                  width: 200,
                  height: 200,
                  //fit: BoxFit.fitHeight,
                  image: AssetImage('assets/images/sad.gif'),
                  child: InkWell(
                    onTap: () => {
                      globals.globalface = 4,
                        Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FourPage(), 
                        ),
                        ),
                    },
                  ),
                ),
              ),
          Text('poor_face_text'.tr(), style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.0)),
          ],
        ),
      ]
    ),
  ],
)
      ),
    );
  }
  
 
   Widget buildPages() {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return FavouritesPage();
      case 2:
        return ProfilePage();
      case 3:
        return SecondPage();
      default:
        return HomePage();
    }
  }
}
