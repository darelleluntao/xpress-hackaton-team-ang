import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_info_service.g.dart';

class DeviceInfo {
  final String deviceId;
  final String deviceName;
  final String deviceModel;
  final String osVersion;
  final Position? location;

  DeviceInfo({
    required this.deviceId,
    required this.deviceName,
    required this.deviceModel,
    required this.osVersion,
    this.location,
  });
}

@riverpod
class DeviceInfoService extends _$DeviceInfoService {
  @override
  Future<DeviceInfo> build() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    String deviceId;
    String deviceName;
    String deviceModel;
    String osVersion;

    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      deviceId = androidInfo.id;
      deviceName = androidInfo.brand;
      deviceModel = androidInfo.model;
      osVersion = androidInfo.version.release;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? 'Unknown';
      deviceName = iosInfo.name;
      deviceModel = iosInfo.model;
      osVersion = iosInfo.systemVersion;
    } else {
      deviceId = 'Unknown';
      deviceName = 'Unknown';
      deviceModel = 'Unknown';
      osVersion = 'Unknown';
    }

    // Get location
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return DeviceInfo(
      deviceId: deviceId,
      deviceName: deviceName,
      deviceModel: deviceModel,
      osVersion: osVersion,
      location: position,
    );
  }

  Future<void> refreshLocation() async {
    try {
      final location = await Geolocator.getCurrentPosition();
      state = AsyncData(
        DeviceInfo(
          deviceId: state.value!.deviceId,
          deviceName: state.value!.deviceName,
          deviceModel: state.value!.deviceModel,
          osVersion: state.value!.osVersion,
          location: location,
        ),
      );
    } catch (e) {
      // Location error, keep existing state
    }
  }
}
