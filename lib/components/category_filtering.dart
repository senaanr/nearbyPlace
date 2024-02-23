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
import 'package:get/get.dart';
import '../class/product.dart';
import '../class/themes.dart';
import '../screens/category_filter_screen.dart';
import '../screens/restaurant_list.dart';
import 'CategoryItem.dart';
import 'CategoriesGetir.dart';

class CategoryFiltering extends StatelessWidget {
  final CategoriesGetir categoriesGetir = CategoriesGetir();

  @override
  Widget build(BuildContext context) {
    final List<Category> categories = categoriesGetir.getCategories();

    return MaterialApp(
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_outlined, color: Colors.red),
                iconSize: 23,
          onPressed: () => Navigator.of(context).pop(),
                ),
              SizedBox(width: 2),
              Expanded(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 16.0,
                  ),
                  child: HomeSearchBar(),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Theme.of(context).brightness == Brightness.light
                  ? AssetImage('assets/image/road3.jpg')
                  : AssetImage('assets/image/road2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'İlginizi_Çekebilecek_Ürünler'.tr,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildProductCategoryBox(context, 'pizza'.tr),
                      _buildProductCategoryBox(context, 'burger'.tr),
                      _buildProductCategoryBox(context, 'dominos'.tr),
                      _buildProductCategoryBox(context, 'çorba'.tr),
                      _buildProductCategoryBox(context, 'lahmacun'.tr),
                      _buildProductCategoryBox(context, 'döner'.tr),
                      _buildProductCategoryBox(context, 'tatlı'.tr),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'kategoriler'.tr,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCategoryBox(BuildContext context, String categoryName) {
    return GestureDetector(
        onTap: () {
          if (categoryName != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RestaurantListScreen(categoryName: categoryName!),
              ),
            );
          }
        },
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.black,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            categoryName,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
        ),
      ),
    );
  }
}
