import 'package:flutter/material.dart';
import 'package:storeapp/models/product_model.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel product;
  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Image.network(widget.product.image!),
            ),
            Text(widget.product.description!),
            Text("Price : ${widget.product.price}")
          ],
        ),
      ),
    );
  }
}
