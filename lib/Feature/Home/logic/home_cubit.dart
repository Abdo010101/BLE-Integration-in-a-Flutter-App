import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:ble/Feature/Home/logic/home_state.dart';
import 'package:ble/Feature/Home/view/widgets/near_by_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BottomNavbarCubit extends Cubit<BleState> {

  final FlutterReactiveBle _ble;
  late Stream<DiscoveredDevice> _scanStream;
  Stream<ConnectionStateUpdate>? _connectionStream;
  QualifiedCharacteristic? _characteristic;

  BottomNavbarCubit(this._ble) : super(BleInitial());
  String? connectedDeviceId; // Store the connected device ID

  final random = Random();
// In BottomNavbarCubit

  int selectedIndex = 0;
  List<Widget> pages = [
    NearByWidget(),
    NearByWidget(),
  ];

  void onItemTapped(int index) {
    emit(BottomNavTappedStateLoading());
    selectedIndex = index;
    emit(BottomNavTappedStateSuccees());
  }

  ////*****-******** Scan All Devices Nearby       ***************************************************************** */

  /// Scan for BLE devices
  void startScan() {
    emit(BleScanning());
    final List<Map<String, String>> devices = [];

    _scanStream = _ble.scanForDevices(withServices: []);
    _scanStream.listen((device) {
      if (!devices.any((d) => d['id'] == device.id)) {
        devices.add({'id': device.id, 'name': device.name});
        emit(BleScanResults(devices));
      }
    }, onError: (error) {
      emit(BleError("Scan failed: $error"));
    });
  }

  Future<List<DiscoveredService>> discoverDeviceServices(
      String deviceId) async {
    try {
      final services = await _ble.discoverServices(deviceId);
      emit(BleServicesDiscovered(services));
      return services;
    } catch (error) {
      emit(BleConntectedError("Error discovering services: $error"));
      return [];
    }
  }

  //*** Connect Specific Device *************************************************************************** */
  StreamSubscription<DeviceConnectionState>? _connectionSubscription;

  /// Connect to a BLE device
  void connectToDevice(String deviceId) {
    // If there is an existing connection, disconnect it first
    _connectionSubscription?.cancel();

    connectedDeviceId = deviceId;
    emit(BleConnecting());

    _connectionStream = _ble.connectToDevice(
      id: deviceId,
      connectionTimeout: const Duration(seconds: 10),
    );

    _connectionStream?.listen((connection) {
      if (connection.connectionState == DeviceConnectionState.connected) {
        connectedDeviceId = deviceId;
        emit(BleConnected(deviceId));
      } else if (connection.connectionState ==
          DeviceConnectionState.disconnected) {
        connectedDeviceId = null;
        emit(BleDisconnected(deviceId));
      }
    }, onError: (error) {
      emit(BleConntectedError("Connection failed: $error"));
    });
  }

  ////////*** Sned  Data into ***************************/
  /// Send data to the device
  Future<void> sendData(
      {required String devicdeId,
      required String serviceUuid,
      required String characteristicUuid,
      required Map<String, dynamic> data}) async {
    try {
      emit(SendingDataLoading());
      _characteristic = QualifiedCharacteristic(
        serviceId: Uuid.parse(serviceUuid),
        characteristicId: Uuid.parse(characteristicUuid),
        deviceId: devicdeId,
      );

      final jsonData = jsonEncode(data);
      await _ble.writeCharacteristicWithResponse(
        _characteristic!,
        value: utf8.encode(jsonData),
      );
      emit(SendingDataSuccess());
    } catch (error) {
      emit(SendingDataErro("Failed to send data: $error"));
    }
  }

  /// Receive data from the device
  void receiveData(String serviceUuid, String characteristicUuid) {
    try {
      _characteristic = QualifiedCharacteristic(
        serviceId: Uuid.parse(serviceUuid),
        characteristicId: Uuid.parse(characteristicUuid),
        deviceId: _characteristic!.deviceId,
      );

      _ble.subscribeToCharacteristic(_characteristic!).listen((data) {
        emit(BleDataReceived(utf8.decode(data)));
      }, onError: (error) {
        emit(BleError("Failed to receive data: $error"));
      });
    } catch (error) {
      emit(BleError("Receive data failed: $error"));
    }
  }

  // /// Disconnect from the device
  Future<void> disconnectDevice(String deviceId) async {
    _connectionSubscription?.cancel(); // Cancel the subscription to disconnect
    connectedDeviceId = null;
    emit(BleDisconnected(deviceId));
  }
}
