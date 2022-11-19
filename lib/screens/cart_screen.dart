import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shop_app/shared/bloc_cubit/home_cubit/cubit.dart';
import 'package:shop_app/shared/bloc_cubit/home_cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/styles.dart';
import 'package:shop_app/widgets/favorites_item.dart';
import 'package:shop_app/widgets/my_button.dart';

import '../shared/styles/colors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context).cartModel!.data!.cartItems!;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).cartModel!.data!.total > 0,
          builder: (context) => Column(
            children: [
              Expanded(
                child: ConditionalBuilder(
                    condition: state is! LoadingCartShopState,
                    builder: (context) => AnimationLimiter(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: buildListProduct(
                                      cubit[index].product, context),
                                ),
                              ),
                            ),
                            itemCount: cubit.length,
                          ),
                        ),
                    fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        )),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                //height: 100,
                width: double.infinity,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Subtotal:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.grey),
                        ),
                        Text(
                          "\$${ShopCubit.get(context).cartModel!.data!.subTotal} ",
                          style: priceStyle.copyWith(color: defaultColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total:",
                          style: subTitleStyle.copyWith(color: Colors.grey),
                        ),
                        Text(
                          "\$${ShopCubit.get(context).cartModel!.data!.total} ",
                          style: priceStyle.copyWith(color: defaultColor)
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    MyButton(
                      text: 'GO TO CHECKOUT',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
          fallback: (context) => Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Icon(
                    Icons.shopping_cart,
                    size: 200,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  'Your cart is empty ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

//(context) => Center(child: CircularProgressIndicator(),)
