import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shopping/Static%20Methods/values/colors.dart';
import 'package:shopping/Static%20Methods/values/dimens.dart';
import 'package:shopping/Static%20Methods/values/styles.dart';

class ProductDetails extends StatefulWidget {
  final List<dynamic> images;
  final int index;

  const ProductDetails({super.key, required this.images, required this.index});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int _currentIndex = 0;
  var alldata;
  List img = [];

  @override
  Widget build(BuildContext context) {
    setState(() {
      // print(widget.images);
      alldata = widget.images[0];
      // print(widget.images[widget.index]);
      // int id = alldata[widget.index]['id'];
      // print(widget.index);
      img = alldata[widget.index]['images'];
      // print(img.length);

      // print(img[1]);
      // print(alldata[widget.index]['images']);
    });

    return Scaffold(backgroundColor: Clr().iconColor,
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
      body: Padding(
        padding: EdgeInsets.all(Dim().d16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider.builder(
                itemCount: img.length,
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(img[index]),
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  height: 200.0,
                  enlargeCenterPage: true,
                  autoPlay: false,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 1.0,
                ),
              ),
              SizedBox(
                height: Dim().d6,
              ),
              DotsIndicator(decorator: DotsDecorator(size: Size(Dim().d6, Dim().d6),activeSize:Size(Dim().d6, Dim().d6)),
                dotsCount: img.length,
                position: _currentIndex.toDouble(),
              ),
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    Text(alldata[widget.index]['title'],
                        style: Sty()
                            .largeText
                            .copyWith(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      alldata[widget.index]['description'],
                      style:
                          Sty().largeText.copyWith(fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: Dim().d12,
                    ),
                    Row(
                      children: [
                        Text('Rs.${alldata[widget.index]['price'].toString()}'),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${alldata[widget.index]['discountPercentage']}%',
                          style: Sty().mediumBoldText,
                        )
                      ],
                    ),
                    SizedBox(height: Dim().d8,),
                    Container(padding: EdgeInsets.all(Dim().d2),
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(2),
                        color: Clr().green,
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${alldata[widget.index]['rating'].toString()}',
                              style: Sty().smallText.copyWith(color: Clr().white),),
                          Icon(Icons.star,color: Clr().white,size: 12,)
                        ],
                      ),
                    ),
                    SizedBox(height: Dim().d8,),
                    Text('About Brand ${alldata[widget.index]['brand']}',)
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget cSlider(context, index) {
    return Column(children: [
      SizedBox(
        height: 4,
      ),
      Center(
          child: Text(alldata[index]['title'],
              style: Sty().microText.copyWith(fontWeight: FontWeight.bold))),
      SizedBox(
        height: 10,
      ),
      Text(
        alldata[index]['description'],
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: Sty().smallText.copyWith(fontSize: 13),
      ),
      SizedBox(
        height: 4,
      ),
      Row(
        children: [
          Text('Rs.${alldata[index]['price'].toString()}'),
          SizedBox(
            width: 10,
          ),
          Text(
            '${alldata[index]['discountPercentage']}%',
            style: Sty().mediumBoldText,
          )
        ],
      )
    ]);
  }
}
