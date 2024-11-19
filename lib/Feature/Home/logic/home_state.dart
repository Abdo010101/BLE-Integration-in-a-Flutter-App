import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

abstract class BleState {}

class BleInitial extends BleState {}

class BottomNavTappedStateLoading extends BleState {}

class BottomNavTappedStateSuccees extends BleState {}

class BleScanning extends BleState {}

class BleScanResults extends BleState {
  final List<Map<String, String>> devices;

  BleScanResults(this.devices);
}

class BleConnecting extends BleState {}

class BleConnected extends BleState {
  final String deviceId;

  BleConnected(this.deviceId);
}

class BleDisconnected extends BleState {
  final String deviceId;

  BleDisconnected(this.deviceId);
}

class BleConntectedError extends BleState {
  final String error;

  BleConntectedError(this.error);
}

class BleServicesDiscovered extends BleState {
  final List<DiscoveredService> services;

  BleServicesDiscovered(this.services);
}

class BleDataReceived extends BleState {
  final String data;

  BleDataReceived(this.data);
}

class BleError extends BleState {
  final String message;

  BleError(this.message);
}

class SendingDataLoading extends BleState {}

class SendingDataSuccess extends BleState {}

class SendingDataErro extends BleState {
  final String message;

  SendingDataErro(this.message);
}



// part 'home_state.freezed.dart';

// @freezed
// class BottomNavbarState {
//   const factory BottomNavbarState.initial() = _Inital;

//   const factory BottomNavbarState.bottomNavTappedStateLoading() =
//       BottomNavTappedStateLoading;

//   const factory BottomNavbarState.bottomNavTappedState() = BottomNavTappedState;

//   const factory BottomNavbarState.addToCartLoading() = AddToCartLoading;

  



// }
