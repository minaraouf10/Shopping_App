import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sopping_app/layout/cubit/cubit.dart';
import 'package:sopping_app/layout/cubit/states.dart';
import 'package:sopping_app/layout/shop_layout.dart';
import 'package:sopping_app/modules/login/login_screen.dart';
import 'package:sopping_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:sopping_app/shared/component/constants.dart';
import 'package:sopping_app/shared/component/observer.dart';
import 'package:sopping_app/shared/styles/themes.dart';

import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);

  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(onBoarding: onBoarding, startWidget: widget));
}

class MyApp extends StatelessWidget {
  final bool onBoarding;
  final Widget startWidget;

  MyApp({required this.onBoarding, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getHomeData()
        ..getCategories()
        ..getFavorites()
        ..getUserData(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: ShopLoginScreen(),
          );
        },
      ),
    );
  }
}
