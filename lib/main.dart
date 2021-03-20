import 'package:awesome_loader/awesome_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/ui/home_screen.dart';
import 'package:project/ui/login/login_screen.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<User>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (!snapshot.hasData) {
              return Material(
                child: Center(
                  child: AwesomeLoader(
                    loaderType: AwesomeLoader.AwesomeLoader3,
                    color: Colors.blue,
                  ),
                ),
              );
            }
            User user = snapshot.data;
            return (user != null && user.emailVerified)
                ? HomeScreen()
                : LoginScreen();
          },
        ),
      ),
    );
  }
}
