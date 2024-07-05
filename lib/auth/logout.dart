import 'package:koda_score_webapp/auth/main_page.dart';
import 'package:koda_score_webapp/screen/landing_pg.dart';
import 'package:koda_score_webapp/screen/loading_screen.dart';
import 'package:koda_score_webapp/utils/menu_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Logout extends StatefulWidget {
  const Logout({Key? key}) : super(key: key);
  static const routeName = '/logout';

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  bool showLoginPage = true;

  void toggleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color.fromRGBO(4, 97, 147, 1),
        leading: Builder(
          builder: (context) => GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: const Icon(
              Icons.menu,
            ),
          ),
        ),
      ),
      drawer: const MenuDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Are you sure you want to logout?',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  /*  await FirebaseAuth.instance.signOut().then(
                    (_) {
                     
                    },
                  );*/
                  await FirebaseAuth.instance.signOut().then((_) {
                    print('success logging out');
                    Navigator.of(context)
                        .pushReplacementNamed(MainPage.routeName);
                  }).catchError((e) {
                    print('failure logging out');
                    print(e);
                  });
                },
                child: const Text('Yes'),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LandingPage(),
                    ),
                  );
                },
                child: const Text('No'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
