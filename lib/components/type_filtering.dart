/*import 'package:flutter/material.dart';

class TypeBox extends StatelessWidget {
  final String active;
  final String item;
  final Function setCat;

  TypeBox({required this.active, required this.item, required this.setCat});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setCat(item);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.only(right: 12),
        height: MediaQuery.of(context).size.height * 0.044,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: item == active ? Colors.blue : Colors.transparent,
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Center(
          child: Text(
            item,
            style: TextStyle(
              fontSize: 12,
              color: item == active ? Colors.white : Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class TypeFiltering extends StatelessWidget {
  final String? category;
  final Function? setCategory;

  TypeFiltering({this.category, this.setCategory});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.072,
        width: double.infinity,
        color: Colors.white, // Adjust color accordingly
        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.014, horizontal: 12),
        child: Row(
          children: ["Birlikte İyi Gider", "Çubuk", "Kutu", "Külah", "Çoklu", "Bar"].map((item) {
            return TypeBox(active: category ?? "", item: item, setCat: setCategory ?? () {});
          }).toList(),
        ),
      ),
    );
  }
}
*/