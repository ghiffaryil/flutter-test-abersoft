// ignore_for_file: non_constant_identifier_names, unused_field

import 'package:abersoft_test/list_product.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  var Username = TextEditingController();
  var Password = TextEditingController();

  @override
  void initState() {
    super.initState();
    Username.text = "";
    Password.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            child: Container(
      padding: const EdgeInsets.all(15.0),
      alignment: Alignment.center,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 125),
          Center(
              child: Image.asset(
            'assets/image/logo/LOGO_BLUE_1.png',
            width: 300,
          )),
          const SizedBox(height: 65),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: Username,
              decoration: InputDecoration(
                labelText: "Username",
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Username tidak boleh kosong!';
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
              controller: Password,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: "Password",
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 106, 187, 253),
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
                  // if (_formKey.currentState!.validate()) {
                  //send data to database with this method
                  // SubmitLogin();
                  // }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProductList()));
                },
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    )));
  }
}
