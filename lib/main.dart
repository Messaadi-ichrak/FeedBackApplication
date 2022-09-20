
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:navigation_rail_example/page/login.dart';
import 'package:navigation_rail_example/page/home_page.dart';
import 'package:navigation_rail_example/page/statistic.dart';
import 'package:navigation_rail_example/page/users.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'language_controller.dart';
import 'page/globals.dart' as globals;
import 'widget/animated_rail_widget.dart';

Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  // for translation
  await EasyLocalization.ensureInitialized();
  //await Future.delayed(const Duration(milliseconds: 250), (){}); 
  // for firebase
  await Firebase.initializeApp();
  
  runApp(
    EasyLocalization(
    supportedLocales: [Locale('en', 'US'), Locale('ar', 'SA')],
    saveLocale: true,
    path: 'assets/translations',
    fallbackLocale: Locale('en', 'US'),
    child: MyApp(),
    ),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageController()),
      ],
      child: MaterialApp(
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.black),
        home: MainPage(),
      ),
      );
  }
  
}

class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance; 
  int indexLogged = 0;
  int indexNotLogged = 0;
  bool isExtended = false;

  final selectedColor = Colors.white;
  final unselectedColor = Colors.white60;
  final labelStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
  @override
  Widget build(BuildContext context) {
    LanguageController controller = context.read<LanguageController>();
    // Initial Selected Value
  String dropdownvalue = 'translate_Button_en'.tr();  
 
  // List of items in our dropdown menu
  var items = [   
    'translate_Button_en'.tr(),
    'translate_Button_ar'.tr(),
  ];
        // return EasyLocalization(
    //supportedLocales: [Locale('en'), Locale('ar', 'SA')],
    //path: 'assets/translations',
    //fallbackLocale: Locale('en', 'US'),
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,  
          leadingWidth: 100,
          leading: 
          DropdownButton(
              value: dropdownvalue,    
              icon: const Icon(Icons.keyboard_arrow_down),   
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() async {
                  dropdownvalue = newValue!;
                  if(dropdownvalue == 'English' || dropdownvalue == 'الإنجليزية'){
                      await context.setLocale(Locale('en', 'US'));
                       controller.onLanguageChanged();
                }else{
                       await context.setLocale(Locale('ar', 'SA'));
                       controller.onLanguageChanged();
                }
                });
                

              },
            ),
        
          title: Text('app_title_text'.tr()),  
          
        ),
        body: globals.isLoggedIn
        ? Row(
          children: [
            NavigationRail(
              backgroundColor: Theme.of(context).primaryColor,
              //labelType: NavigationRailLabelType.all,
              selectedIndex: indexLogged,
              extended: isExtended,
              //groupAlignment: 0,
              selectedLabelTextStyle: labelStyle.copyWith(color: selectedColor),
              unselectedLabelTextStyle:
                  labelStyle.copyWith(color: unselectedColor),
              selectedIconTheme: IconThemeData(color: selectedColor, size: 50),
              unselectedIconTheme:
                  IconThemeData(color: unselectedColor, size: 50),
              onDestinationSelected: (indexLogged) =>
                  setState(() => this.indexLogged = indexLogged),
                  // this is for the logo picture
              leading: Material(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Ink.image(
                  width: 80,
                  height: 80,
                  //fit: BoxFit.fitHeight,
                  image: AssetImage('assets/images/mylogo.png'),
                  child: InkWell(
                    onTap: () => setState(() => isExtended = !isExtended),
                  ),
                ),
              ),
               // this is for the log out function
              trailing: AnimatedRailWidget(
                key: null,
                child:  isExtended
                    ? Row(
                        children: [                   
                          IconButton(
                            icon: const Icon(Icons.logout),
                            color: Colors.white,
                            iconSize: 28, 
                            onPressed: () => logout(),
                          ),
                          const SizedBox(width: 12),
                          TextButton(
                           child: Text('button_text_logout'.tr(),style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),),
                             onPressed: () => logout(),
                          ),
                        ],
                      )
                    : Icon(Icons.logout, color: Colors.white),
              ), 
               // this is for the rest of icons in the side bar
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.add_reaction),
                  label: Text('rate_us_icon_text'.tr()),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.supervised_user_circle),
                  label: Text('users_icon_text'.tr()),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.data_exploration_outlined),
                  label: Text('report_data_icon_text'.tr()),
                ),             
              ],
            ),
            Expanded(child: buildPagesLogged()),
          ],
        )
        : Row(
          children: [
            NavigationRail(
              backgroundColor: Theme.of(context).primaryColor,
              //labelType: NavigationRailLabelType.all,
              selectedIndex: indexNotLogged,
              extended: isExtended,
              //groupAlignment: 0,
              selectedLabelTextStyle: labelStyle.copyWith(color: selectedColor),
              unselectedLabelTextStyle:
                  labelStyle.copyWith(color: unselectedColor),
              selectedIconTheme: IconThemeData(color: selectedColor, size: 50),
              unselectedIconTheme:
                  IconThemeData(color: unselectedColor, size: 50),
              onDestinationSelected: (indexNotLogged) =>
                  setState(() => this.indexNotLogged = indexNotLogged),
                  // this is for the logo picture
              leading: Material(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Ink.image(
                  width: 80,
                  height: 80,
                  //fit: BoxFit.fitHeight,
                  image: AssetImage('assets/images/mylogo.png'),
                  child: InkWell(
                    onTap: () => setState(() => isExtended = !isExtended),
                  ),
                ),
              ),
               // this is for the log out function 
               // this is for the rest of icons in the side bar
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.add_reaction),
                  label: Text('rate_us_icon_text'.tr()),

                ),
               NavigationRailDestination(
                  icon: Icon(Icons.login),
                  label: Text('Login_icon_text'.tr()),
                ),
                
              ],
            ),
            Expanded(child: buildPagesNotLogged()),
          ],
        ),
      );
  

} 
 
      

  Widget buildPagesLogged() {
    switch (indexLogged) {
      case 0:
        return HomePage();
      case 1:
        return SettingsPage();
      case 2:
        return StatisticPage();
      default:
        return HomePage();
    }
  }
  Widget buildPagesNotLogged() {
    switch (indexNotLogged) {
      case 0:
        return HomePage();
      case 1:
        return  FavouritesPage();
      default:
        return HomePage();
    }
  }

Future<void> logout() async {
        _auth.signOut().then(
                        (value) => {
                          globals.isLoggedIn = false, 
                        Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MainPage(), 
                        ),
                        ),
                        } 
                        );

}


}