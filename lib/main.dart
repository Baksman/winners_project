// import 'package:awesome_loader/awesome_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/database/database_service.dart';
import 'package:project/model/user_model.dart';
import 'package:project/paystack/paystack.dart';
// import 'package:kt_drawer_menu/kt_drawer_menu.dart';
import 'package:project/ui/home_screen.dart';
import 'package:project/ui/login/login_screen.dart';
import 'package:project/ui/utils/log_utils.dart';
// import 'package:project/ui/widget/drawer.dart';
import 'package:project/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainWidget());
}

class MainWidget extends StatelessWidget {
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
              print(snapshot.error);
              logger.d(snapshot.error);
            }
            if (!snapshot.hasData) {
              // return Material(
              //   child: Center(
              //     child: AwesomeLoader(
              //       loaderType: AwesomeLoader.AwesomeLoader3,
              //       color: Colors.blue,
              //     ),
              //   ),
              // );
            }
            logger.d("data added");
            User user = snapshot.data;
            if (user != null) {
              Provider.of<AppUser>(ctx).uuid = user.uid;
            }
            // check if user has already logged in and verified there email
            return (user == null || !user.emailVerified)
                ? LoginScreen()
                : HomePage();
          },
        ),
      ),
    );
  }
}

// class HomeBody extends StatelessWidget {
//   final User user;

//   const HomeBody({Key key, this.user}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return user == null ? LoginScreen() : HomeScreen();
//   }
// }
// // width: 360.0,
