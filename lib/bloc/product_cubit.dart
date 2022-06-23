import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:storeapp/bloc/product_states.dart';
import 'package:storeapp/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductStates> {
  Dio dio = Dio();
  ProductCubit() : super(InitialStete()) {
    getAllProducts();
  }
  List<ProductModel> products = [];
  static ProductCubit get(BuildContext context) => BlocProvider.of(context);
  getAllProducts() async {
    products = [];
    if (products.isEmpty) {
      var response = await dio.get("https://fakestoreapi.com/products");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        for (var element in data) {
          ProductModel pm = ProductModel.fromJson(element);
          products.add(pm);
        }
        emit(GetProducts());
      }
    }
  }

  getProductsByCategory(String category) async {
    products = [];
    if (category == "all") {
      getAllProducts();
    } else {
      try {
        var response = await dio
            .get("https://fakestoreapi.com/products/category/$category");
        if (response.statusCode == 200) {
          List<dynamic> data = response.data;
          for (var element in data) {
            ProductModel pm = ProductModel.fromJson(element);
            products.add(pm);
          }
          emit(GetProducts());
        }
      } on DioError catch (q) {
        return (q);
      }
    }
  }
}
