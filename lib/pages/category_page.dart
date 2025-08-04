import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  final String category;

  const CategoryPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$category Services')),
      body: Center(
        child: Text("List of available $category professionals here."),
      ),
    );
  }
}
