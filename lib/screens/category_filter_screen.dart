import 'package:flutter/material.dart';
import 'package:myapp/components/category_filtering.dart';

class CategoryFilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_outlined, color: Colors.red),
                iconSize:23,
                onPressed: () => Navigator.of(context).pop(),
              ),
              SizedBox(width: 2), // İstedğiniz kadar boşluk ekleyebilirsiniz
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
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
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
                height: 70, // Ayarlanabilir yükseklik
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildProductCategoryBox('pizza'),
                    _buildProductCategoryBox('burger'),
                    _buildProductCategoryBox('dominos'),
                    _buildProductCategoryBox('çorba'),
                    _buildProductCategoryBox('lahmacun'),
                    _buildProductCategoryBox('döner'),
                    _buildProductCategoryBox('tatlı'),
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
              ),
              Expanded(
                child: CategoryFiltering(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductCategoryBox(String categoryName) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
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
      child: Center(
        child: Text(
          categoryName,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
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
                hintText: 'Bugün ne yesem...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search button press
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoryFilterScreen()),
              );*/
            },
          ),
        ],
      ),
    );
  }
}
