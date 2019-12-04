import 'package:flutter/material.dart';

import 'package:real_braille/Pages/CategoriesPage.dart';
import 'package:real_braille/Pages/CreateCategoryPage.dart';

class CategoryHomePage extends StatefulWidget {
  CategoryHomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CategoryHomePageState();
  }
}

class _CategoryHomePageState extends State<CategoryHomePage> {
  PageController pageController;

  @override
  void initState() {
    pageController  = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Categorys!"),
      ),
      body: PageView(
        controller: pageController,
        children: <Widget>[
          CategoriesPage(pageController: pageController,),
          CreateCategoryPage(),
        ],
      ),
    );
  }
}
