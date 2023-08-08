import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sopping_app/models/login_model.dart';
import 'package:sopping_app/modules/register/cubit/states.dart';
import 'package:sopping_app/shared/network/end_point.dart';
import 'package:sopping_app/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  late LoginModel loginModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    log('enter loading register', name: 'loading register cubit');
    emit(ShopRegisterLoadingState());

    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      print(value.data); //must print not log

      loginModel = LoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error, stackTrace) {
      emit(ShopRegisterErrorState(error));
      print(error);
      print(stackTrace);
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibilityState());
  }
}
