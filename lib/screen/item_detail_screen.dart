import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http_demo/data/products.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen(this.product, {super.key});
  final Product product;

  Widget _myText(BuildContext ctx, label, value) {
    return Column(
      children: [
        Text(
          "$label - $value",
          style: Theme.of(ctx).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 4,
        )
      ],
    );
  }

  Future<void> openImages(BuildContext context, String url) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        var initialIndex = product.images.indexWhere(
          (element) {
            return element == url;
          },
        );
        return Dialog(
          backgroundColor: Colors.transparent,
          child: CarouselSlider(
            options: CarouselOptions(
              initialPage: initialIndex,
              height: MediaQuery.of(context).size.height / 2.5,
            ),
            items: product.images
                .map((url) => Container(
                      margin: const EdgeInsets.all(8),
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                      ),
                    ))
                .toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(enableInfiniteScroll: false),
              items: product.images
                  .map((url) => GestureDetector(
                        onTap: () => openImages(context, url),
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          child: Image.network(url),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(
              height: 12,
            ),
            _myText(context, "Category", product.category),
            _myText(context, "Brand", product.brand),
            _myText(context, "Price", "\$${product.price}"),
            _myText(context, "Details", product.description),
            Row(
              children: [
                _myText(context, "Rating", ""),
                RatingBarIndicator(
                  rating: product.rating,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 25,
                  direction: Axis.horizontal,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
