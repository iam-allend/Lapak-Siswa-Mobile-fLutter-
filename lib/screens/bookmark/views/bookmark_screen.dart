import 'package:flutter/material.dart';
import 'package:shop/constants.dart';
import 'package:shop/helpers/user_session.dart';
import 'package:shop/models/product_siswa_model.dart';
import 'package:shop/route/route_constants.dart';
import 'package:shop/service/bookmark_service.dart';
import 'package:shop/components/product/product_card.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  List<ProductSiswaModel> bookmarkedProducts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadBookmarks();
  }

Future<void> loadBookmarks() async {
  final user = await UserSession.getLoggedInUser();
  if (user == null) return;

  final bookmarks = await BookmarkService.getBookmarks(user.id);

  print("=== Bookmarks (${bookmarks.length}) ===");
  for (final p in bookmarks) {
    print("ID: ${p.idProduct}, Nama: ${p.title}, Gambar: ${p.image}");
  }

  setState(() {
    bookmarkedProducts = bookmarks;
    isLoading = false;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bookmark")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : bookmarkedProducts.isEmpty
              ? const Center(child: Text("Belum ada produk di bookmark."))
              : Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: GridView.builder(
                    itemCount: bookmarkedProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisSpacing: defaultPadding,
                      crossAxisSpacing: defaultPadding,
                      childAspectRatio: 0.66,
                    ),
                    itemBuilder: (context, index) {
                      final product = bookmarkedProducts[index];
                      return ProductCard(
                        image: product.image2,
                        brandName: product.brandName,
                        title: product.title,
                        price: product.price,
                        priceAfetDiscount: product.priceAfetDiscount,
                        dicountpercent: product.discount,
                        press: () {
                          Navigator.pushNamed(
                            context,
                            productDetailsScreenRoute,
                            arguments: product,
                          );
                        },
                      );
                    },
                  ),
                ),
    );
  }
}
