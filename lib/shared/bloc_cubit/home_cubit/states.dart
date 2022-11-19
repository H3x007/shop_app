import 'package:shop_app/models/change_cart_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';

abstract class ShopStates{}
class InitialShopState extends ShopStates{}

/// Change NavBar State
class ChangeBottomNavBarState extends ShopStates {}

/// Change Theme Mode
class ChangeThemeModeState extends ShopStates {}

/// Home Data State
class LoadingHomeDataShopState extends ShopStates {}
class SuccessHomeDataShopState extends ShopStates {}
class ErorrHomeDataShopState extends ShopStates {}

/// Categories State
class SuccessCategoriesShopState extends ShopStates {}
class ErorrCategoriesShopState extends ShopStates {}


/// ChangeFavorites State
class ChangeFavoritesShopState extends ShopStates {}
class SuccessChangeFavoritesShopState extends ShopStates {
  final ChangeFavoritesModel changeFavoritesModel;
  SuccessChangeFavoritesShopState(this.changeFavoritesModel);
}
class ErorrChangeFavoritesShopState extends ShopStates {}


/// Favorites State
class SuccessFavoritesShopState extends ShopStates {}
class LoadingFavoritesShopState extends ShopStates {}
class ErorrFavoritesShopState extends ShopStates {}

/// Profile State
class LoadingProfileShopState extends ShopStates {}
class SuccessProfileShopState extends ShopStates {}
class ErorrProfileShopState extends ShopStates {}

/// Update Profile State
class LoadingUpdateProfileShopState extends ShopStates {}
class SuccessUpdateProfileShopState extends ShopStates {}
class ErorrUpdateProfileShopState extends ShopStates {}


/// ChangeCart State
class SuccessChangeCartShopState extends ShopStates {
  final ChangeCartModel changeCartModel;
  SuccessChangeCartShopState(this.changeCartModel);
}
class ErorrChangeCartShopState extends ShopStates {}


/// Get Product Cart State
class LoadingCartShopState extends ShopStates {}
class SuccessCartShopState extends ShopStates {}
class ErorrCartShopState extends ShopStates {}