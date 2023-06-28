// ignore_for_file: non_constant_identifier_names, unused_field, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:abersoft_test/list_product.dart';
import 'package:abersoft_test/loginInformationStore/loginInformation.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _LoginInformation = LoginInformation();

  var Username = TextEditingController();
  var Password = TextEditingController();

  @override
  void initState() {
    super.initState();
    Username.text = "";
    Password.text = "";
  }

  void submitLogin() async {
    final String URL_API =
        'https://2e3d13cc-3d6d-4911-b94c-ba23cf332933.mock.pstmn.io/api/v1/login';

    var headers = {'Content-Type': 'application/json'};

    var body = json.encode({
      "Username": Username.text,
      "Password": Password.text,
    });

    http.Response response = await http.post(
      Uri.parse(URL_API),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var responseJson = jsonDecode(response.body);
      var token = responseJson['token'];
      print('Token: $token');

      var SetLoginInformation = {
        // INFORMASI PERSONAL
        'token': token,
        'username': Username.text,
        'password': Password.text,
      };

      _LoginInformation.SetLoginInformation(SetLoginInformation);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Login Success'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProductList()));
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
        barrierDismissible: false,
      );
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                alignment: Alignment.center,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 105),
                    Center(
                        child: Image.asset(
                      'assets/image/logo/LOGO_BLUE_1.png',
                      width: 300,
                    )),
                    const SizedBox(height: 105),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: Username,
                        decoration: InputDecoration(
                          hintText: "Username",
                          alignLabelWithHint: true,
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Username is required!';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          value.trim().toLowerCase();
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: Password,
                        decoration: InputDecoration(
                          hintText: "Password",
                          alignLabelWithHint: true,
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is required!';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          value.trim().toLowerCase();
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 58, 164, 250),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: const Text(
                            "Sign In",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            //validate
                            if (_formKey.currentState!.validate()) {
                              submitLogin();
                            }
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const ProductList()));
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            )));
  }
}
