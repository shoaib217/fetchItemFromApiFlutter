import 'package:flutter/material.dart';
import 'package:http_demo/data/products.dart';
import 'package:http_demo/screen/add_new_product_screen.dart';
import 'package:http_demo/widget/product_item.dart';

// ignore: must_be_immutable
class ProductList extends StatefulWidget {
  ProductList(this.products, this.category, {super.key});
  List<Product> products;
  final Map<String, List<Product>> category;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late List<Product> tempProducts;
  late List<String> categoryList;

  @override
  void initState() {
    tempProducts = widget.products;
    categoryList = widget.category.keys.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product info"),
        elevation: 4,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              List<PopupMenuItem> listOfMenuItem = [
                PopupMenuItem(
                  child: const Text("All"),
                  onTap: () {
                    setState(() {
                      widget.products = tempProducts;
                    });
                  },
                )
              ];
              for (var categoryName in categoryList) {
                listOfMenuItem.add(PopupMenuItem(
                  child: Text(categoryName),
                  onTap: () {
                    setState(() {
                      widget.products = tempProducts
                          .where((product) => product.category == categoryName)
                          .toList();
                    });
                  },
                ));
              }
              return listOfMenuItem;
            },
          )
        ],
      ),
      body: GridView.builder(
        addAutomaticKeepAlives: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          return ProductItem(widget.products[index]);
        },
      ),
      /* floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return AddNewProduct();
            },
          ));
        },
        backgroundColor:
            Theme.of(context).buttonTheme.colorScheme?.onPrimaryContainer,
        child: Icon(
          Icons.add,
          color: Theme.of(context).buttonTheme.colorScheme?.onPrimary,
        ),
      ), */
    );
  }
}
