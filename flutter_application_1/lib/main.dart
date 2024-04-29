import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/loginscreen_controller/logincontroller.dart';
import 'package:flutter_application_1/controller/registration_controller/registration_controller.dart';
import 'package:flutter_application_1/view/homepage/homepage.dart';
import 'package:flutter_application_1/view/homepage/homescreen2.dart';
import 'package:flutter_application_1/view/login_page/login.dart';
import 'package:flutter_application_1/view/registation_screen/registration_screen.dart';
import 'package:flutter_application_1/view/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyD3JISgSQQv90H3WwoqrgckuB8dDWOg-J0",
          appId: "1:27433387060:android:761402183ae2110d107661",
          messagingSenderId: "",
          projectId: "sampleproject-fcac8"));
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RegistrationScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginscreenController(),
        )
      ],
      child: MaterialApp(
        // home:
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Homepage();
            } else {
              return LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
