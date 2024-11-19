import 'package:ble/Feature/Home/logic/home_cubit.dart';
import 'package:ble/Feature/Home/logic/home_state.dart';
import 'package:ble/Feature/ConnectedDevice/view/connect_device_screen.dart';
import 'package:ble/core/theming/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({super.key, required this.state});
  final BleScanResults state;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.devices.length,
      itemBuilder: (context, index) {
        final device = state.devices[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.amber.withOpacity(0.1)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green.withOpacity(0.3),
                radius: 22,
                child: Text(
                  String.fromCharCode(
                      context.read<BottomNavbarCubit>().random.nextInt(26) +
                          65),
                  style: TextStyles.font15DarkBlueMedium
                      .copyWith(color: Colors.white),
                ),
              ),
              trailing: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black, // Background color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<
                              BottomNavbarCubit>(), // Pass the existing Cubit instance
                          child: ConnectDeviceScreen(deviceId: device['id']!),
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Connect',
                    style: TextStyle(color: Colors.white),
                  )),
              title: Text(device['name'] ?? "Unknown Device"),
              subtitle: Text(device['id'].toString()),
              onTap: () {},
            ),
          ),
        );
      },
    );
  }
}
