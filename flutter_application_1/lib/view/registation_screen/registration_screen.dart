import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/registration_controller/registration_controller.dart';
import 'package:flutter_application_1/view/login_page/login.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final providerobj = context.watch<RegistrationScreenController>();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Register Now",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                TextField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "E-mail "),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  obscureText: true,
                  controller: passcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "phone number "),
                ),
              ],
            ),
          ),
          Column(
            children: [
              providerobj.isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        if (emailcontroller.text.isNotEmpty &&
                            passcontroller.text.isNotEmpty) {
                          context
                              .read<RegistrationScreenController>()
                              .register(
                                  context: context,
                                  email: emailcontroller.text,
                                  password: passcontroller.text)
                              .then((value) {
                            // login sucess
                            if (value == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text("register sucess")));

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ));
                            }
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("enter valid email and password")));
                        }
                      },
                      child: Text("Register")),
            ],
          )
        ],
      ),
    );
  }
}
