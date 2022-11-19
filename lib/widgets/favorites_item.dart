import 'package:flutter/material.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/shared/bloc_cubit/home_cubit/cubit.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/shared/styles/styles.dart';

class BuildProductList extends StatelessWidget {
  BuildProductList({Key? key, required this.product}) : super(key: key);
  //FavoritesData? favoritesData;
  Product? product;
  @override
  Widget build(BuildContext context) {
    return Container(
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
                      '${product!.image}'),
                  width: 120,
                  height: 130,
                  fit: BoxFit.fill,
                ),
                if (product!.discount != 0)
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
                      '${product!.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: titleStyle,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '\$${product!.price}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        if (product!.discount != 0)
                          Text(
                            '\$${product!.oldPrice}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavorites(product!.id!);
                          },
                          icon: CircleAvatar(
                            radius: 16,
                            backgroundColor: ShopCubit.get(context).favorites[product!.id]! ? defaultColor : Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 16,
                            ),
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
  }
}
