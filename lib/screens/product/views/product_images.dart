import 'package:flutter/material.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({super.key, required this.images});
  final List<String> images;

  @override
  State<ProductImages> createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.15,
            child: PageView.builder(
              itemCount: widget.images.length,
              onPageChanged: (index) {
                setState(() {
                  selectedImage = index;
                });
              },
              itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  widget.images[index],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.images.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 6,
                width: selectedImage == index ? 14 : 6,
                decoration: BoxDecoration(
                  color: selectedImage == index ? Colors.black : Colors.grey,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
