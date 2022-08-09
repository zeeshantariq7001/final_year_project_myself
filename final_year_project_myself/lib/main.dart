import 'package:final_year_project_myself/reminder/reminder_page.dart';
import 'package:final_year_project_myself/reminder/services.dart';
import 'package:final_year_project_myself/screens/All_tasks.dart';
import 'package:final_year_project_myself/screens/all_screens.dart';
import 'package:final_year_project_myself/screens/homescreen.dart';
import 'package:final_year_project_myself/screens/loginscreen.dart';
import 'package:final_year_project_myself/screens/others_screen.dart';
import 'package:final_year_project_myself/screens/splashscreen.dart';
import 'package:final_year_project_myself/services/themeservices.dart';
import 'package:final_year_project_myself/sqf_db/db_helper.dart';
import 'package:final_year_project_myself/widgets/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init();
  NotificationService nt = NotificationService();
  await nt.init();
  runApp(MyApp());
}

///global navigator
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: ((context, orientation, deviceType) {
        return FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Task Reminder app',
                theme: Themes.light,
                themeMode: ThemeServices().theme,
                darkTheme: Themes.dark,
                home: SplashScreen(),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        );
      }),
    );
  }
}
