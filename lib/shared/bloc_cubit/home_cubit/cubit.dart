import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_cart_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/categroies_screen.dart';
import 'package:shop_app/screens/favorites_screen.dart';
import 'package:shop_app/screens/home_screen.dart';
import 'package:shop_app/screens/product_screen.dart';
import 'package:shop_app/screens/profile_screen.dart';
import 'package:shop_app/shared/bloc_cubit/home_cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/helper/cache_helper.dart';
import 'package:shop_app/shared/network/helper/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(InitialShopState());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  List<String> titles = [
    'Jawhara Shop',
    'Categories',
    'Favorites',
    'Shopping Cart',
    'Profile',
  ];


  void changeBottom(index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  /// Change Theme Mode
  bool isDark = false;
  void changeMode({bool? fromShared}) {
    if(fromShared != null){
      isDark = fromShared ;
      emit(ChangeThemeModeState());
    }else{
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(ChangeThemeModeState());
      });
    }


  }

  /// Get HOME Data
  Map<int, bool> favorites = {};
  Map<int, bool> cart = {};
  HomeModel? homeModel;
  void getHomeData() {
    emit(LoadingHomeDataShopState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id: element.in_favorites,
        });
        cart.addAll({
          element.id: element.in_cart,
        });
      });
      //print(favorites.toString());
      //print(cartProduct.toString());
      emit(SuccessHomeDataShopState());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(ErorrHomeDataShopState());
    });
  }

  /// Get Categories
  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.formJson(value.data);
      emit(SuccessCategoriesShopState());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(ErorrCategoriesShopState());
    });
  }

  /// Change Favorites true or false
  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ChangeFavoritesShopState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (changeFavoritesModel!.status == false) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoritesData();
      }
      emit(SuccessChangeFavoritesShopState(changeFavoritesModel!));
    }).catchError((e) {
      print(e.toString());
      favorites[productId] = !favorites[productId]!;
      emit(ErorrChangeFavoritesShopState());
    });
  }

  /// Get Favorites
  FavoritesModel? favoritesModel;
  void getFavoritesData() {
    emit(LoadingFavoritesShopState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(SuccessFavoritesShopState());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(ErorrFavoritesShopState());
    });
  }

  /// Get User Data
  LoginModel? loginModel;
  void getUserData() {
    emit(LoadingProfileShopState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      loginModel = LoginModel.fromJason(value.data);
      print(loginModel!.data!.name!);
      emit(SuccessProfileShopState());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(ErorrProfileShopState());
    });
  }

  /// Update User Data
  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(LoadingUpdateProfileShopState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      loginModel = LoginModel.fromJason(value.data);
      print(loginModel!.data!.name!);
      emit(SuccessUpdateProfileShopState());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(ErorrUpdateProfileShopState());
    });
  }

  /// Add and Delete Product From Cart
  ChangeCartModel? changeCartModels;
  void changeCart(int productId) {
    cart[productId] = !cart[productId]!;
    //emit(SuccessChangeCartShopState(changeCartModels!));
    DioHelper.postData(
      url: CART,
      token: token,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      changeCartModels = ChangeCartModel.fromJson(value.data);
      print(changeCartModels!.message);
      if (changeCartModels!.status == false) {
        cart[productId] = !cart[productId]!;
      }else{
        getCartItem();
      }
      emit(SuccessChangeCartShopState(changeCartModels!));
    }).catchError((e) {
      print(e.toString());
      cart[productId] = !cart[productId]!;
      emit(ErorrChangeCartShopState());
    });
  }

  /// Get Product Cart Items
  CartModel? cartModel;
  void getCartItem() {
    emit(LoadingCartShopState());
    DioHelper.getData(
      url: CART,
      token: token
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      emit(SuccessCartShopState());
    }).catchError((e) {
      print(e.toString());
      emit(ErorrCartShopState());
    });
  }
}
