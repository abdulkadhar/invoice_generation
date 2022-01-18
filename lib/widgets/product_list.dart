import 'package:flutter/material.dart';
import 'package:invoice_generate/model/product_detail_model.dart';
import 'package:invoice_generate/product_list_model.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductListModel>(builder: (context, productListModel, _) {
      return Column(
        children: List.generate(
          productListModel.productList.length,
          (index) => ListTile(
            leading: InkWell(
              onTap: () {
                final currentProvider = Provider.of<ProductListModel>(
                  context,
                  listen: false,
                );
                currentProvider.addProduct(
                  ProductDetail(
                    description: "description",
                    quantity: 1,
                    unitPrice: 100,
                  ),
                );
              },
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.amber,
                child: Center(
                  child: Icon(
                    Icons.add,
                    size: 10,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            title: Text(
              productListModel.productList[index].description,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.amber.shade400,
              ),
            ),
            subtitle: Text(
              "Quantity: ${productListModel.productList.length}",
              style: TextStyle(
                color: Colors.green.shade400,
                fontSize: 13,
              ),
            ),
            trailing: InkWell(
              onTap: () {
                final currentProvider = Provider.of<ProductListModel>(
                  context,
                  listen: false,
                );
                currentProvider.removeProduct(index);
              },
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.amber,
                child: Center(
                  child: Icon(
                    Icons.remove,
                    size: 10,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
