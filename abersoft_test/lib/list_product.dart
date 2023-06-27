import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const ScrollPhysics(),
              child: Row(
                children: [
                  Expanded(
                      child: Card(
                          child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(child: Text('AA')),
                  ))),
                  Expanded(
                      child: Card(
                          child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(child: Text('BB')),
                  ))),
                  Expanded(
                      child: Card(
                          child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(child: Text('CC')),
                  ))),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              child: const Text('AAAAA'),
            ),
          ))
        ],
      ),
    );
  }
}
