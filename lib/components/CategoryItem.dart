import 'package:flutter/material.dart';

import '../screens/restaurant_list.dart';

class CategoryItem extends StatelessWidget {
  final String? categoryName;
  final String? imageUrl;

  const CategoryItem({Key? key, this.categoryName, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        width: MediaQuery.of(context).size.width * 0.22, // Adjust the width as needed
        margin: const EdgeInsets.only(top: 5, right: 8.0), // Adjust margins as needed
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl ?? 'https://example.com/placeholder.jpg', // Varsayılan veya placeholder URL'i
                width: MediaQuery.of(context).size.width * 0.18,
                height: MediaQuery.of(context).size.width * 0.18,
                fit: BoxFit.cover,
              ),
            ),
            if (categoryName != null)
              Padding(
                padding: const EdgeInsets.only(top: 4.0), // Adjust top padding as needed
                child: Text(
                  categoryName!,
                  style: TextStyle(
                    fontSize: 12,
                    color:Theme.of(context).textTheme.titleLarge?.color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
