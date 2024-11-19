import 'dart:developer';
import 'dart:io';

import 'package:ble/Feature/Home/logic/home_cubit.dart';
import 'package:ble/Feature/Home/logic/home_state.dart';
import 'package:ble/Feature/Home/view/widgets/custom_bottom_nav_bar.dart';
import 'package:ble/core/di/dependency_injection.dart';
import 'package:ble/core/service/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    requestBluetoothPermission();
  }
  

  void requestBluetoothPermission() async {
    PermissionStatus status = await Permission.bluetooth.status;

    LocatoinService locatoinService = LocatoinService();
    await locatoinService.getmMyLoaction();
    if (Platform.isAndroid) {
      Map<Permission, PermissionStatus> blePermissions = await [
        Permission.bluetooth,
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
      ].request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomNavbarCubit>(
      create: (context) => getIt.get<BottomNavbarCubit>()..startScan(),
      child: BlocBuilder<BottomNavbarCubit, BleState>(
        builder: (context, state) {
          var cubit = context.read<BottomNavbarCubit>();

          return Scaffold(
            body: cubit.pages[cubit.selectedIndex],
            bottomNavigationBar:
                Builder(builder: (BuildContext scaffoldContext) {
              return CustomBottomNavBar(
                selectedIndex: cubit.selectedIndex,
                onItemTapped: (index) {
                  cubit.onItemTapped(index);
                },
              );
            }),
          );
        },
      ),
    );
  }
}
