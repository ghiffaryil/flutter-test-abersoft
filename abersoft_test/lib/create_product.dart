// ignore_for_file: unused_field, non_constant_identifier_names
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  XFile? Product_Image;

  @override
  void initState() {
    super.initState();
    productName.text = "";
    productDescription.text = "";
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
                        child: Product_Image != null
                            ? Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setProductImage(
                                              context, ImageSource.camera)
                                          .then((value) {
                                        // Rebuild widget ketika foto berubah
                                        setState(() {});
                                      });
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(0),
                                      child: Image.file(
                                        File(Product_Image!.path),
                                        fit: BoxFit.fill,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                20,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    'Ketuk gambar untuk mengganti Foto',
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
                                    setProductImage(context, ImageSource.camera)
                                        .then((value) {
                                      // Rebuild widget ketika foto berubah
                                      setState(() {});
                                    });
                                  },
                                )),
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: TextFormField(
                        controller: productName,
                        decoration: InputDecoration(
                          labelText: "Name",
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
                        maxLines: 4, // Jumlah baris yang ingin ditampilkan
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Description',
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
                            //validate
                            // if (_formKey.currentState!.validate()) {
                            //send data to database with this method
                            // SubmitCreateProduct();
                            // }
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
        Product_Image = pickedImage;
      });
      // Close dialog setelah gambar terpilih
      Navigator.pop(context);
      // createReportIncident(
      //     Id_Patrol_Point_Shift_Schedule, patrol_point_Shift_Schedule_number);
    }
  }
}
