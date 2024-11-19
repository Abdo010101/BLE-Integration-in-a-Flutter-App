import 'package:ble/Feature/Home/logic/home_cubit.dart';

import 'package:dio/dio.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setUp() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  // FlutterReactiveBle ble =FlutterReactiveBle();
  // getIt.registerSingleton<FlutterReactiveBle>(ble);
  getIt.registerSingleton<SharedPreferences>(pref);
 getIt.registerSingleton<FlutterReactiveBle>(FlutterReactiveBle());
  getIt.registerLazySingleton<BottomNavbarCubit>(() => BottomNavbarCubit(getIt<FlutterReactiveBle>()));

  // // login di
  // getIt.registerLazySingleton<LoginApiService>(() => LoginApiService(dio));
  // getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  // getIt.registerLazySingleton<LoginCubit>(() => LoginCubit(getIt()));
  // // SignUp di
  // getIt.registerLazySingleton<SignUpApiService>(() => SignUpApiService(dio));
  // getIt.registerLazySingleton<SignUpRepo>(() => SignUpRepo(getIt()));
  // getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt()));
}
