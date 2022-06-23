import 'package:flutter/material.dart';
import 'package:storeapp/bloc/product_cubit.dart';
import 'package:storeapp/bloc/product_states.dart';
import 'package:storeapp/screens/product_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Map<String, String> categories = {
  "All": "all",
  "Electronics": "electronics",
  "Jewelery": "jewelery",
  "Men's clothing": "men's clothing",
  "Women's clothing": "women's clothing"
};
List<String> userCategories = categories.keys.toList();

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var cubit = ProductCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .1,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) => Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: ElevatedButton(
                    onPressed: () {
                      cubit.getProductsByCategory(
                          categories[userCategories[index]]!);
                    },
                    child: Text(userCategories[index])),
              ),
            ),
          ),
          BlocConsumer<ProductCubit, ProductStates>(
            listener: (context, state) {},
            builder: (context, state) => SizedBox(
              height: MediaQuery.of(context).size.height * .75,
              child: ListView.builder(
                  itemCount: cubit.products.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetails(
                                      product: cubit.products[index]),
                                ));
                          },
                          child: Card(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.network(
                                      "${cubit.products[index].image}"),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: 230,
                                        child: Text(
                                          "${cubit.products[index].title}",
                                          style: const TextStyle(fontSize: 17),
                                          maxLines: 1,
                                        )),
                                    RatingBar.builder(
                                      initialRating:
                                          cubit.products[index].rate as double,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 12,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 2.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {},
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.remove_red_eye,
                                          size: 15,
                                        ),
                                        Text("${cubit.products[index].count}")
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
