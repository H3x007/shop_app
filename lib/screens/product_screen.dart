import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/bloc_cubit/home_cubit/cubit.dart';
import 'package:shop_app/shared/bloc_cubit/home_cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/widgets/home_item.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is SuccessChangeFavoritesShopState){
          if(!state.changeFavoritesModel.status!){
            showToast(msg: state.changeFavoritesModel.message!, state: ToastStates.ERORR);
          }else{
            showToast(msg: state.changeFavoritesModel.message!, state: ToastStates.SUCCESS);
          }
        }else if(state is SuccessChangeCartShopState){
          if(!state.changeCartModel.status!){
            showToast(msg: state.changeCartModel.message!, state: ToastStates.ERORR);
          }else{
            showToast(msg: state.changeCartModel.message!, state: ToastStates.SUCCESS);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
          builder: (context) => HomeItem(homeModel: ShopCubit.get(context).homeModel, categoriesModel: ShopCubit.get(context).categoriesModel!,),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
