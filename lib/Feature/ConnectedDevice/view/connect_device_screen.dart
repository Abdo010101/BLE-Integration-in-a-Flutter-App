import 'dart:developer';

import 'package:ble/Feature/Home/logic/home_cubit.dart';
import 'package:ble/Feature/Home/logic/home_state.dart';
import 'package:ble/Feature/ConnectedDevice/view/widgets/connecting_widget.dart';
import 'package:ble/Feature/ConnectedDevice/view/widgets/connted_widget.dart';
import 'package:ble/Feature/ConnectedDevice/view/widgets/disconnecting_widget.dart';
import 'package:ble/Feature/ConnectedDevice/view/widgets/loading_widget.dart';
import 'package:ble/core/di/dependency_injection.dart';
import 'package:ble/core/theming/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectDeviceScreen extends StatelessWidget {
  final String deviceId;

  const ConnectDeviceScreen({super.key, required this.deviceId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.withOpacity(0.4),
        centerTitle: true,
        title: Text(
          'Near By Bluetooth',
          style: TextStyles.font16WhiteMedium,
        ),
      ),
      body: BlocListener<BottomNavbarCubit, BleState>(
        listenWhen: (prev, curr) =>
            curr is SendingDataSuccess || curr is SendingDataErro,
        listener: (context, state) {
          if (state is SendingDataSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("data Send Good")));
          } else if (state is SendingDataErro) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Error In Sending data")));
          }
        },
        child: BlocBuilder<BottomNavbarCubit, BleState>(
          buildWhen: (pre, curr) =>
              curr is BleConnected ||
              curr is BleConntectedError ||
              curr is BleDisconnected ||
              curr is BleConnecting ||
              curr is BleServicesDiscovered,
          bloc: context.read<BottomNavbarCubit>()..connectToDevice(deviceId),
          builder: (context, state) {
            if (state is BleConntectedError) {
              return Text(
                state.error,
                style: TextStyles.font13DarkBlueMedium,
              );
            }
            if (state is BleConnected) {
              context
                  .read<BottomNavbarCubit>()
                  .discoverDeviceServices(deviceId);

              return const LoadingWidget();
            }
            if (state is BleServicesDiscovered) {
              final service = state.services.first;
              final characteristic = service.characteristics.first;

              return ConntedWidget(
                state: state,
                deviceId: deviceId,
                service: service,
                characteristic: characteristic,
              );
            }
            if (state is BleDisconnected) {
              return const DisconnectingWidget();
            }
            if (state is BleConnecting) {
              return const ConnectingWidget();
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
