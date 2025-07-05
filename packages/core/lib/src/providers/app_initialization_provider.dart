import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/device_info_service.dart';

final appInitializationProvider = FutureProvider<void>((ref) async {
  await ref.read(deviceInfoServiceProvider.future);
});
