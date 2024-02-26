/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/components/category_filtering.dart';
import 'package:myapp/screens/restaurant_list.dart';

import '../class/themes.dart'; // RestaurantListScreen import edildi

class CategoryFilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        /*appBar: AppBar(
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
        ),*/
        body: Container(
          /*decoration: BoxDecoration(
            image: DecorationImage(
              image: Theme.of(context).brightness == Brightness.light
                  ? AssetImage('assets/image/road3.jpg')
                  : AssetImage('assets/image/road2.jpg'),
              fit: BoxFit.cover,
            ),
          ),*/
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /*Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'İlginizi Çekebilecek Ürünler',
                    style: TextStyle(
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
                      _buildProductCategoryBox(context,'pizza'),
                      _buildProductCategoryBox(context,'burger'),
                      _buildProductCategoryBox(context,'dominos'),
                      _buildProductCategoryBox(context,'çorba'),
                      _buildProductCategoryBox(context,'lahmacun'),
                      _buildProductCategoryBox(context,'döner'),
                      _buildProductCategoryBox(context,'tatlı'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Kategoriler',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),*/
                Expanded(
                  child: CategoryFiltering(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class HomeSearchBar extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
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
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'bugün_ne_yesem'.tr,
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search button press
            },
          ),
        ],
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/screens/search_screen.dart';
import '../class/product.dart';
import '../class/themes.dart';
import '../components/CategoriesGetir.dart';
import '../components/CategoryItem.dart';
import '../screens/category_filter_screen.dart';
import '../screens/restaurant_list.dart';

class CombinedScreen extends StatelessWidget {
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
                    maxWidth: MediaQuery
                        .of(context)
                        .size
                        .width - 16.0,
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
              image: Theme
                  .of(context)
                  .brightness == Brightness.light
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
                      // "categories" listesini isimlere göre sırala
                      categories.sort((a, b) => a.name.compareTo(b.name));

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
        try {
          if (categoryName != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    RestaurantListScreen(categoryName: categoryName),
              ),
            );
          }
        } catch (e) {
          print('Error while navigating to RestaurantListScreen: $e');
        }
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme
              .of(context)
              .brightness == Brightness.light
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
              color: Theme
                  .of(context)
                  .textTheme
                  .titleLarge
                  ?.color,
            ),
          ),
        ),
      ),
    );
  }
}

  class HomeSearchBar extends StatefulWidget {
  @override
  _HomeSearchBarState createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
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
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  onSubmitted: (value) {
                    // Navigate to the search screen with the entered search term
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(searchTerm: value),
                      ),
                    );
                  },
                  decoration: InputDecoration(
                    hintText: 'bugün_ne_yesem'.tr,
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Navigate to the search screen with the entered search term
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(searchTerm: searchController.text),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}



// Replace dummySearchResults with your actual data
List<String> dummySearchResults = [
  "burger",
  "kebap_türk_mutfağı",
  "tatlı",
  "pizza",
  "çiğ_köfte",
  "kahve",
  "tantuni",
  "waffle",
  "kokoreç",
  "tavuk",
  "kumpir",
  "deniz_ürünleri",
  "tost_sandviç",
  "ev_yemekleri",
  "kahvaltı_börek",
  "makarna",
  "mantı",
  "salata",
  "pastane_fırın",
  "pilav",
  "çorba",
];
