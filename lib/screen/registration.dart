import 'package:koda_score_webapp/screen/landing_pg.dart';
import 'package:koda_score_webapp/services/firebase_services.dart';
import 'package:koda_score_webapp/utils/size_configs.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});
  static const routeName = '/registration-page';

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController affiliationController = TextEditingController();
  TextEditingController expController = TextEditingController();
  TextEditingController fieldStudyController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color.fromRGBO(4, 97, 147, 1),
        centerTitle: true,
        title: const Text('Registration'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(15),
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(50),
                ),
                const Text('Name'),
                TextFormField(
                  controller: nameController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    // hintText: 'Enter your name',
                    focusColor: Colors.black,
                    hoverColor: Colors.black,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: getProportionateScreenHeight(35),
                ),
                const Text('Affiliation'),
                TextFormField(
                  controller: affiliationController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    //  hintText: 'Enter your name',
                    focusColor: Colors.black,
                    hoverColor: Colors.black,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your affiliation';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: getProportionateScreenHeight(35),
                ),
                const Text('Experience in Capsule Reading'),
                TextFormField(
                  controller: expController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    //  hintText: 'Enter your name',
                    focusColor: Colors.black,
                    hoverColor: Colors.black,
                    fillColor: Colors.black,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your experience';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: getProportionateScreenHeight(35),
                ),
                const Text('Enter the number of Capsules Read'),
                TextFormField(
                  controller: fieldStudyController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    // hintText: 'Enter your name',
                    focusColor: Colors.black,
                    hoverColor: Colors.black,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the number of Capsules Read';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: getProportionateScreenHeight(100),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        await FirebaseServices().createUser(
                          nameController.text.toString(),
                          affiliationController.text.toString(),
                          expController.text.toString(),
                          fieldStudyController.text.toString(),
                        );
                        Navigator.of(context)
                            .pushReplacementNamed(LandingPage.routeName);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.amberAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
