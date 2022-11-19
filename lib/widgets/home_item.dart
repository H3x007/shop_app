import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/styles/styles.dart';
import 'package:shop_app/widgets/categories_item.dart';
import 'package:shop_app/widgets/product_item.dart';

class HomeItem extends StatelessWidget {
  HomeItem({Key? key, required this.homeModel, required this.categoriesModel})
      : super(key: key);
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, left: 12, right: 20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.grey,
                  spreadRadius: 1,
                  offset: Offset(1, 1),
                ),
              ],
            ),
            child: Card(
              elevation: 10,
              child: CarouselSlider(
                items: homeModel!.data!.banners
                    .map(
                      (e) => CachedNetworkImage(
                        imageUrl: e.image,
                        fit: BoxFit.fill,
                        width: double.infinity,
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ).toList(),
                options: CarouselOptions(
                    height: 200,
                    initialPage: 0,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 4),
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              'Categories',
              style: subHeadingStyle,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => CategoriesItem(
                dataModel: categoriesModel!.data!.data[index],
              ),
              itemCount: categoriesModel!.data!.data.length,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              'Recently Product',
              style: subHeadingStyle,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 0.7 / 1.2,
            physics: NeverScrollableScrollPhysics(),
            children: List.generate(
                homeModel!.data!.products.length,
                (index) => ProductItem(
                    productsModel: homeModel!.data!.products[index])),
          ),
        ],
      ),
    );
  }
}
