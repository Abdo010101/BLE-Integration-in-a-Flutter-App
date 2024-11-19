import 'package:ble/Feature/Home/view/home_screen.dart';
import 'package:ble/Feature/ConnectedDevice/view/connect_device_screen.dart';
import 'package:ble/core/routing/routes.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case Routes.connectedDeviceScreen:
        String id = arguments as String;
        return MaterialPageRoute(
            builder: (_) => ConnectDeviceScreen(
                  deviceId: id,
                ));

      default:
        return null;
    }
  }
}
