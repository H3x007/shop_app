import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/screens/login_screen.dart';
import 'package:shop_app/shared/network/helper/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../bloc_cubit/home_cubit/cubit.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateToAndClose(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

void submit(context) {
  CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
    if (value) {
      navigateToAndClose(
        context,
        LoginScreen(),
      );
    }
  });
}


void showToast({required String msg, required ToastStates state}) => Fluttertoast.showToast(
  msg: msg,
  backgroundColor: chooseToastColor(state),
  toastLength: Toast.LENGTH_LONG,
);

enum ToastStates {SUCCESS, ERORR, WARNING}

Color? chooseToastColor(ToastStates state){

  Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERORR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.orange;
      break;
  }
  return color;
}


Widget buildListProduct(product, context, {isOldPrice = true,}) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  height: 170,
  decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16)
  ),
  child: Card(
    elevation: 10,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Colors.white, width: 1),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image(
              image: NetworkImage(
                  '${product.image}'),
              width: 120,
              height: 130,
              fit: BoxFit.fill,
            ),
            if (product.discount != 0 && isOldPrice)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.red),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10,right: 10),
            child: Column(
              children: [
                Text(
                  '${product.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16, height: 1.4),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '\$${product.price}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    if (product.discount != 0 && isOldPrice)
                      Expanded(
                        child: Text(
                          '\$${product.oldPrice}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ),
                  ],
                ),
                Row(
                  children: [
                    /// Add Product To Favorites
                    IconButton(
                      onPressed: () {
                        //print(productsModel!.id);
                        ShopCubit.get(context).changeFavorites(product.id);
                      },
                      icon: CircleAvatar(
                        radius: 16,
                        backgroundColor: ShopCubit.get(context).favorites[product!.id]! ? defaultColor: Colors.grey,
                        child: Icon(Icons.favorite_border, color: Colors.white,size: 16,),
                      ),
                    ),
                    Spacer(),
                    /// Add Product To Cart
                    IconButton(
                      onPressed: () {
                        //print(productsModel!.id);
                        ShopCubit.get(context).changeCart(product.id);
                      },
                      icon: CircleAvatar(
                        radius: 16,
                        //ShopCubit.get(context).favorites[productsModel!.id]! ? defaultColor: Colors.grey
                        backgroundColor: ShopCubit.get(context).cart[product.id]! ? defaultColor : Colors.grey,
                        child: Icon(EvaIcons.shoppingCart, color: Colors.white,size: 18,),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);