import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shop_app/shared/bloc_cubit/home_cubit/cubit.dart';
import 'package:shop_app/shared/bloc_cubit/home_cubit/states.dart';
import 'package:shop_app/widgets/favorites_item.dart';

import '../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context).favoritesModel!.data!.data!;
        return ConditionalBuilder(
          condition: state is! LoadingFavoritesShopState,
          builder: (context) => AnimationLimiter(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: BuildProductList(product: cubit[index].product,),
                  ),
                ),
              ),
              itemCount: cubit.length,
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}
