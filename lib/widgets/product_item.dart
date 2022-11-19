import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/bloc_cubit/home_cubit/cubit.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/shared/styles/styles.dart';

class ProductItem extends StatelessWidget {
  ProductItem({Key? key, required this.productsModel}) : super(key: key);
  ProductsModel? productsModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Container(
            width: 200,
            decoration: BoxDecoration(),
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 10,
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: EdgeInsets.only(
                  bottom: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                          Image(
                            image: NetworkImage('${productsModel!.image}'),
                            width: 180,
                            height: 150,
                            fit: BoxFit.fill,
                          ),
                        if (productsModel!.discount != 0)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
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
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      '${productsModel!.name}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: titleStyle,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          '\$${productsModel!.price.round()}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: priceStyle,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        if (productsModel!.discount != 0)
                          Expanded(
                            child: Text(
                              '\$${productsModel!.old_price.round()}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ),
                        //Spacer(),

                      ],
                    ),
                    Row(
                      children: [
                        /// Add Product To Favorites
                        IconButton(
                          onPressed: () {
                            //print(productsModel!.id);
                            ShopCubit.get(context).changeFavorites(productsModel!.id);
                          },
                          icon: CircleAvatar(
                            radius: 16,
                            backgroundColor: ShopCubit.get(context).favorites[productsModel!.id]! ? defaultColor: Colors.grey,
                            child: Icon(Icons.favorite_border, color: Colors.white,size: 16,),
                          ),
                        ),
                        Spacer(),
                        /// Add Product To Cart
                        IconButton(
                          onPressed: () {
                            //print(productsModel!.id);
                            ShopCubit.get(context).changeCart(productsModel!.id);
                          },
                          icon: CircleAvatar(
                            radius: 16,
                            //ShopCubit.get(context).favorites[productsModel!.id]! ? defaultColor: Colors.grey
                            backgroundColor: ShopCubit.get(context).cart[productsModel!.id]! ? defaultColor : Colors.grey,
                            child: Icon(EvaIcons.shoppingCart, color: Colors.white,size: 18,),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
