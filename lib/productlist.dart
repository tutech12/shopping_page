import 'package:flutter/material.dart';
import 'package:shopping/Static%20Methods/values/colors.dart';
import 'package:shopping/Static%20Methods/values/dimens.dart';
import 'package:shopping/Static%20Methods/values/styles.dart';
import 'package:shopping/api_call.dart';
import 'package:shopping/productdetails.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<dynamic> productList = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
  }

  void getProducts() async {
    var result = await ApiCall().fetchAPI();

    setState(() {
      productList = result['products'];

    });
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: Sty().largeText.copyWith(color: Clr().white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.shopping_cart,
            ),
          )
        ],
        centerTitle: true,
        leading: DrawerButtonIcon(),
        backgroundColor: Clr().primaryColor,
        elevation: 0,
      ),
      body: GridView.builder(padding: EdgeInsets.all(Dim().d16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: screenheight*0.32
        ),
        itemCount: productList.length,
        itemBuilder: (context, index) {
         // print(productList[index]['id']);
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(images: [productList],index: index) ,));
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Image.network(
                    productList[index]['thumbnail'],
                    height: screenheight*0.15,
                    width: screenwidth*0.30,
                  ),
                  SizedBox(height: 4,),
                  Center(child: Text(productList[index]['title'],style: Sty().microText.copyWith(fontWeight: FontWeight.bold))),
                  SizedBox(height: 10,),
                  Text(
                    productList[index]['description'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Sty().smallText.copyWith(fontSize: 13),
                  ),
                  SizedBox(height: 4,),
                  Row(children: [Text('Rs.${productList[index]['price'].toString()}'),
                  SizedBox(width: 10,),
                  Text('${productList[index]['discountPercentage']}%',style: Sty().mediumBoldText,)],)
                ]),
              ),
            ),
          );
        },
      ),
      backgroundColor: Clr().iconColor,
    );
  }
}
