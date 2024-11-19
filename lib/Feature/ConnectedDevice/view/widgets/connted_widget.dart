import 'package:ble/Feature/Home/logic/home_cubit.dart';
import 'package:ble/Feature/Home/logic/home_state.dart';
import 'package:ble/core/theming/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConntedWidget extends StatelessWidget {
  const ConntedWidget(
      {super.key,
      required this.characteristic,
      required this.service,
       required this.deviceId,
      required this.state});
  final dynamic service;
  final dynamic characteristic;
  final BleServicesDiscovered state;
  final String deviceId;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Connected to ",
              style: TextStyles.font13DarkBlueMedium,
            ),
            const SizedBox(height: 10),
            Text(
              "Service UUID: ",
              style: TextStyles.font13DarkBlueMedium,
            ),
            Text(
              "${service.serviceId}",
              style: TextStyles.font12DarkBlueMeduim,
            ),
            Text(
              "Characteristic UUID: ",
              style: TextStyles.font13DarkBlueMedium,
            ),
            Text(
              "${characteristic.characteristicId}",
              style: TextStyles.font12DarkBlueMeduim,
            ),
            const SizedBox(height: 20),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onPressed: () {
                context.read<BottomNavbarCubit>().sendData(
                  devicdeId: deviceId,
                  serviceUuid: service.serviceId.toString(),
                  characteristicUuid:
                      characteristic.characteristicId.toString(),
                  data: {"command": "start", "value": 42},
                );
              },
              child: Text(
                state is SendingDataLoading ? 'Loading..' : 'Send Data',
                style: TextStyles.font13DarkBlueMedium
                    .copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
