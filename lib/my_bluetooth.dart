import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothService extends GetxService {
  // 单例获取
  static BluetoothService get to => Get.find<BluetoothService>();

  /// 监听蓝牙是否开启
  final RxBool isBluetoothOn = false.obs;

  /// 是否正在扫描设备
  final RxBool isScanning = false.obs;

  /// 扫描到的设备列表
  final RxList<ScanResult> scanResults = <ScanResult>[].obs;

  /// 是否有蓝牙权限
  final RxBool isBluetoothPermissionGranted = false.obs;

  // 内部订阅，方便关闭时取消
  StreamSubscription<BluetoothAdapterState>? stateSubscription;
  StreamSubscription<List<ScanResult>>? scanResultsSubscription;

  @override
  void onInit() {
    super.onInit();
    initBluetooth();
  }

  /// 初始化蓝牙服务：检查权限并监听状态
  Future<void> initBluetooth() async {
    await _checkAndRequestPermissions();
    _listenToBluetoothState();
  }

  /// 检查并申请蓝牙相关权限
  Future<void> _checkAndRequestPermissions() async {
    // 检查蓝牙、蓝牙扫描和蓝牙连接权限
    if (await Permission.bluetooth.isDenied ||
        await Permission.bluetoothScan.isDenied ||
        await Permission.bluetoothConnect.isDenied) {
      final data = await [
        Permission.bluetooth,
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
      ].request();
      print("我正在请求蓝牙权限");
      isBluetoothPermissionGranted.value =
          data[Permission.bluetooth]!.isGranted ||
              data[Permission.bluetoothScan]!.isGranted ||
              data[Permission.bluetoothConnect]!.isGranted;
    } else {
      isBluetoothPermissionGranted.value = true;
    }
  }

  /// 监听蓝牙状态变化
  void _listenToBluetoothState() {
    if (!kIsWeb && Platform.isAndroid && !isBluetoothOn.value) {
      _turnOnBluetooth();
    }
    stateSubscription ??= FlutterBluePlus.adapterState
        .listen((BluetoothAdapterState state) async {
      if (state == BluetoothAdapterState.on) {
        // 蓝牙开启时
        isBluetoothOn.value = true;
      } else {
        // 蓝牙关闭时
        isBluetoothOn.value = false;
        if (!kIsWeb && Platform.isAndroid) {
          await _turnOnBluetooth();
        }
      }
    });
  }

  /// 尝试开启蓝牙（仅限 Android）
  Future<void> _turnOnBluetooth() async {
    print('尝试开启蓝牙');

    if (isBluetoothPermissionGranted.value) {
      try {
        await FlutterBluePlus.turnOn();
        print('Bluetooth is turned on');
      } catch (e) {
        print('Error turning on Bluetooth: $e');
      }
    } else {
      print('没有蓝牙权限');
    }
  }

  /// 开始扫描设备
  Future<void> startScanning() async {
    if (isBluetoothOn.value && !isScanning.value) {
      isScanning.value = true;
      scanResultsSubscription ??= FlutterBluePlus.scanResults.listen((results) {
        scanResults.value = results;
      });
      FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));
    }
  }

  /// 停止扫描
  void stopScanning() {
    if (isScanning.value) {
      isScanning.value = false;
      FlutterBluePlus.stopScan();
      scanResultsSubscription?.cancel();
      scanResultsSubscription = null;
    }
  }

  @override
  void onClose() {
    // 取消订阅，防止内存泄漏
    stateSubscription?.cancel();
    scanResultsSubscription?.cancel();
    super.onClose();
  }
}
