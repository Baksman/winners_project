// import 'package:awesome_loader/awesome_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:kt_drawer_menu/kt_drawer_menu.dart';
import 'package:project/database/database_service.dart';
import 'package:project/message_screen/chat_list_screen.dart';
import 'package:project/model/user_model.dart';
import 'package:project/paystack/api_key.dart';

import 'package:project/ui/home_screen.dart';
import 'package:project/ui/login/login_screen.dart';
import 'package:project/ui/utils/log_utils.dart';
import 'package:project/ui/widget/drawer.dart';
// import 'package:project/ui/widget/drawer.dart';
import 'package:project/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainWidget());
}

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {


  @override
  Widget build(BuildContext context) {
    //onAuthChange()
    // final width = MediaQuery.of(context).size.width;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        Provider(create: (_) => AppUser()),
        ChangeNotifierProvider(create: (_) => DatabaseService()),
        // DatabaseService
      ],
      child: MaterialApp(
        title: "Winner 💜",
        theme: ThemeData(
          primaryColor: Colors.purple,
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<User>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.hasError) {
              return Text("Please reinstall app");
            }
            // if (snapshot.hasData) {
            //   return Scaffold(
            //     body: Center(
            //       child: CircularProgressIndicator(),
            //     ),
            //   );
            // }
            logger.d("data added");
            User user = snapshot.data;
            if (user != null) {
              Provider.of<AppUser>(ctx).uuid = user.uid;
            }
            // check if user has already logged in and verified there email
            return (user == null || !user.emailVerified)
                ? LoginScreen()
                : KTDrawerMenu(
                    width: 140.0,
                    radius: 10.0,
                    scale: 0.8,
                    content: HomeScreen(),
                    drawer: DrawerWidget(),
                  );
          },
        ),
      ),
    );
  }
}
