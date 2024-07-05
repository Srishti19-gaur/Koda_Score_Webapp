import 'package:koda_score_webapp/auth/auth.dart';
import 'package:koda_score_webapp/screen/landing_pg.dart';
import 'package:koda_score_webapp/utils/size_configs.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainPage extends StatelessWidget {
  static const routeName = '/main-page';
  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const LandingPage(); // const LoadingScreen(); //
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}
