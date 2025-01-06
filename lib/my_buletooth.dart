// import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// //
// class BluetoothManager {
//   final FlutterBluePlus _flutterBlue = FlutterBluePlus.instance;

//   // 检查蓝牙状态并请求开启
//   Future<bool> enableBluetooth() async {
//     if (!await _flutterBlue.isOn) {
//       print("Bluetooth is off. Please turn it on.");
//       return false;
//     }
//     return true;
//   }

//   // 扫描设备，筛选出符合条件的设备
//   Future<List<BluetoothDevice>> scanForDevices({String? filterName}) async {
//     List<BluetoothDevice> devices = [];

//     // 开始扫描
//     _flutterBlue.startScan(timeout: const Duration(seconds: 5));

//     // 监听扫描结果
//     _flutterBlue.scanResults.listen((results) {
//       for (ScanResult result in results) {
//         final device = result.device;
//         // 筛选设备
//         if (filterName == null || device.name.contains(filterName)) {
//           if (!devices.contains(device)) {
//             devices.add(device);
//           }
//         }
//       }
//     });

//     // 等待扫描结束
//     await Future.delayed(const Duration(seconds: 5));
//     _flutterBlue.stopScan();

//     return devices;
//   }

//   // 连接到设备
//   Future<void> connectToDevice(BluetoothDevice device) async {
//     try {
//       print("Connecting to ${device.name}...");
//       await device.connect(autoConnect: false);
//       print("Connected to ${device.name}");
//     } catch (e) {
//       print("Failed to connect: $e");
//     }
//   }

//   // 获取设备的服务和特征
//   Future<List<BluetoothService>> discoverServices(BluetoothDevice device) async {
//     print("Discovering services for ${device.name}...");
//     return await device.discoverServices();
//   }

//   // 向蓝牙设备发送数据
//   Future<void> sendCommand(BluetoothDevice device, String command) async {
//     // 假设你有一个目标服务和特征的 UUID
//     final targetServiceUuid = Guid("YOUR_SERVICE_UUID");
//     final targetCharacteristicUuid = Guid("YOUR_CHARACTERISTIC_UUID");

//     // 获取服务
//     List<BluetoothService> services = await discoverServices(device);
//     for (BluetoothService service in services) {
//       if (service.uuid == targetServiceUuid) {
//         for (BluetoothCharacteristic characteristic in service.characteristics) {
//           if (characteristic.uuid == targetCharacteristicUuid) {
//             // 写入数据到特征
//             print("Sending command: $command");
//             await characteristic.write(command.codeUnits, withoutResponse: true);
//             print("Command sent!");
//             return;
//           }
//         }
//       }
//     }

//     print("Target characteristic not found.");
//   }

//   // 断开设备连接
//   Future<void> disconnectDevice(BluetoothDevice device) async {
//     print("Disconnecting from ${device.name}...");
//     await device.disconnect();
//     print("Disconnected.");
//   }
// }
