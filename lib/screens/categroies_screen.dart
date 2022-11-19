import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/bloc_cubit/home_cubit/cubit.dart';
import 'package:shop_app/shared/bloc_cubit/home_cubit/states.dart';
import 'package:shop_app/shared/styles/styles.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context).categoriesModel!.data!.data;
        return Column(
          children: [
            Expanded(
              child: AnimationLimiter(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
                    position: index,
                    duration: Duration(seconds: 1),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      duration: Duration(seconds: 3),
                      child: FadeInAnimation(
                        child: buildCatItem(cubit[index]),
                      ),
                    ),
                  ),
                  itemCount: cubit.length,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildCatItem(DataModel dataModel) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(1, 1)
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(1, 1)
                      ),
                    ],
                  ),
                  child: CachedNetworkImage(
                    imageUrl: dataModel.image!,
                    fit: BoxFit.fill,
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 20,
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                color: Colors.black.withOpacity(0.4),
                child: Text(
                  dataModel.name!.toUpperCase(),
                  style: subHeadingStyle.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
}
