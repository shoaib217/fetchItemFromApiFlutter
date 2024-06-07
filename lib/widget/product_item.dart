import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http_demo/data/products.dart';
import 'package:http_demo/extentions.dart';
import 'package:http_demo/screen/item_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(this.product, {super.key});
  final Product product;

  Widget _myText(BuildContext ctx, label, value) {
    return Text(
      "$label - $value",
      style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Theme.of(ctx).textTheme.titleMedium?.color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return ItemDetailScreen(product);
        },
      )),
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.secondaryContainer),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CachedNetworkImage(
                width: double.infinity,
                imageUrl: product.images[0],
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
                filterQuality: FilterQuality.low,
                fadeInDuration: const Duration(seconds: 2),
                progressIndicatorBuilder: (context, url, progress) {
                  return Center(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                    ),
                  );
                },
              ),
            ),
            if (product.brand.isNotNullOrEmpty())
              _myText(context, "Brand", product.brand),
            _myText(context, "Title", product.title),
            _myText(context, "Price", "\$${product.price}"),
          ],
        ),
      ),
    );
  }
}
