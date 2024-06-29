import 'package:flutter/material.dart';
import 'package:shopping/productlist.dart';
Future<void> main() async {

  await Future.delayed(const Duration(seconds: 3));
  runApp(
    MaterialApp(
      // builder: (context,child){
      //   return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), child: child!);
      // },
      debugShowCheckedModeBanner: false,
      home:  ProductList(),
    ),
  );
}