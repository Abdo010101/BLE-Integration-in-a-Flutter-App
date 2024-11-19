import 'package:ble/core/routing/app_router.dart';
import 'package:ble/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'BLE',
            theme: ThemeData(
              // primarySwatch: AppUI.primaryMaterialColor,
              // textTheme: GoogleFonts.poppinsTextTheme(
              //   Theme.of(context).textTheme,
              // ),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                  titleSpacing: 0,
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  elevation: 0,
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
            ),
            initialRoute: Routes.homeScreen,
            onGenerateRoute: appRouter.generateRoute,
          );
        });
  }
}
