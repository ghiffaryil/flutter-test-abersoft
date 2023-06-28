// ignore_for_file: unused_field, non_constant_identifier_names, unused_import, avoid_print
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'list_product.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({Key? key}) : super(key: key);

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  final _formKey = GlobalKey<FormState>();
  var productName = TextEditingController();
  var productDescription = TextEditingController();
  final ImagePicker picker = ImagePicker();
  XFile? productImage;

  @override
  void initState() {
    super.initState();
    productName.text = "";
    productDescription.text = "";
  }

  void submitCreateProduct() async {
    const String urlapi =
        'https://2e3d13cc-3d6d-4911-b94c-ba23cf332933.mock.pstmn.io/api/v1/products';

    var headers = {'Content-Type': 'application/json'};

    Uint8List productImage_imagebytes = await productImage!.readAsBytes();
    // ignore: unused_local_variable
    String productImage_base64string =
        "data:image/jpeg;base64,${base64.encode(productImage_imagebytes)}";

    var body = json.encode({
      "productName": productName.text,
      "productDescription": productDescription.text,
      "productImage": productImage_base64string,
    });

    http.Response response = await http.post(
      Uri.parse(urlapi),
      headers: headers,
      body: body,
    );

    print('Create Response Status Code => ${response.statusCode}');

    var responseJson = jsonDecode(response.body);

    print('Create Response Body =>${response.body}');

    var newidProduct = responseJson['id'];
    var newNameProduct = responseJson['name'];
    var newDescriptionProduct = responseJson['name'];

    print(
        'newidProduct $newidProduct, newNameProduct $newNameProduct, newDescriptionProduct $newDescriptionProduct');

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Product Created'),
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
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Oops'),
            content: const Text('Upload Failed'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
        barrierDismissible: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Create Product',
            style: TextStyle(
                fontSize: 23, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
            padding: const EdgeInsets.all(15.0),
            alignment: Alignment.center,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Container(
                        child: productImage != null
                            ? Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setProductImage(
                                              context, ImageSource.gallery)
                                          .then((value) {
                                        setState(() {});
                                      });
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(0),
                                      child: Image.file(
                                        File(productImage!.path),
                                        fit: BoxFit.fill,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                20,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    'Tap image to change',
                                    style: TextStyle(fontSize: 13),
                                  )
                                ],
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                margin: const EdgeInsets.only(top: 5.0),
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: Colors.lightBlueAccent,
                                  ),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.lightBlueAccent,
                                    size: 30,
                                  ),
                                  tooltip: 'Pilih Foto',
                                  onPressed: () {
                                    setProductImage(
                                            context, ImageSource.gallery)
                                        .then((value) {
                                      // Rebuild widget ketika foto berubah
                                      setState(() {});
                                    });
                                  },
                                )),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: TextFormField(
                        controller: productName,
                        decoration: InputDecoration(
                          labelText: "Product Name",
                          hintText: 'Product Name',
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required Product name!';
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
                        controller: productDescription,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: 'Product Description',
                          hintText: 'Product Description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Center(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 106, 187, 253),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: const Text(
                            "Upload",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            submitCreateProduct();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ],
            ),
          )),
        ));
  }

  // SET FOTO INCIDENT
  Future<void> setProductImage(context, ImageSource source) async {
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        productImage = pickedImage;
      });
      // Close dialog setelah gambar terpilih
      // Navigator.pop(context);
    }
  }
}
