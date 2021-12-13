import 'dart:convert';

import 'package:flutter/material.dart';
import '../../API.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_textfield.dart';
import 'widgets/text_widget.dart';
import 'widgets/wsized.dart';

class Login extends StatefulWidget {
  static const String routeName = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    TextEditingController email = new TextEditingController(text: "");
    TextEditingController password = TextEditingController(text: "");
    return Scaffold(
      body: Row(

        children: [
          Expanded(
              child: Container(
            color: const Color.fromARGB(255, 40, 42, 57),
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      WSizedBox(wval: 0.05, hval: 0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextWidget(
                                text: 'Login to your account',
                                textcolor: Colors.white,
                                textsize: 45,
                                fontWeight: FontWeight.bold,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                height: 10,
                                width: 10,
                              ),
                            ],
                          ),
                          Divider(height: 100,),
                           CustomTextField(
                            controller: email ,
                              borderradius: 20,
                              bordercolor: Color.fromARGB(255, 50, 54, 69),
                              widh: 0.32,
                              height: 0.09,
                              icon: Icons.mail,
                              iconColor: Colors.grey,
                              hinttext: 'email',
                              hintColor: Colors.grey,
                              fontsize: 15,
                              obscureText: false),
                          WSizedBox(wval: 0, hval: 0.02),
                           CustomTextField(
                            controller: password ,
                              borderradius: 20,
                              bordercolor: Color.fromARGB(255, 50, 54, 69),
                              widh: 0.32,
                              height: 0.09,
                              icon: Icons.lock,
                              iconColor: Colors.grey,
                              hinttext: 'password',
                              hintColor: Colors.grey,
                              fontsize: 15,
                              obscureText: true),
                          WSizedBox(wval: 0, hval: 0.04),
                          CustomButton(
                            buttontext: 'LOGIN',
                            width: 0.32,
                            height: 0.05,
                            bordercolor: Color.fromARGB(255, 29, 144, 244),
                            borderradius: 25,
                            fontsize: 12,
                            fontweight: FontWeight.bold,
                            fontcolor: Colors.white,
                            onPressed: () {
                              print(email.text);
                              print(password.text);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}

Future<void> login(username,password) async {
  try {
    var body = {"username":username, "password":password};
    
    var x = await apiRequest("v1/user/login", "POST",body: json.encode(body));
    print(x);
    return x;
  } catch (e) {
    print(e);
    throw e;
  }
}