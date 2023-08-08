import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sopping_app/layout/cubit/states.dart';
import 'package:sopping_app/models/categories_model.dart';
import 'package:sopping_app/models/change_favorites_model.dart';
import 'package:sopping_app/models/favorites_model.dart';
import 'package:sopping_app/models/home_model.dart';
import 'package:sopping_app/models/login_model.dart';
import 'package:sopping_app/modules/cateogries/cateogries_screen.dart';
import 'package:sopping_app/modules/favorites/favorites_screen.dart';
import 'package:sopping_app/modules/products/product_screen.dart';
import 'package:sopping_app/modules/settings/settings_screen.dart';
import 'package:sopping_app/shared/component/constants.dart';
import 'package:sopping_app/shared/network/end_point.dart';
import 'package:sopping_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  FavoritesModel? favoritesModel;
  ChangeFavoritesModel? changeFavoritesModel;
  LoginModel? userModel;

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen = [
    const ProductScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen()
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  Map<int, bool> favorite = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      // printFullText(homeModel?.data.banners[0].image.toString());

      homeModel!.data.products.forEach((element) {
        favorite.addAll({element.id: element.inFavorites});
      });
      log(favorite.toString(), name: 'favorite');

      emit(ShopSuccessHomeDataState());
    }).catchError((error, stackTrace) {
      emit(ShopErrorHomeDataState());
      log(error);
      log(stackTrace);
    });
  }

  void getCategories() {
    DioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      // printFullText(homeModel?.data.banners[0].image.toString());

      emit(ShopSuccessCategoriesState());
    }).catchError((error, stackTrace) {
      emit(ShopErrorCategoriesState());
      log(error);
      log(stackTrace);
    });
  }

  void changeFavorites(int productId) {
    favorite[productId] = !favorite[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
            url: FAVORITES, data: {'product_id': productId}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      log(value.data.toString());

      if (!changeFavoritesModel!.status) {
        favorite[productId] = !favorite[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorite[productId] = !favorite[productId]!;
      emit(ShopErrorFavoritesState());
    });
  }

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      log(value.data.toString());
      // printFullText(homeModel?.data.banners[0].image.toString());

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error, stackTrace) {
      emit(ShopErrorGetFavoritesState());
      log(error);
      log(stackTrace);
    });
  }

  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userModel = LoginModel.fromJson(value.data);
      log(userModel!.data!.name);
      // printFullText(homeModel?.data.banners[0].image.toString());

      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error, stackTrace) {
      emit(ShopErrorUserDataState());
      log(error);
      log(stackTrace);
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(url: UPDATE_PROFILE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      userModel = LoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      // printFullText(homeModel?.data.banners[0].image.toString());

      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error, stackTrace) {
      emit(ShopErrorUpdateUserState());
      print(error.toString());
      print(stackTrace.toString());
    });
  }
}
