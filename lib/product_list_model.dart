import 'package:flutter/cupertino.dart';
import 'package:invoice_generate/model/product_detail_model.dart';

class ProductListModel with ChangeNotifier {
  List<ProductDetail> productList = [];

  void addProduct(ProductDetail product) {
    productList.add(product);

    notifyListeners();
  }

  void removeProduct(int index) {
    productList.removeAt(index);
    notifyListeners();
  }
}
