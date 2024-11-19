import 'package:ble/bloc_observer.dart';
import 'package:ble/core/di/dependency_injection.dart';
import 'package:ble/core/routing/app_router.dart';
import 'package:ble/core/service/location_service.dart';
import 'package:ble/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
 // await Permission.bluetooth.request();

  await setUp();
  // To fix texts being hidden bug in flutter_screenutil in release mode.
  await ScreenUtil.ensureScreenSize();

  Bloc.observer = MyBlocObserver();
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}
