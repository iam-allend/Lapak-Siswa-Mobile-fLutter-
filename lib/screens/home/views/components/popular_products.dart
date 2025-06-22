import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/components/product/product_card.dart';
import 'package:shop/constants.dart';
import 'package:shop/models/product_siswa_model.dart';
import 'package:shop/route/screen_export.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({super.key});

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  List<ProductSiswaModel> products = [];

  @override
  void initState() {
    super.initState();
    fetchProductSiswa();
  }

Future<void> fetchProductSiswa() async {
  final response = await http.get(Uri.parse("https://allend.site/lapak-siswa/API/get_products_siswa.php"));
  if (response.statusCode == 200) {
    final jsonBody = json.decode(response.body);
    if (jsonBody["success"] == true) {
      final List list = jsonBody["products"];

      // 🔽 Tambahkan ini untuk debug URL gambar
      for (var e in list) {
        print("Gambar URL: ${e['url']}");
      }

      setState(() {
        products = list.map((e) => ProductSiswaModel.fromJson(e)).toList();
      });
    } else {
      print("API response success=false");
    }
  } else {
    print("HTTP Error: ${response.statusCode}");
  }
}


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Produk Siswa",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        SizedBox(
          height: 220,
          child: products.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length, 
                  itemBuilder: (context, index) {
                    final item = products[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        left: defaultPadding,
                        right: index == products.length - 1 ? defaultPadding : 0,
                      ),
                      child: ProductCard(
                              image: item.image,
                              brandName: item.brandName,
                              title: item.title,
                              price: item.price,
                              priceAfetDiscount: item.priceAfetDiscount,
                              dicountpercent: item.dicountpercent,
                              press: () {
                                Navigator.pushNamed(
                                  context,
                                  productDetailsScreenRoute,
                                  arguments: item,
                                );

                              },
                            ),


                    );
                  },
                ),
        ),
      ],
    );
  }
}
