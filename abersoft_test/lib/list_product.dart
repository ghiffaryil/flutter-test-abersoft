// ignore_for_file: avoid_unnecessary_containers
import 'package:abersoft_test/create_product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<Map<String, dynamic>> productList = [
    {
      'name': 'Produk 1',
      'price': 10.0,
      'category': 'Kategori 1',
    },
    {
      'name': 'Produk 2',
      'price': 20.0,
      'category': 'Kategori 2',
    },
    {
      'name': 'Produk 3',
      'price': 30.0,
      'category': 'Kategori 1',
    },
    {
      'name': 'Produk 4',
      'price': 40.0,
      'category': 'Kategori 2',
    },
    {
      'name': 'Produk 5',
      'price': 50.0,
      'category': 'Kategori 1',
    },
    {
      'name': 'Produk 6',
      'price': 50.0,
      'category': 'Kategori 6',
    },
  ];

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
                  Text(
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
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    final product = productList[index];
                    return Card(
                      child: Container(
                        width: 200.0,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product['name'] ?? 'No Name'),
                            const SizedBox(height: 8.0),
                            Text('${product['price']}'),
                            const SizedBox(height: 8.0),
                            Text('${product['category']}'),
                          ],
                        ),
                      ),
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
                      itemCount: productList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemBuilder: (context, index) {
                        final products = productList[index];
                        return Card(
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(products['name']),
                                const SizedBox(height: 8.0),
                                Text(
                                    'Harga: \$${products['price'].toStringAsFixed(2)}'),
                                const SizedBox(height: 8.0),
                                Text('Kategori: ${products['category']}'),
                              ],
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
