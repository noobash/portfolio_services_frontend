import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Loading.dart';

void main() {
  runApp(
    MaterialApp(home: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Login();
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  //dynamic response;

  void createAlbum(String email, String password) async {
    try {
      Map<String, dynamic> request = {'email': email, 'password': password};
      var response = await http.get(Uri.parse(
          'https://portfolio-services.onrender.com/api/v1/portfolio/64ea3ea95c23934a6472ed59'));
      print(response.body);
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.red,
            appBar: AppBar(
              elevation: 0.0,
              title: const Text('Login'),
            ),
            body: Stack(children: <Widget>[
              const SizedBox(
                height: 20.0,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 30.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                            child: TextFormField(
                              validator: (val) =>
                                  val!.isEmpty ? "Enter a valid E-mail" : null,
                              decoration: const InputDecoration(
                                  hintText: "Enter your E-mail",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2.0))),
                              onChanged: (val) {
                                email = val;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                            child: TextFormField(
                              validator: (val) =>
                                  val!.isEmpty ? "Enter password" : null,
                              decoration: const InputDecoration(
                                  hintText: "Enter your password",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2.0))),
                              obscureText: true,
                              onChanged: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 15.0),
                            child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.pink[400],
                                elevation: 0.0,
                                child: MaterialButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        loading = true;
                                        //print("here");
                                      });
                                      createAlbum(email, password);
                                      bool flag = true;
                                      //print(response);
                                      if (flag) {
                                        setState(() {
                                          loading = false;
                                          final snackBar = SnackBar(
                                            content: const Text(
                                                'Enter Valid email and password'),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        });
                                      } else {
                                        setState(() {
                                          loading = false;
                                          final snackBar = SnackBar(
                                              content: const Text('Logged in'));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        });
                                      }
                                    }
                                  },
                                  minWidth: MediaQuery.of(context).size.width,
                                  child: const Text(
                                    "Sign In",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ),
                                )),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 15.0),
                            child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.teal,
                                elevation: 0.0,
                                child: MaterialButton(
                                  onPressed: () async {},
                                  minWidth: MediaQuery.of(context).size.width,
                                  child: const Text(
                                    "Forgot Password ?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ]),
          );
  }
}
