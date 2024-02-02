/*import 'package:flutter/material.dart';

import '../class/product.dart';

class ProductsContainer extends StatelessWidget {
  final List<Product>? products;

  ProductsContainer({this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: products!.take(2).map((item) {
            return ProductItem(item: item);
          }).toList(),
        ),
        Text(
          "Çubuk",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        Wrap(
          alignment: WrapAlignment.start,
          children: products!.skip(2).map((item) {
            return ProductItem(item: item);
          }).toList(),
        ),
      ],
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product item;
  final Function(Product)? addItemToCart;

  ProductItem({required this.item, this.addItemToCart});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "ProductDetails", arguments: {"product": item});
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.285,
        margin: EdgeInsets.only(top: 12, left: 12, bottom: 10),
        height: MediaQuery.of(context).size.height * 0.25,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              item.image,
              width: MediaQuery.of(context).size.width * 0.285,
              height: MediaQuery.of(context).size.width * 0.285,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "\u20BA${item.fiyat}",
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  "\u20BA${item.fiyatIndirimli}",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Text(
              item.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            Text(
              item.miktar,
              style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Positioned(
              top: -10,
              right: -10,
              child: GestureDetector(
                onTap: () {
                  addItemToCart!(item);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey, width: 0.3),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        size: 22,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  width: 30,
                  height: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/