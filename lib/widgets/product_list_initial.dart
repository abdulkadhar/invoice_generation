import 'package:flutter/material.dart';
import 'package:invoice_generate/model/product_detail_model.dart';
import 'package:invoice_generate/product_list_model.dart';
import 'package:invoice_generate/widgets/product_list.dart';
import 'package:provider/provider.dart';

class ProductListHolder extends StatelessWidget {
  final String title;
  const ProductListHolder({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
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
            child: Text(
              "Add Product",
              style: TextStyle(
                color: Colors.grey.shade400,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ProductList()
        ],
      ),
    );
  }
}
