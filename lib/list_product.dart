// ignore_for_file: avoid_unnecessary_containers, use_build_context_synchronously, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_print, depend_on_referenced_packages
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:abersoft_test/create_product.dart';
import 'package:abersoft_test/loginInformationStore/loginInformation.dart';

import 'login_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final _LoginInformation = LoginInformation();

  var u_Username;
  var u_Password;
  var u_Token;

  List listBestProduct = [];
  List listAllProduct = [];

  // TAMPILAN
  @override
  void initState() {
    super.initState();
    refreshFunction();
  }

  //FUNGSI UNTUK REFRESH FUNGSI-FUNGSI TERTENTU
  Future refreshFunction() async {
    await getLoginInformationStore();
    await getlistBestProduct();
  }

  Future getLoginInformationStore() async {
    final LoginInformation = await _LoginInformation.readLoginInformation();
    if (LoginInformation != null) {
      setState(() {
        u_Username = LoginInformation['username'];
        u_Password = LoginInformation['password'];
        u_Token = LoginInformation['token'];
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const Login(),
        ),
      );
    }
  }

  Future getlistBestProduct() async {
    final String url =
        'https://2e3d13cc-3d6d-4911-b94c-ba23cf332933.mock.pstmn.io/api/v1/products';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $u_Token'},
      );

      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        var data = jsonDecode(response.body);

        setState(() {
          listBestProduct = data['bestProduct'];
          listAllProduct = data['allProduct'];
        });
      } else {
        // Gagal mendapatkan respons
        print('Failed to fetch products. Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Terjadi kesalahan saat melakukan permintaan HTTP
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Our Portofolio',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreateProduct()));
                    },
                    child: const Text(
                      '+',
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )),
              const SizedBox(
                height: 20,
              ),
              Container(
                  child: const Text(
                'Best Product',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listBestProduct.length,
                  itemBuilder: (context, index) {
                    final dataBestProduct = listBestProduct[index];
                    return Container(
                      padding: const EdgeInsets.all(15),
                      child: SizedBox(
                          child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          dataBestProduct['imageUrl'],
                          fit: BoxFit.cover,
                        ),
                      )),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                  child: const Text(
                'All Product',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: GridView.builder(
                      itemCount: listAllProduct.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 5.0,
                      ),
                      itemBuilder: (context, index) {
                        final dataAllProduct = listAllProduct[index];
                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                '${dataAllProduct['imageUrl']}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
