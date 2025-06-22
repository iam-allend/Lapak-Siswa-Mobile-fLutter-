import 'package:flutter/material.dart';
import 'package:shop/constants.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil nama kategori dari arguments saat navigasi
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final selectedCategory = args?['category'] ?? "Kategori";

    // Dummy produk dari constants.dart
    final productList = [
      {
        "name": "Kotak Pensil Kayu",
        "image": productDemoImg1,
        "price": "Rp 15.000",
        "category": "Alat belajar"
      },
      {
        "name": "Bingkai Rotan",
        "image": productDemoImg2,
        "price": "Rp 25.000",
        "category": "Produk Kami"
      },
      {
        "name": "Sabun Aromaterapi",
        "image": productDemoImg3,
        "price": "Rp 12.000",
        "category": "Kecantikan"
      },
      {
        "name": "Scrub Kopi",
        "image": productDemoImg4,
        "price": "Rp 18.000",
        "category": "Kecantikan"
      },
      {
        "name": "Spons Cuci Piring Organik",
        "image": productDemoImg5,
        "price": "Rp 10.000",
        "category": "Kebersihan"
      },
      {
        "name": "Tas Rajut",
        "image": productDemoImg6,
        "price": "Rp 30.000",
        "category": "Produk Kami"
      },
      {
        "name": "Masker Wajah Alami",
        "image": productDemoImg7,
        "price": "Rp 20.000",
        "category": "Kecantikan"
      },
      {
        "name": "Sapu Ijuk",
        "image": productDemoImg8,
        "price": "Rp 22.000",
        "category": "Kebersihan"
      },
    ];

    // Filter produk berdasarkan kategori
    final filteredProducts = selectedCategory == "All Categories"
        ? productList
        : productList.where((p) => p['category'] == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Kategori: $selectedCategory"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: filteredProducts.isEmpty
            ? const Center(child: Text("Tidak ada produk di kategori ini."))
            : GridView.builder(
                itemCount: filteredProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 1.2,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.asset(
                              product['image']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product['name']!,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                            maxLines: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            product['price']!,
                            style: const TextStyle(color: Colors.green),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
