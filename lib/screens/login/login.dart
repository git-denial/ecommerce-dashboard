import 'dart:convert';
import 'dart:js';

import 'package:admin/models/Admin.dart';
import 'package:admin/routes.dart';
import 'package:flutter/material.dart';
import '../../API.dart';
import '../../dialogAlert.dart';
import '../../error.dart';
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
  bool loggedin = false;

  bool? remem = false;
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    final Size size = MediaQuery.of(context).size;
     TextEditingController username = new TextEditingController();
    TextEditingController password = TextEditingController(text: "");
    return Scaffold(
      body: Row(
        children: [
          FutureBuilder(
            future: Admin.tokenLogin(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if(snapshot.hasError){
                  print(snapshot.error);
                  print("snapshot.error");
              }
              else{
                print("kokis");
                //Future.delayed(Duration.zero, () => Navigator.pushReplacementNamed(context, pageRoutes.userList));
                
              }
              return Text("");
            },
          ),
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
                          Divider(
                            height: 100,
                          ),
                          CustomTextField(
                              controller: username,
                              borderradius: 20,
                              bordercolor: Color.fromARGB(255, 50, 54, 69),
                              widh: 0.32,
                              height: 0.09,
                              icon: Icons.mail,
                              iconColor: Colors.grey,
                              hinttext: 'username',
                              hintColor: Colors.grey,
                              fontsize: 15,
                              obscureText: false),
                          WSizedBox(wval: 0, hval: 0.02),
                          CustomTextField(
                              controller: password,
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
                          Row(
                            children: [
                              Text("Remeber me"),
                              Checkbox(
                                  activeColor: Color(0xff00C8E8),
                                  value: remem,
                                  onChanged: (v) {
                                    setState(() {
                                      remem = v;
                                    });
                                  }),
                            ],
                          ),
                          CustomButton(
                            buttontext: 'LOGIN',
                            width: 0.32,
                            height: 0.05,
                            bordercolor: Color.fromARGB(255, 29, 144, 244),
                            borderradius: 25,
                            fontsize: 12,
                            fontweight: FontWeight.bold,
                            fontcolor: Colors.white,
                            onPressed: () async {
                              print(username.text);
                              print(password.text);
                              try {
                                await Admin.login(username.text, password.text,remem);
                                Navigator.pushReplacementNamed(
                                    context, pageRoutes.userList);
                              } catch (e) {
                                var err = HTTPErrorType.fromJson(
                                    json.decode(e.toString()));
                                var errObject = err.generateAlertitleContent();
                                String title = errObject['title']!;
                                String content = errObject['content']!;
                                showDialogAlert(context, title, content);
                              }
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
