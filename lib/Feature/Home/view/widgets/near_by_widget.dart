import 'dart:developer';
import 'dart:math';

import 'package:ble/Feature/Home/logic/home_cubit.dart';
import 'package:ble/Feature/Home/logic/home_state.dart';
import 'package:ble/Feature/Home/view/widgets/list_item_widget.dart';
import 'package:ble/Feature/ConnectedDevice/view/connect_device_screen.dart';
import 'package:ble/core/di/dependency_injection.dart';

import 'package:ble/core/theming/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NearByWidget extends StatelessWidget {
  const NearByWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<BottomNavbarCubit>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.withOpacity(0.4),
          centerTitle: true,
          title: Text(
            'Near By Bluetooth',
            style: TextStyles.font16WhiteMedium,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<BottomNavbarCubit>().startScan();
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<BottomNavbarCubit, BleState>(
                buildWhen: (previous, current) =>
                    current is BleError ||
                    current is BleScanResults ||
                    current is BleScanning,
                bloc: context.read<BottomNavbarCubit>(),
                builder: (context, state) {
                  if (state is BleError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is BleScanResults) {
                    return ListItemWidget(state: state,);
                  }
                  if (state is BleScanning) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
