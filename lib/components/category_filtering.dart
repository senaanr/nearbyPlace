/*import 'package:flutter/material.dart';

class CategoryItem {
  final String categoryName;

  CategoryItem({required this.categoryName});
}

final List<CategoryItem> categoriesGetir = [
  CategoryItem(categoryName: 'Category1'),
  CategoryItem(categoryName: 'Category2'),
  // Add more categories as needed
];

class CategoryBox extends StatelessWidget {
  final String active;
  final String item;

  CategoryBox({required this.active, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: item == active ? Colors.yellow : Colors.transparent,
            width: 2.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item,
            style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class CategoryFiltering extends StatelessWidget {
  final String category;

  CategoryFiltering({required this.category});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.065,
        width: double.infinity,
        color: Colors.blueAccent, // Adjust color accordingly
        child: Row(
          children: categoriesGetir.map((item) {
            return CategoryBox(active: category, item: item.categoryName);
          }).toList(),
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import '../class/product.dart';
import 'CategoryItem.dart';
import 'CategoriesGetir.dart';

class CategoryFiltering extends StatelessWidget {
  final CategoriesGetir categoriesGetir = CategoriesGetir();

  @override
  Widget build(BuildContext context) {
    final List<Category> categories = categoriesGetir.getCategories();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 1.0,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            Category category = categories[index];
            return CategoryItem(
              categoryName: category.name,
              imageUrl: category.src,
            );
          },
        ),
      ),
    );
  }
}
